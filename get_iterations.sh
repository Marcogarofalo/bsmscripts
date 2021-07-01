#!/bin/bash
make
echo eta m0 mu rho  csw  CG.AVE.iter   error   res2   err > table.txt
for f in `ls | grep eta`
do

rho=`grep rho $f/contractions.templ | awk '{print $3}'`
eta=`grep eta $f/contractions.templ | awk '{print $3}'`
csw=`grep csw $f/contractions.templ | awk '{print $3}'`
mu03=`grep mu03bsm $f/contractions.templ | awk '{print $3}'`
m0=`grep m0bsm $f/contractions.templ | awk '{print $3}'`

string=" $eta $m0 $mu03 $rho $csw "

grep iteration $f/con*/*/eta* | grep -v squared | awk '{print $7}' > cg_iteration
grep "BSM Dirac inversion "\|\|"A"  $f/con*/*/eta* | awk '{print $7}' > residual

cgiter=`./mean_and_err  cg_iteration`
string="$string   $cgiter"

res=`./mean_and_err  residual`
string="$string   $res"

check=`echo $res | awk '{print $1}' `
if [ $check = 35000 ]
then
     echo $f    echo still runnin or broken
     grep iteration $f/con*/*/*.out | grep -v squared | awk '{print $7}' > cg_iteration
     grep "BSM Dirac inversion "\|\|"A"  $f/con*/*/eta* | awk '{print $7}' > residual
     cgiter=`./mean_and_err  cg_iteration`
     string="$string   $cgiter"

     res=`./mean_and_err  residual`
     string="$string   $res"
     check1=`echo $res | awk '{print $1}' `

     if [ $check = 35000 ]
     then
        echo nothing in  job.out
     else
	echo $string >> table.txt
     fi

else
	echo $string >> table.txt
fi

done 
