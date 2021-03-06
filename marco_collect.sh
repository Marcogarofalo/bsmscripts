#!/bin/bash
L=20
T=40
here=`pwd`
cd ..
for f in `ls | grep eta | grep -v test`
do
echo $f
correlators="P1P1TRIVIAL P2P2TRIVIAL P3P3TRIVIAL  S0S0TRIVIAL JTILDEV3P3NONTRIVIAL VECTORDENSITY3DENSITY3NONTRIVIAL  JTILDEA1P1TRIVIAL  P1DP1NONSMEAREDNONTRIVIAL
  LOCALCURRENTTAU1P1  LOCALCURRENTTAU2P2 LOCALCURRENTTAU3P3"


if [ ! -d data_marco ]; then mkdir data_marco; fi
if [ ! -d data_marco/$f ]; then mkdir data_marco/$f; fi
if [ ! -d data_marco/$f/data ]; then mkdir data_marco/$f/data; fi

L=`grep L= $f/contractions.templ  `
L=${L/L=/}
T=`grep T= $f/contractions.templ  `
T=${T/T=/}
rho=`grep rho $f/contractions.templ | awk '{print $3}'`
eta=`grep eta $f/contractions.templ | awk '{print $3}'`
csw=`grep csw $f/contractions.templ | awk '{print $3}'`
mu03=`grep mu03bsm $f/contractions.templ | awk '{print $3}'`
m0=`grep m0bsm $f/contractions.templ | awk '{print $3}'`
echo "T     $T" > marco_header
echo "L     $L" >> marco_header
echo "rho   $rho" >> marco_header
echo "eta   $eta" >> marco_header
echo "csw   $csw" >> marco_header
echo "mu03  $mu03" >> marco_header
echo "m0    $m0" >> marco_header



cat marco_header > data_marco/$f/data/vev
cat marco_header >data_marco/$f/data/phit

for correlator in $correlators
do
Nc=0
Ns=0

folders="./"
cat marco_header >data_marco/$f/data/"$correlator"

	confs=` ls  $f | grep conf.0`
	#| grep -v conf.0036 | grep -v conf.0022 | grep -v conf.0020 |grep -v conf.0019 `
#confs=`echo $confs |awk  -v f=1 -v t=40 '{for(i=f;i<=t;i++) printf("%s%s",$i,(i==t)?"\n":OFS)}' `
#echo $confs
	for conf in $confs
	do
		runs=` ls  "$f"/"$conf"/ | grep run `
#runs=`echo $runs |awk '{print $0}' `
#echo $runs
		for run in $runs
		do
		sXgs=` ls  "$f"/"$conf"/"$run" | grep bsmcontractions | grep -v copy | grep -v rawi`
		
		phits=` ls  "$f"/"$conf"/"$run" | grep phit* | grep -v copy`
		scalars_list=` ls  "$f"/"$conf"/"$run" | grep scalar | grep -v copy`
		scalars=""
		arr_scalar=($scalars_list)
#echo  $f/$conf/$run		
#ls  "$f"/"$conf"/"$run"		
#echo $scalars
#sXgs=`echo $sXgs | awk '{print $0}'`
#echo $sXgs               
                        i=0
			for sXg in $sXgs
			do
			infile="$f/$conf/$run/$sXg"
			grep "$correlator"  $infile | tail -n $T | awk '{print $3"   "$4}'>tmp
                        full=`wc -l tmp | awk '{print $1}'`
#if [ $full -eq $T ]; then  echo lines=$full ;fi 
			if [ $full -eq $T ]
			then
				cat tmp >> data_marco/$f/data/"$correlator"
				scalars="$scalars ${arr_scalar[$i]}"
				i=$((i+1))
				Nc=$((Nc+1))
#echo $scalars
                	fi
				#full=`grep "$correlator"  $infile | wc -l  `
			done	
			
if [ "$correlator" = "JTILDEA1P1TRIVIAL" ]
then
#echo $scalars
			for scalar in $scalars
			do
#				echo "processing scalar "$f"/"$conf"/"$run"/$scalar "
                                $here/v0 -i  "$f"/"$conf"/"$run"/$scalar  -o niente -L $L -T $T
				cat vev | awk '{print $1"   "166116116}'  >> data_marco/$f/data/vev
                		cat phit  | awk '{print $1"   "166116116}' >> data_marco/$f/data/phit                                
                                Ns=$((Ns+1))
			done
fi
			
			
		done
	
	done
echo $correlator   $Nc
if [ "$correlator" = "JTILDEA1P1TRIVIAL" ]; then echo scalars  $Ns; fi
done

done


cd $here
