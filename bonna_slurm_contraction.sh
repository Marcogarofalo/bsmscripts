#!/bin/bash
L=20
T=40
kappa=.0129280
etas="-1.0983 -1.1375 -1.2944"
etas="-1.0983"
#done
#etas="-1.1375"
#etas="-1.2944"
#M02s=" -0.8 -0.4 0 0.4  "
#M02s="-1.2 -1.0 -0.8 -0.6 -0.4 -0.2 0 0.2 0.4 0.6"
M02s="-0.029604 -0.024604  0.010396 "
M02s=" -0.010396  "
#M02s=" -0.024604  "
#M02s="-0.029604 "
#M02s="-1.2 -1.0"

#mu03s="0.0120 0.0224"
mu03s="0.0224"
#mu03s="0.0120"

system="A3"
#rho="1"
#rho="1.008742"
rho="1.96"
#rho="1.007170"
csws="1.0"

here=`pwd`
cd ..
#array=(019:200 020:280 021:360 022:440 023:520 024:600 025:680 026:760 027:840 028:920 029:1000 030:1080 031:1160 032:1240 033:1320 034:1400 035:1480 036:1560 037:1640 038:1720 039:1800 040:1880 041:1960 042:2040 043:2120 044:2200 045:2280 046:2360 047:2440 048:2520)
#array=(019:200 020:360 021:520 022:680 023:840 024:1000 025:1160 026:1320 027:1480 028:1640 029:1800 030:1960 031:2120 032:2280 033:2440 034:2600 035:2760 036:2920 037:3080 038:3240 039:3400 040:3560 041:3720 042:3880 043:4040 044:4200 045:4360 046:4520 047:4680 048:4840)
#array=(036:220 037:380 038:540 039:700 040:860 041:1020 042:1180 043:1340 044:1500 045:1660 046:1820 047:1980 048:2140 049:2300 050:2460 051:2620 052:2780 053:2940 054:3100 055:3260 056:3420 057:3580 058:3740 059:3900 060:4060 061:4220 062:4380 063:4540 064:4700 065:4860 066:5020 067:5180 068:5340 069:5500 070:5660 071:5820 072:5980 073:6140 074:6300 075:6460)
#array=(076:6620 077:6780 078:6940 079:7100 080:7260 081:7420 082:7580 083:7740 084:7900 085:8060 086:8220 087:8380 088:8540 089:8700 090:8860 091:9020 092:9180 093:9340 094:9500 095:9660)


#array=(016:6610 017:6770 018:6930 019:7090 020:7250 021:7410 022:7570 023:7730 024:7890 025:8050 026:8210 027:8370 028:8530 029:8690 030:8850 031:9010 032:9170 033:9330 034:9490 035:9650 096:210 097:370 098:530 099:690 100:850 101:1010 102:1170 103:1330 104:1490 105:1650 106:1810 107:1970 108:2130 109:2290 110:2450 111:2610 112:2770 113:2930 114:3090 115:3250 116:3410 117:3570 118:3730 119:3890 120:4050 121:4210 122:4370 123:4530 124:4690 125:4850 126:5010 127:5170 128:5330 129:5490 130:5650 131:5810 132:5970 133:6130 134:6290 135:6450)
#array=(016:9820 017:9980 018:10140 019:10300 020:10460 021:10620 022:10780 023:10940 024:11100 025:11260 026:11420 027:11580 028:11740 029:11900 030:12060 031:12220 032:12380 033:12540 034:12700 035:12860 096:13020 097:13180 098:13340 099:13500 100:13660 101:13820 102:13980 103:14140 104:14300 105:14460 106:14620 107:14780 108:14940 109:15100 110:15260 111:15420 112:15580 113:15740 114:15900 115:16060 116:16220 117:16380 118:16540 119:16700 120:16860 121:17020 122:17180 123:17340 124:17500 125:17660 126:17820 127:17980 128:18140 129:18300 130:18460 131:18620 132:18780 133:18940 134:19100 135:19260)
# array=(020:680)

#array=(019:200 020:360 021:520 022:680 023:840 024:1000 025:1160 026:1320 027:1480 028:1640 029:1800 030:1960 031:2120 032:2280 033:2440 034:2600 035:2760 036:2920 037:3080 038:3240 039:3400 040:3560 041:3720 042:3880 043:4040 044:4200 045:4360 046:4520 047:4680 048:4840 049:5000 050:5160 051:5320 052:5480 053:5640 054:5800 055:5960 056:6120 057:6280 058:6440 059:6600 060:6760 061:6920 062:7080 063:7240 064:7400 065:7560 066:7720 067:7880 068:8040 069:8200 070:8360 071:8520 072:8680 073:8840 074:9000 075:9160 076:9320 077:9480 078:9640)
array=(019:220 020:540 021:860 022:1180 023:1500 024:1820 025:2140 026:2460 027:2780 028:3100 029:3420 030:3740 031:4060 032:4380 033:4700 034:5020 035:5340 036:5660 037:5980 038:6300 039:6620 040:6940 041:7260 042:7580 043:7900 044:8220 045:8540 046:8860 047:9180 048:9500 049:9820 050:10140 051:10460 052:10780 053:11100 054:11420 055:11740 056:12060 057:12380 058:12700 059:13020 060:13340 061:13660 062:13980 063:14300 064:14620 065:14940 066:15260 067:15580 068:15900 069:16220 070:16540 071:16860 072:17180 073:17500 074:17820 075:18140 076:18460 077:18780 078:19100)

lenght_array=${#array[@]}
lenght_array=$(( lenght_array-1))

ScalarsXoneGauge=8
if [ $system = A2 ]
then 
nruns=2
else
nruns=8
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

new_folder="eta_"$etam"_M02_"$M02"_mu03_"$mu03"_csw_"$csw"_rho"$rho""
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
	echo "#SBATCH --time=03:00:00       " >> $new_folder/job.templ
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
echo "disableiochecks=yes" >>$new_folder/contractions.templ
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
cd $here



done
done
done
done
