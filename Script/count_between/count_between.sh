#!/bin/bash

a=$1;
b=$2;

res=0;

if (($a < $b)); then
	if ((($a >= 10)) && (($b <= 99))); then
		for ((i= $a+1; i <= $b-1; i++)) do
			if ((i != 42)); then
				res=$(($res + 1))
			else 
				res=$(($res + 2))
			fi
		done
		echo $res
	elif ((( $a < 10)) && (($b >= 10)) && (($b <= 99))); then
		for ((i= 10; i < $b; i++)) do
			if ((i != 42)); then
				res=$(($res + 1))
			else 
				res=$(($res + 2))
			fi
		done
		echo $res;
	elif ((( $a >= 10)) && (($a <= 99)) && (($b > 99 ))); then
		for ((i= $a; i <= 99; i++)) do
			if ((i != 42)); then
				res=$(($res + 1))
			else 
				res=$(($res + 2))
			fi
		done
		echo $res;
	elif ((($a < 10)) && (($b > 99 ))); then
		for ((i= 10; i <= 99; i++)) do
			if ((i != 42)); then
				res=$(($res + 1))
			else 
				res=$(($res + 2))
			fi
		done
		echo $res;
	else
		echo 0;
	fi
fi
