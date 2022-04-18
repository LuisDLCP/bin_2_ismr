#!/bin/bash
# This program obtains ISMR files from compressed binary files 
# -------------------------------
REMOTE_PATH='/media/cesar/DATA-SEPTENTRIO/'
ROOT_PATH='/home/cesar/Desktop/luisd/scripts_custom/libraries/bin_2_ismr/'
INPUT_PATH="${ROOT_PATH}Input_data/"
OUTPUT_PATH="${ROOT_PATH}Output_data/"

CONVERTER='/opt/Septentrio/RxTools/bin/sbf2ismr'
STATION_NAME='lsba'
CHANGE_NAME=1

#cp ${REMOTE_PATH}*gz ${INPUT_PATH}
#echo 'Every file was copied!'

gunzip ${INPUT_PATH}*gz
echo 'Every file was uncrompressed!'

ls ${INPUT_PATH}*_ | xargs -t -I % ${CONVERTER} -f % 
mv ${INPUT_PATH}*ismr ${OUTPUT_PATH} 
echo 'Every file was converted to an ISMR file!'

# Rename files
if [ ${CHANGE_NAME} -eq 1 ]
then
for file in ${OUTPUT_PATH}*ismr
do 
  file_name=$(basename ${file})
  file_path=$(dirname ${file})
  mv ${file} "${file_path}/${file_name/SEPT/${STATION_NAME}}"
done
echo 'Every file was renamed!'
fi

rm ${INPUT_PATH}*_
echo 'Every binary file was deleted!'


