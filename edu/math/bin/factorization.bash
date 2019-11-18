#!/usr/bin/env bash
# v. 0.0.2
# dimio (dimio.org)
set -e
set -u

MIN=$1
MAX=$2
SUM=$(shuf -i ${MIN}-${MAX} -n 1)
if [[ ${SUM} != ${MIN} ]]; then
	ADDEND1=$(shuf -i 1-$(expr ${SUM} - 1) -n 1)
else
	ADDEND1=0
fi
ADDEND2=$(expr ${SUM} - ${ADDEND1})
ADDEND2LENGTH=${#ADDEND2}

printf "  %2d \n" ${SUM}
printf "  / \ \n"
printf " %d + _" ${ADDEND1}
read -s -N ${ADDEND2LENGTH} x
printf "\b%d" ${x}
while [[ ${x} != ${ADDEND2} ]]
do
	read -s -N ${ADDEND2LENGTH} x
	printf "\b%d" ${x}
done
