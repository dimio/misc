#!/usr/bin/env bash
# v. 0.0.1
set -e
#set -u


_addition() {
	MIN=$1
	MAX=$2
	SUM=$(shuf -i ${MIN}-${MAX} -n 1)
	ADDEND1=$(shuf -i 1-$(expr ${SUM} - 1) -n 1)
	ADDEND2=$(expr ${SUM} - ${ADDEND1})

	printf "  %2d \n" ${SUM}
	printf "  / \ \n"
	printf " %d + _" ${ADDEND1}
	read -s -N1 x
  printf "\b%d" ${x}
	while [[ ${x} != ${ADDEND2} ]]
	do
		read -s -N1 x
    printf "\b%d" ${x}
	done
}

_addition_t=$(cat <<EOF
	MIN=$1
	MAX=$2
	SUM=$(shuf -i ${MIN}-${MAX} -n 1)
	ADDEND1=$(shuf -i 1-$(expr ${SUM} - 1) -n 1)
	ADDEND2=$(expr ${SUM} - ${ADDEND1})

	printf "  %2d \n" ${SUM}
	printf "  / \ \n"
	printf " %d + _" ${ADDEND1}
	read -s -N1 x
  printf "\b%d" ${x}
	while [[ ${x} != ${ADDEND2} ]]
	do
		read -s -N1 x
    printf "\b%d" ${x}
	done
EOF
)

_cyclical_call(){
	for ((i=1; i <= ${1}; i++))
	do
		printf "\n\n"
		echo "Пример # ${i} из ${1}"
		# _addition "${2}" "${3}"
		eval ${4}
	done
}

_show_help() {
cat <<EOF
$0: $0 [-ah] repeats min max
	Options:
		-a | --addition	run <repeats> additions example in <min> and <max> diapason
		-h | --help		show this help and exit
		repeats			count of repetition of tasks
		min, max		bottom and top limits for generated number

	Example:
		$0 -a 2 1 10
		generate 2 tasks with the sum for the decomposition on the terms from 1 to 10:
		6 = 3 + X
		X= ?
EOF
}

# echo ${_addition_t}

if [[ $# != 0 ]]; then
    case "${1}" in
        -h|--help)      _show_help;;
        -a|--addition)  _cyclical_call "${2}" "${3}" "${4}" "${_addition_t}";;
    esac
else
    _show_help
fi