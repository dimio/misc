#!/usr/bin/env bash
# v. 0.0.2
# dimio (dimio.org)
set -e
set -u

BIN="$(dirname $0)"/bin
FACT="${BIN}"/factorization.bash

_cyclical_call(){
	for ((i=1; i <= ${1}; i++))
	do
		printf "\n\nПример # ${i} из ${1}\n"
		eval "${2}" "${3}" "${4}"
	done
}

_show_help() {
cat <<EOF
$0 [-fh] repeats min max
	Options:
		-f | --factorization	run <repeats> additions example in <min> and <max> diapason
		-h | --help				show this help and exit
		repeats					count of repetition of tasks
		min, max				bottom and top limits for generated number

	Example:
		$0 -f 2 1 10
		generate 2 tasks with the sum for the decomposition on the terms from 1 to 10:
		6 = 3 + X
		X= ?
EOF
}

if [[ $# != 0 ]]; then
    case "${1}" in
        -f|--factorization)
			_cyclical_call "${2}" "${FACT}" "${3}" "${4}";;
		-h|--help)
			_show_help;;
    esac
else
    _show_help
fi