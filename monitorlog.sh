#!/bin/bash
#set -x


## Comment this line to feed selective container names 
docker container ls -q > .containerlist

for cont in $(cat .containerlist)
do
	docker container logs ${cont} > .cont-${cont}.log
	for str in $(cat .scanstring)
	do
		grep -iq "$str" .cont-${cont}.log
		if [ $? -eq 0 ]
		then
			echo "$str messages found in the container: ${cont} logs"
			echo "Sending Email to Developers"
		fi
	done
done
