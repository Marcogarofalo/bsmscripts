#include <stdlib.h>
#include <stdio.h>
#include <math.h>
#include <time.h>
#include <string.h>
#include <complex.h>
#include <iostream>

#include <fstream>

#define NAMESIZE 1000
using namespace std;



int main(int argc, char **argv){
    
    if(argc!=2) {  printf( "usage:./quinck_mass  file"); exit(0);}
    char namefile[NAMESIZE];
    sprintf(namefile,"%s",argv[1]); 
    FILE *infile=fopen(namefile,"r");     

   int count=0;
    string line;
    ifstream file(argv[1]);
    while (getline(file, line))
        count++;
 
//    cout << "Numbers of lines in the file : " << count << endl;
    if (count==0){
       printf("35000  0\n");
       return 0;
    }

    double *d=(double*) malloc(sizeof(double)*count);
    double mean=0;
    double sigma=0;
    for (int i =0;i<count ;i++){
        fscanf(infile,"%lf",&d[i]);
        mean+=d[i];
    }
    mean/=(double)count;
    for (int i =0;i<count ;i++){
        sigma += (d[i]-mean)*( d[i] -mean);
        
    } 
    sigma/=(double) (count-1);
    sigma=sqrt(sigma);
    printf("%g   %g\n",mean,sigma);
    return 0;
}
