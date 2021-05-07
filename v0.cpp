#include <iostream>
#include <complex>
#include <cmath>
#include <cstdio>
#include <cstdlib>
#include <cstring>

#include <getopt.h>

using namespace std;

// global lattice data
int L0, L1, L2, L3, V;
int verbose;
char* input_filename;
char* output_filename;

double* phi_field;

// imagninary element
static const std::complex<double> I (0.0, 1.0);

void read_phi_field (const int size, char* filename, double *in);
void write_phi_field (const int size, char* filename, double *in);
void rotate_phi_field (double *phi_in);
double get_angle (double x, double y);
void rotate_phi_field_component (double *phi_in, int ind1, int ind2, double w);
void get_phi_field_direction (double *phi_in, double *dir, int write);
void usage();
void finalize();
void parse_args_and_init(int argc, char** argv);

// TODO: add verbosity argument
int main (int argc, char** argv) {
  int verbose = 0;

  parse_args_and_init(argc,argv); 
  // reading phi field configuration
  for (int i = 0; i < (4 * V + 1); ++i)
    phi_field[i] = 0.0;

  for (int i = 0; i < V; ++i)
    phi_field[4 * i] = 1.0;

  read_phi_field(4 * V + 1, input_filename, phi_field);
  double weight = phi_field[4 * V];

  

  // computing vev
  double m = 0.0;
  for (int i = 0; i < V; ++i) {
    m += phi_field[4*i]  ;
  }
  FILE *file;
  file=fopen("vev","w+");
  fprintf (file,"%.15g", m / V);
  fclose(file);

  double *prop;
  int j,v3;
  
  v3=L1*L2*L3;
  prop=(double*) calloc(L0,sizeof(double));
  file=fopen("phit","w+");
  
  for (int t =0;t<L0;t++){
    	 for(int i=0; i<L1*L2*L3;i++){
             prop[t]+=phi_field[i*4+t*v3*4];  
     	}
  
  fprintf (file,"%.15g\n", prop[t]/((double) v3));
  }

  /*double phit1,phit2;
  int tt;
  for (int t =0;t<L0;t++){
    	for ( j=0; j<L0;j++){
           phit1=0;
           phit2=0;
           tt=(t+j)%L0;
           for(int i=0; i<L1*L2*L3;i++){
              phit1+=phi_field[i*4+j*v3*4];            
              phit2+=phi_field[i*4+tt*v3*4];            
     	   }
           prop[t]+=phit1*phit2;  
        }
        fprintf (file,"%.15g\n", prop[t]/((double) v3*v3*L0));
  }*/

  fclose(file);

  finalize();
  return 0;
}

void usage(){
  printf("usage: rotatephi -i<infile> -o<outfile> -L<int> -T<int>\n");
}

void parse_args_and_init(int argc, char** argv){
  input_filename = (char*)calloc(500,sizeof(char));
  output_filename = (char*)calloc(500,sizeof(char));
  int c;
  
  if(argc<5){
    usage();
    exit(1);
  }
  while ((c = getopt(argc, argv, "h?i:o:L:T:")) != -1) {
    switch (c) {
      case 'L':
        L1 = L2 = L3 = atoi(optarg);
        break;
      case 'T':
        L0 = atoi(optarg);
        break;
      case 'i':
        strncpy(input_filename, optarg, 500);
        break;
      case 'o':
        strncpy(output_filename, optarg, 500);
        break;
      case 'h':
      case '?':
      default:
        usage();
        break;
    }
  }
  V = L0 * L1 * L2 * L3;
  phi_field = (double*)calloc(4*V+1,sizeof(double));
}

void finalize() {
  free(input_filename);
  free(output_filename);
  free(phi_field);
}

/******************************************************************************/
/******************************************************************************/
/******************************************************************************/
void read_phi_field (const int size, char* filename, double *in) {

  FILE *f;

  f = fopen
    (filename,
     "rb");
  if (f) {
    fread (in, sizeof(double), size, f);
    printf ("\nReading phi field configuration was successful!\n");
    fclose(f);
  }
  else{
    printf ("\n\nCANNOT OPEN PHI FIELD CONFIGURATION FILE %s !\n\n",filename);
    exit (0);
  }
}

void write_phi_field (const int size, char* filename, double *in){
  FILE *f;

  f = fopen
    (filename,
     "wb");
  if (f) {
    size_t num = fwrite (in, sizeof(double), size, f);
    printf ("Writing %u doubles to %s was successful!\n",num,filename);
    fclose(f);
  }
  else{
    printf ("\n\nCANNOT OPEN PHI FIELD CONFIGURATION FILE %s !\n\n",filename);
    exit (0);
  }
}
/******************************************************************************/
/******************************************************************************/
/******************************************************************************/
void rotate_phi_field (double *phi_in) {

  double angle;
  double *dir = new double[4];

  get_phi_field_direction (phi_in, dir, 1);
  angle = get_angle (dir[1], dir[0]);
  rotate_phi_field_component (phi_in, 1, 0, -angle);

  get_phi_field_direction (phi_in, dir, 0);
  angle = get_angle (dir[2], dir[0]);
  rotate_phi_field_component (phi_in, 2, 0, -angle);

  get_phi_field_direction (phi_in, dir, 0);
  angle = get_angle (dir[3], dir[0]);
  rotate_phi_field_component (phi_in, 3, 0, -angle);

  get_phi_field_direction (phi_in, dir, 1);
}
/******************************************************************************/
/******************************************************************************/
/******************************************************************************/
double get_angle (const double x, const double y) {
  double d = sqrt (x * x + y * y);
  if (d < 1E-10)
    return 0;
  double w = asin (x / d);
  if (y < 0)
    w = M_PI - w;
  return w;
}
/******************************************************************************/
/******************************************************************************/
/******************************************************************************/
void rotate_phi_field_component (double *phi_in, const int ind1, const int ind2,
			                           const double w){
  double c = cos (w);
  double s = sin (w);

  int count = 0;
  for (int i = 0; i < (int) V; i++){
    double x = phi_in[count + ind1];
    double y = phi_in[count + ind2];
    phi_in[count + ind1] = c * x + s * y;
    phi_in[count + ind2] = -s * x + c * y;
    count += 4;
  }
}
/******************************************************************************/
/******************************************************************************/
/******************************************************************************/
void get_phi_field_direction (double *phi_in, double *dir, int write) {

  for (int i = 0; i < 4; ++i)
    dir[i] = 0.0;
  int counter = 0;
  for (int i = 0; i < (int) V; ++i) {
    dir[0] += phi_in[counter + 0];
    dir[1] += phi_in[counter + 1];
    dir[2] += phi_in[counter + 2];
    dir[3] += phi_in[counter + 3];
    counter += 4;
  }
  for (int i = 0; i < 4; ++i)
    dir[i] /= (double) V;
  if (write)
    printf ("Higgs-Field-Direction: (%e,%e,%e,%e)\n", dir[0], dir[1], dir[2], 
                                                                      dir[3]);
}


