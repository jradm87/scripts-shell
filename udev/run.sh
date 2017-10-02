#!/bin/bash
#Script to copy files local do ExternalDrive
#	@Author: Carlos F. S. Junior
beep
export DISPLAY=:0.0

#SOURCE BACKUP LOCAL
source="/a"
#EXTERNAL HARD DISK
destination="/mnt/HDE"

Logg(){
	logger "Backup HD - "$1
}


Mount(){

	if [ ! -d "$destination" ];then
		Logg "Creating $destination DIR"
		mkdir -p  $destination
	fi

	if [ -d "$destination" ];then
		Logg "mount /dev/$1 $destination"
		mount /dev/$1 $destination > /dev/null
	fi

	if mountpoint -q  $destination
		then
			Logg "$destination has been mounted"
			Logg "Copyng file wait GUI finish"
			copyF
			Sizes
			sync
			umount $destination
			Logg "Script has been finished"
			zenity  --info --text="Backup Concluido favor remover a midia"
	fi
}

copyF(){
	files=`find $source/*`
	total=`find /$source/* | wc -l`
	i=0
	for file in $files
		do
			i=$((i+1))
			result=`echo $i/$total*100 | bc -l | awk -F"." '{print $1}'`
			echo $result;
			sleep 1
			echo `printf "#		\
			Backup em andamento\n\n \
			Copiando $file"`

#			rsync -av --progress $file $destination"/" > /dev/null
		done | zenity --progress \
			--title="Backup ExternalDrive" \
			--text="Iniciando copia de arquivos" \
			--no-cancel \
			--percentage=0 \
			--auto-close \
			--auto-kill
}

Sizes(){
	sizeA=`du -hs $source | awk -F" " '{print $1}'`
	sizeB=`du -hs $destination | awk -F" " '{print $1}'`
	totalA=`ls $source | wc -l`
	totalB=`ls $destination | wc -l`
	zenity --info --text="`printf "
	=========Backup concluido=======

	Source = $sizeA total files=$totalA\n
	Destination = $sizeB total files=$totalB\n

	"`"
}

Mount $1
