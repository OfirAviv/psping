#!/bin/bash

operateFlags()
{
	c=$1
	t=$2
	u=$3
	e=$4	
	if [ $c = '%' ]
	then
		while true
		do
			if [ $u = '%' ]
			then
				ps aux | grep $e | wc -l
			else
				ps aux | grep $u | grep $e | wc -l
			fi
			sleep $t
		done
	else
		for(( i=0; i<$c; i++ ))
		do	
			if [ $u = '%' ]
			then
				ps aux | grep $e | wc -l
			else
				ps aux | grep $u |grep $e | wc -l
			fi
			sleep $t
		done
	fi
}

numValidation()
{
		arg=( "$@" )		
		for i in ${arg[@]}
		do
		if ! [[ $i =~ ^[+][[:digit:]]$ ]] && ! [ "$i" = "%" ]
		then	
			echo "Invalid Number!"
			return 1
		fi
		done
		return 0
}

userValidation()
{
	arr=( `cut -d ":" -f1 /etc/passwd` )
	for i in ${arr[@]}
	do
		if [ "$i" = "$1" ] || [ "$1" = "%" ]
		then
			return 0
		fi
	done
	echo "User $1 Do Not Exist!"
	return 1
}
count='%'
user='%'
time=1
flag=0
while getopts ":c:t:u:" options
do
	case "${options}" in
		c)
			count=${OPTARG}
			;;
		t)
			time=${OPTARG}
			;;
		u)
			user=${OPTARG}
			;;
		?)
			echo Wrong Argument!
			;;
	esac
done
shift $((OPTIND-1))
numValidation "$count" "$time"
n_check=$?
userValidation "$user"
u_check=$?
if [ $n_check -eq 0 ] && [ $u_check -eq 0 ]
then
	arr=( "$*" )
	for i in ${arr[@]}
	do
		echo "psping to $i..."
		check=`which $i`
		if [ $? = 0 ] && [ -x $check ]
		then
			operateFlags "$count" "$time" "$user" "$i" 
		else		
			echo "Executable $i not found!"
		fi
		echo
	done
fi