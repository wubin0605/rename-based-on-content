#!/bin/bash
if [ $1 == "" ]; then
	dir=.
else
	dir=$1
fi
for afile in $dir/*.Z ;do
    	i=1
	while [ 1 -eq 1 ]; do
		aline=`bzcat $afile | head -$i | tail -1`
		starttime=`echo $aline | awk '{if ($1 ~ /[0-9]+-[0-9]+/ && $2 ~ /[0-9]+:[0-9]+:[0-9]+/)print $1 "_" $2}'`
		echo "starttime" [$starttime]
		if [ "$starttime" != "" ];then
			break
		fi
		((i++))
	done

	j=1
	while [ 1 -eq 1 ]; do
		aline=`bzcat $afile | tail -$j | head -1`
		endtime=`echo $aline | awk '{if ($1 ~ /[0-9]+-[0-9]+/ && $2 ~ /[0-9]+:[0-9]+:[0-9]+/)print $1 "_" $2}'`
		echo "endtime" [$endtime]
		if [ "$endtime" != "" ];then
			break
		fi
		((j++))
	done

	basename=`basename $afile`
	dirname=`dirname $afile`
	newbasename=${basename//.*/.[$starttime]~[$endtime].Z}
	mv $afile $dirname/$newbasename
	
done
