#!/bin/bash
L=20
T=40
#etas="-1.0983 -1.1375 -1.2944"
#etas="-1.0983"
#etas="-1.1375"
#etas="-1.2944"
etas="0.0 -0.1 -1.0 "
#etas="-1.0"
#M02s=" -0.8 -0.4 0 0.4  "
#M02s="-1.2 -1.0 -0.8 -0.6 -0.4 -0.2 0 0.2 0.4 0.6"
#M02s=" -0.029604 -0.024604  0.010396 "
#M02s=" -0.010396  "
M02s=" 0.0  "
#M02s=" -0.040000  "
#M02s=" -0.024604  "
#M02s="-0.029604 "
#M02s="-1.2 -1.0"

#mu03s="0.0120 0.0224"
mu03s="0.0"
#mu03s="0.0224"
#mu03s="0.0120"

system="A3"
#rho="1"
#rho="1.008742"
#rho="1.96"
rho="0.98"
#rho="1.007170"
csws="1.0"

here=`pwd`
cd ..
#array=(019:220 020:540 021:860 022:1180 023:1500 024:1820 025:2140 026:2460 027:2780 028:3100 029:3420 030:3740 031:4060 032:4380 033:4700 034:5020 035:5340 036:5660 037:5980 038:6300 039:6620 040:6940 041:7260 042:7580 043:7900 044:8220 045:8540 046:8860 047:9180 048:9500 049:9820 050:10140 051:10460 052:10780 053:11100 054:11420 055:11740 056:12060 057:12380 058:12700 059:13020 060:13340 061:13660 062:13980 063:14300 064:14620 065:14940 066:15260 067:15580 068:15900 069:16220 070:16540 071:16860 072:17180 073:17500 074:17820 075:18140 076:18460 077:18780 078:19100)
#conf.0000 is a trivial gauge
array=(000:220 000:540 000:860)
array=(000:540 000:860)
array=(000:1180 000:1500 000:1820 000:2140 000:2460 000:2780 000:3100 000:3420 000:3740 000:4060 000:4380 000:4700)
#array=(000:5020 000:5340 000:5660 000:5980 000:6300 000:6620 000:6940 000:7260 000:7580 000:7900 000:8220 000:8540 000:8860 000:9180 000:9500 000:9820 000:10140 000:10460 000:10780 000:11100 000:11420 000:11740 000:12060 000:12380 000:12700 000:13020 000:13340 000:13660 000:13980 000:14300 000:14620 000:14940 000:15260 000:15580 000:15900 000:16220 000:16540 000:16860 000:17180 000:17500 000:17820 000:18140 000:18460 000:18780 000:19100)
#
#identity scalar
#array=(000:0)
# identity *0.1 scalar
#array=(000:1)
# identity *0.2 scalar
array=(000:2)
# identity *0.05 scalar
#array=(000:3)


lenght_array=${#array[@]}
lenght_array=$(( lenght_array-1))

ScalarsXoneGauge=1
#ScalarsXoneGauge=1
if [ $system = A2 ]
then 
nruns=4
else
nruns=1
fi
npergauge=$(( $ScalarsXoneGauge/$nruns   ))
distance_scalars=40

for eta in $etas
do

etam=`echo ${eta/\-/m}`


for M02 in $M02s
do 
for mu03 in $mu03s
do 

for csw in $csws
do
M02_decimal=`echo ${M02:2}`
mu03_decimal=`echo ${mu03:2}`

echo $eta $M02 $mu03 $etam $M02_decimal 

new_folder="eta_"$etam"_M02_"$M02"_mu03_"$mu03"_csw_"$csw"_rho"$rho"_trivialU_trivialphi0.2"
#new_folder="eta_"$etam"_M02_"$M02"_mu03_"$mu03"_csw_"$csw"_rho"$rho"_trivialU"
#new_folder="eta_"$etam"_M02_"$M02_decimal"_mu03_"$mu03_decimal"_rho"$rho"_lex"
current_folder=`pwd`
#current_folder="${current_folder/bsmscripts/}"
#new_folder="scalar0_eta_"$etam"_M02_"$M02_decimal"_mu03_"$mu03_decimal"_phi_double_smeared"
mkdir  $new_folder

############################
#RUN_create_dirs_templ_V0.csh
########################################
echo "#!/bin/sh" > $new_folder/RUN_create_dirs_templ_V0.csh

echo "foreach scal (SSS)" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "foreach conf (GGG)" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "mkdir conf.0\""\$"conf\"" >> $new_folder/RUN_create_dirs_templ_V0.csh

j=0
for i in `seq 1 $nruns`
do

echo "foreach run (N\""\$"scal\"_"$i")" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "mkdir conf.0\""\$"conf\"/run.\""\$"run\"" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "ln -sv $current_folder/gauges/confs/conf.0\""\$"conf\" conf.0\""\$"conf\"/run.\""\$"run\"/" >> $new_folder/RUN_create_dirs_templ_V0.csh
echo "ln -sv $current_folder/gauges/stout/conf.0\""\$"conf\" conf.0\""\$"conf\"/run.\""\$"run\"/conf_smeared.0\""\$"conf\"" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "echo ''" >> $new_folder/RUN_create_dirs_templ_V0.csh

for ii in `seq 0 $(( $npergauge-1))`
do
number=$(( (ii+j)* $distance_scalars ))
	echo "@ scalar_index= \$scal + $number " >> $new_folder/RUN_create_dirs_templ_V0.csh
	echo "ln -sv $current_folder/scalars/SCALAR_SMEARED_hc_nn_lex/scalar_smeared.\"\$scalar_index\" conf.0\""\$"conf\"/run.\""\$"run\"/scalar.0000000"$ii" " >> $new_folder/RUN_create_dirs_templ_V0.csh
#	echo "cp -v $current_folder/scalars_lex/T"$T".X"$L".Y"$L".Z"$L".kap0.130000.lam0.010000.rep_1.rot_no.conf\"\$scalar_index\" conf.0\""\$"conf\"/run.\""\$"run\"/scalar.0000000"$ii" " >> $new_folder/RUN_create_dirs_templ_V0.csh
done


echo "sed \"s/initialstorecounter = 0000/initialstorecounter = 0\""\$"conf\"/\" contractions.templ  >  contractions.input" >> $new_folder/RUN_create_dirs_templ_V0.csh
echo "mv contractions.input conf.0"\$"conf/run."\$"run/" >> $new_folder/RUN_create_dirs_templ_V0.csh


echo "sed \"s/"$new_folder"/"$new_folder"\\/conf.0\""\$"conf\"\\/run.\""\$"run\"/\" job.templ  >  job.qsub" >> $new_folder/RUN_create_dirs_templ_V0.csh
echo "mv job.qsub conf.0\""\$"conf\"/run.\""\$"run\"/" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "echo ''" >> $new_folder/RUN_create_dirs_templ_V0.csh
echo "echo '----------------------------------------------'" >> $new_folder/RUN_create_dirs_templ_V0.csh
echo "echo ''" >> $new_folder/RUN_create_dirs_templ_V0.csh

echo "end" >> $new_folder/RUN_create_dirs_templ_V0.csh

j=$(( $j+ $npergauge  ))
done

echo "end" >> $new_folder/RUN_create_dirs_templ_V0.csh
echo "end" >> $new_folder/RUN_create_dirs_templ_V0.csh

###################################
#RUN_create_dirs_pass_G_and_S.csh
###################################

echo "#!/bin/bash" > $new_folder/RUN_create_dirs_pass_G_and_S.csh

for i in `seq 0 $lenght_array`
do
	IFS=':' read -a split <<< ${array[$i]}

	#echo ${split[0]}  ${split[1]}
	echo "" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
	echo "foreach conf ("${split[0]}")" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
	echo "foreach scal ("${split[1]}")" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
	echo "sed \"s/GGG/\$conf/\" RUN_create_dirs_templ_V0.csh > RUN_create_dirs_templ_V1.csh" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh 
	echo "sed \"s/SSS/\$scal/\" RUN_create_dirs_templ_V1.csh > RUN_create_G\"\$conf\"_S\"\$scal\".csh" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh 
	echo "rm RUN_create_dirs_templ_V1.csh" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
        echo "echo ''" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
	echo "echo '---------------------------------------'" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
        echo "echo ''" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
        echo "end" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
        echo "csh RUN_create_G\"\$conf\"_S\"\$scal\".csh" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh
        echo "end" >> $new_folder/RUN_create_dirs_pass_G_and_S.csh


done

#########################à
#RUN_qsub_templ_V0.csh
#############################################################################################################
echo "#!/bin/sh" > $new_folder/RUN_qsub_templ_V0.csh

echo "foreach scal (SSS)" >> $new_folder/RUN_qsub_templ_V0.csh
echo "foreach eta ("$new_folder")" >> $new_folder/RUN_qsub_templ_V0.csh
echo "foreach conf (GGG)" >> $new_folder/RUN_qsub_templ_V0.csh

string="foreach run ("
for i in `seq 1 $nruns`
do
	string="$string N\""\$"scal\"_$i"
done
string="$string )"
echo "$string" >> $new_folder/RUN_qsub_templ_V0.csh

echo "cd  $current_folder/"$new_folder"/conf.0\""\$"conf\"/run.\""\$"run\"/" >> $new_folder/RUN_qsub_templ_V0.csh

#echo "sbatch job.qsub" >> $new_folder/RUN_qsub_templ_V0.csh

echo "if ( -f bsmcontractions.0\""\$"conf\".0.00000000 ) then">> $new_folder/RUN_qsub_templ_V0.csh
echo "echo contraction completed">> $new_folder/RUN_qsub_templ_V0.csh
echo "else">> $new_folder/RUN_qsub_templ_V0.csh
echo "    sbatch job.qsub">> $new_folder/RUN_qsub_templ_V0.csh
echo "endif">> $new_folder/RUN_qsub_templ_V0.csh

echo "end" >> $new_folder/RUN_qsub_templ_V0.csh
echo "end" >> $new_folder/RUN_qsub_templ_V0.csh
echo "end" >> $new_folder/RUN_qsub_templ_V0.csh
echo "end" >> $new_folder/RUN_qsub_templ_V0.csh

############################################################################################
#RUN_qsub_pass_G_and_S.csh
#############################################################################################################
echo "#!/bin/bash" > $new_folder/RUN_qsub_pass_G_and_S.csh

for i in `seq 0 $lenght_array`
do

	IFS=':' read -a split <<< ${array[$i]}
	#echo ${split[0]}  ${split[1]}
	echo "" >> $new_folder/RUN_qsub_pass_G_and_S.csh
	echo "foreach conf ("${split[0]}")" >> $new_folder/RUN_qsub_pass_G_and_S.csh
	echo "foreach scal ("${split[1]}")" >> $new_folder/RUN_qsub_pass_G_and_S.csh
	echo "sed \"s/GGG/\$conf/\" RUN_qsub_templ_V0.csh > RUN_qsub_templ_V1.csh" >> $new_folder/RUN_qsub_pass_G_and_S.csh 
	echo "sed \"s/SSS/\$scal/\" RUN_qsub_templ_V1.csh > RUN_qsub_G\"\$conf\"_S\"\$scal\".csh" >> $new_folder/RUN_qsub_pass_G_and_S.csh 
	echo "rm RUN_qsub_templ_V1.csh" >> $new_folder/RUN_qsub_pass_G_and_S.csh
        echo "echo ''" >> $new_folder/RUN_qsub_pass_G_and_S.csh
	echo "echo '---------------------------------------'" >> $new_folder/RUN_qsub_pass_G_and_S.csh
        echo "echo ''" >> $new_folder/RUN_qsub_pass_G_and_S.csh
        echo "end" >> $new_folder/RUN_qsub_pass_G_and_S.csh
        echo "csh RUN_qsub_G\"\$conf\"_S\"\$scal\".csh" >> $new_folder/RUN_qsub_pass_G_and_S.csh
        echo "end" >> $new_folder/RUN_qsub_pass_G_and_S.csh


done
#cp RUN_qsub_pass_G_and_S.csh  $new_folder/RUN_qsub_pass_G_and_S.csh 

##############################
#job.templ
#######################################
echo "#!/bin/bash" > $new_folder/job.templ
echo "#!/bin/bash -x" >> $new_folder/job.templ
if [ $system = A2 ]
then 
	echo "#SBATCH --partition=booster" >> $new_folder/job.templ
	echo "#SBATCH --exclusive" >> $new_folder/job.templ
	echo "#SBATCH --account=hbn28" >> $new_folder/job.templ
#	echo "#SBATCH -N4 -n256 --mem=32000 " >> $new_folder/job.templ            
#	echo "#SBATCH -N19 -n1250 --mem=32000 " >> $new_folder/job.templ            
	echo "#SBATCH -N10 -n625  " >> $new_folder/job.templ            
	echo "#SBATCH --time=24:00:00       " >> $new_folder/job.templ
#	echo "#SBATCH --cpus-per-task=4 " >> $new_folder/job.templ
#	echo "#SBATCH --ntasks-per-node=64 " >> $new_folder/job.templ
	echo "#SBATCH --exclusive " >> $new_folder/job.templ
	echo "#SBATCH --job-name="$eta"_"$M02"_"$mu03"  " >> $new_folder/job.templ
#	echo "export I_MPI_JOB_RESPECT_PROCESS_PLACEMENT=disable " >> $new_folder/job.templ
#	echo "export HFI_NO_CPUAFFINITY=1 " >> $new_folder/job.templ

#	echo "export I_MPI_HYDRA_ENV=all " >> $new_folder/job.templ
#	echo "export I_MPI_FABRICS=shm:tmi " >> $new_folder/job.templ
#	echo "export I_MPI_PIN=1 " >> $new_folder/job.templ

## at debug level 4, Intel MPI outputs the task pinning layout
## which can be used to confirm that desired layout has been
## obtained
## this can be disabled (set to 0) once you're happy with the pinning
#	echo "export I_MPI_DEBUG=4 " >> $new_folder/job.templ

## pin tasks to regions of 4 threads (1 core per MPI task)
#	echo "export I_MPI_PIN_DOMAIN=4 " >> $new_folder/job.templ

#	echo "export KMP_AFFINITY="balanced,granularity=fine" " >> $new_folder/job.templ

#	echo "#PBS -l select=4:ncpus=68:mpiprocs=64:mcdram=cache:mem=86GB:numa=quadrant" >>$new_folder/job.templ
#	echo "#PBS -l walltime=19:00:00" >> $new_folder/job.templ
#	echo "#PBS -A INF17_lqcd123_1" >> $new_folder/job.templ
else 
	#echo "#SBATCH --partition=skl_usr_prod " >> $new_folder/job.templ
	#echo "#SBATCH --account=INF21_lqcd123" >> $new_folder/job.templ
	echo "#SBATCH -N4 -n128 --mem=32000 " >> $new_folder/job.templ            
	echo "#SBATCH --time=06:00:00       " >> $new_folder/job.templ
fi

#echo "#SBATCH --output job.out " >> $new_folder/job.templ
#echo "#SBATCH --error job.e     " >> $new_folder/job.templ
echo >> $new_folder/job.templ

echo "efile=/home/mgarofalo/tmLQCD/build/contractions_BSM" >> $new_folder/job.templ
#echo "efile=/p/scratch/chbn28/project/BSM/contractions_BSM" >> $new_folder/job.templ
echo >> $new_folder/job.templ


echo "source /p/home/jusers/garofalo1/jureca/tmLQCD/build/load_modules.sh" >> $new_folder/job.templ
#echo ". /p/home/jusers/kostrzewa2/jureca/build/jurecabooster/stage-2018a/knl-avx512/intel_mpi_2018-intel_2018/load_modules.sh" >> $new_folder/job.templ
#echo "module load intel intelmpi mkl" >> $new_folder/job.templ
echo >> $new_folder/job.templ
echo >> $new_folder/job.templ

echo "cd $current_folder/$new_folder" >> $new_folder/job.templ
echo >> $new_folder/job.templ
echo >> $new_folder/job.templ

echo "date > eta_"$etam"_M02_"$M02_decimal"_mu03_"$mu03_decimal"_L"$L"_rho_"$rho".log" >> $new_folder/job.templ
echo >> $new_folder/job.templ

echo "mpirun    \${efile} -f contractions.input  -v | tee -a eta_"$etam"_M02_"$M02_decimal"_mu03_"$mu03_decimal"_L"$L"_rho_"$rho".log" >> $new_folder/job.templ

echo >> $new_folder/job.templ

echo "date >> eta_"$etam"_M02_"$M02_decimal"_mu03_"$mu03_decimal"_L"$L"_rho_"$rho".log" >> $new_folder/job.templ

#contractions.templ
#####################
echo "L=$L" >$new_folder/contractions.templ
echo "T=$T" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "debuglevel=1" >>$new_folder/contractions.templ

if [ $system = A2 ]
then 
#	echo "ompnumthreads=136" >>$new_folder/contractions.templ
	echo "NrXProcs = 5" >>$new_folder/contractions.templ
	echo "NrYProcs = 5" >>$new_folder/contractions.templ
	echo "NrZPRocs = 5" >>$new_folder/contractions.templ
else
#	echo "ompnumthreads=16" >>$new_folder/contractions.templ
	echo "NrXProcs = 4" >>$new_folder/contractions.templ
	echo "NrYProcs = 4" >>$new_folder/contractions.templ
	echo "NrZPRocs = 2" >>$new_folder/contractions.templ
fi

echo "" >>$new_folder/contractions.templ

echo "useevenodd=no" >>$new_folder/contractions.templ
echo "usesloppyprecision=no" >>$new_folder/contractions.templ
echo "disableiochecks=no" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "reproducerandomnumbers=no" >>$new_folder/contractions.templ
echo "ranluxdlevel = 2" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "seed = 19825" >>$new_folder/contractions.templ
echo "initialstorecounter = 0000" >>$new_folder/contractions.templ
echo "InitialScalarCounter = 00000000" >>$new_folder/contractions.templ

echo "" >>$new_folder/contractions.templ

echo "measurements = 1" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ
echo "bcanglet = 1" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "gaugeconfiginputfile = conf" >>$new_folder/contractions.templ
echo "scalarconfiginputfile = scalar" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "sourcetype = point" >>$new_folder/contractions.templ
echo "Indices = 0-11" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "sourcelocation= 0" >>$new_folder/contractions.templ   # (39 0 0 0 )=159744
echo "readsource = no" >>$new_folder/contractions.templ
echo "sourcefilename = bsm2prop" >>$new_folder/contractions.templ
echo "PropagatorFilename= bsm2prop" >>$new_folder/contractions.templ
echo "" >>$new_folder/contractions.templ

echo "BeginOperator BSM3" >>$new_folder/contractions.templ
echo "  propagatorsonthefly = yes" >>$new_folder/contractions.templ
echo "  vectordensitydensity = yes" >>$new_folder/contractions.templ
echo "  vectorcurrentdensity = yes" >> $new_folder/contractions.templ
echo "  pdensityvectordensity = yes" >> $new_folder/contractions.templ
echo "  densitydensity = yes" >>$new_folder/contractions.templ
echo "  timesmearcorrelator = 2" >>$new_folder/contractions.templ
echo "  densitydensity = yes" >>$new_folder/contractions.templ
echo "  densitydensitys0s0 = yes" >>$new_folder/contractions.templ
echo "  densitydensitysxsx = yes" >>$new_folder/contractions.templ
echo "  diraccurrentdensity = yes" >>$new_folder/contractions.templ
echo "  wilsoncurrentdensityprfirstline = yes" >>$new_folder/contractions.templ
echo "  wilsoncurrentdensityprsecondline = yes" >>$new_folder/contractions.templ
echo "  wilsoncurrentdensityplfirstline = yes" >>$new_folder/contractions.templ
echo "  wilsoncurrentdensityplsecondline = yes" >>$new_folder/contractions.templ
echo "  vectorcurrentdensity = yes " >>$new_folder/contractions.templ
echo "  axialcurrentdensity = yes  " >>$new_folder/contractions.templ
echo "  giancarlocontraction = yes " >>$new_folder/contractions.templ

echo "  currentA1currentA1 = no " >>$new_folder/contractions.templ
echo "  currentV3currentV3 = no " >>$new_folder/contractions.templ

echo "  smearingcorrelator = yes" >>$new_folder/contractions.templ
echo "  nscalarstep = 1" >>$new_folder/contractions.templ

echo "  cswbsm = $csw " >>$new_folder/contractions.templ
echo "  rhobsm = $rho" >>$new_folder/contractions.templ
echo "  m0bsm = $M02" >>$new_folder/contractions.templ
echo "  mu03bsm = $mu03" >>$new_folder/contractions.templ
echo "  etabsm = $eta" >>$new_folder/contractions.templ
echo "  solver = cg" >>$new_folder/contractions.templ
echo "  solverprecision = 1e-19" >>$new_folder/contractions.templ
echo "  maxsolveriterations = 35000" >>$new_folder/contractions.templ
echo "  npergauge = $npergauge" >>$new_folder/contractions.templ
echo "EndOperator" >>$new_folder/contractions.templ

###################
cd $new_folder
csh RUN_create_dirs_pass_G_and_S.csh
csh RUN_qsub_pass_G_and_S.csh 
cd ..


done
done
done
done

cd $here
