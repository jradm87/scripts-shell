#!/bin/bash
#Author: Carlos F. S. Junior.
# Recursive consult spf ipv4

search(){

	ip4 $1
	for spf in `dig -t TXT $1 | grep spf `
		do
			spf2=`echo $spf | grep include | awk -F":" '{print $2}'`
			if [ -z "$spf2" ];then
				continue;
			fi
			echo Consultando: $spf2
			search $spf2
			ip4 $spf2
		done
}

ip4(){

	for spf in `dig -t TXT $1 | grep spf `;do echo $spf | grep ip4 | awk -F":" '{print $2}';done
}

search $1
