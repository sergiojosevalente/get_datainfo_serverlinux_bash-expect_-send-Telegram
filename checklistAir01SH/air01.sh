#!/usr/bin/bash

#File
folder=20230208

#EXPScript
serverAir01=/home/sergiovalente/checklistAir01/checklistAir01EXP/air01.exp

#Simpan di server
filesource=/home/sergiovalente/checklistAir01/AIR01/checklistAir01.txt
filedestination=/home/sergiovalente/checklistAir01/AIR01/$folder
makefile=/home/sergiovalente/checklistAir01/AIR01

#Kirim ke http
filesourcehttp=/var/www/html/checklistAir01/AIR01/checklistAir01.txt
filedestinationhttp=/var/www/html/checklistAir01/AIR01/$folder
filecopyhttp=/var/www/html/checklistAir01/AIR01/
makefilehttp=/var/www/html/checklistAir01/AIR01

#Kirim ke telegram
chatid=-1001848244463
linkapitelegram=https://api.telegram.org/bot6171909951:AAFeKrZHVaeuTL20yAnJnC6LCqF50xduF58/sendMessage?parse_mode=HTML

getdata(){
expect $serverAir01  > $filesource
#expect $serverAir01  > $filesourcehttp
}

makedir(){
mkdir $makefile/$folder
#mkdir $makefilehttp/$folder
}

uptime(){
sed -n '27p' $filesource  > $filedestination/uptime.txt
#sed -n '28p' $filesourcehttp  > $filedestinationhttp/uptime.txt

}

disk_utilization(){
sed -n '29,59p' $filesource  > $filedestination/disk_utilization.txt
#sed -n '30,60p' $filesourcehttp  > $filedestinationhttp/disk_utilization.txt
}

cpu_memory_utilization(){
sed -n '61,65p' $filesource > $filedestination/cpu_memory__utilization.txt
#sed -n '62,66p' $filesourcehttp > $filedestinationhttp/cpu_memory__utilization.txt
}

check_swap_space(){
sed -n '67p' $filesource  > $filedestination/swap_space.txt
#sed -n '67p' $filesourcehttp  > $filedestinationhttp/swap_space.txt
}

network_load(){
sed -n '68,71p' $filesource > $filedestination/network_load.txt
#sed -n '69,72p' $filesourcehttp > $filedestinationhttp/network_load.txt
}

date_time(){
sed -n '73p' $filesource  > $filedestination/date_time.txt
#sed -n '74p' $filesourcehttp  > $filedestinationhttp/date_time.txt
}

free_used_memory(){
sed -n '75,77p' $filesource  > $filedestination/free_used_memory.txt
#sed -n '75,77p' $filesourcehttp  > $filedestinationhttp/free_used_memory.txt
}

copy_file_to_http(){
cp $filesource $filecopyhttp  
cp -r $makefile/$folder $filecopyhttp
}

kirim_telegram(){

file_satu=$(cat $filedestination/date_time.txt)
file_dua=$(cat $filedestination/network_load.txt)
file_tiga=$(cat $filedestination/free_used_memory.txt)
#file_satu=$(while read line; do echo $line; done < $filedestination/ date_time.txt)
#file_dua=$(while read line; do echo $line; done < $filedestination/network_load.txt)


curl --data chat_id="$chatid" --data-urlencode "text=<b>$file_satu</b>

<b>Network Load</b>
$file_dua

<b>CPU and Memory Util.</b>
$file_tiga"  "$linkapitelegram"

#curl --data chat_id="$chatid" --data-urlencode "text=<b>$(cat $filedestination/date_time.txt)</b>


#$(cat $filedestination/network_load.txt)" "$linkapitelegram"

}

getdata
makedir
uptime
disk_utilization
cpu_memory_utilization
check_swap_space
network_load
date_time
free_used_memory
copy_file_to_http
kirim_telegram
