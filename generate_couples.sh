#!/bin/bash
scal=280
lenght=0
for i in ` seq 47  76 `
 do

if [ $i -lt 100  ]
then
ii="0$i"

else
ii=$i
fi


 a="$a  "$ii":$scal" 

 scal=$((scal+160))
lenght=$((lenght +1))  

# a="$a  "$ii":$scal" 
# scal=$((scal+80))
#lenght=$((lenght +1))  
# a="$a  0"$i":$scal" 
# scal=$((scal+80))
#lenght=$((lenght +1))  

 done

lenght=$(( lenght -1))
echo $a
echo the array contain $lenght element
