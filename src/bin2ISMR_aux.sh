#!/bin/bash
# This program obtains ISMR files from compressed binary files 
# more efficiently.
# -------------------------------
REMOTE_PATH='/media/cesar/data_sb/23_03_2022/'
ROOT_PATH='/home/cesar/Desktop/luisd/scripts_custom/libraries/bin_2_ismr/'
INPUT_PATH="${ROOT_PATH}Input_data/"
OUTPUT_PATH="${ROOT_PATH}Output_data/"
OUTPUT_PATH2='/home/cesar/Desktop/luisd/scripts/Obtencion_cintilaciones/data_input/Data_set/'
OUTPUT_PATH3='/home/cesar/Desktop/luisd/scripts/Obtencion_TEC/data_input/Data_set/'

CONVERTER='/opt/Septentrio/RxTools/bin/sbf2ismr'
STATION_NAME='lsba'
CHANGE_NAME=1

for file in ${REMOTE_PATH}*gz
do
  # Copy a binary file 
  cp ${file} ${INPUT_PATH}
  echo 'A binary file was copied!'

  # Uncompress a binary file 
  gunzip ${INPUT_PATH}*gz
  echo 'A binary file was uncompressed!'

  # Convert to an ISMR file
  ls ${INPUT_PATH}*_ | xargs -t -I % ${CONVERTER} -f % 
  echo 'A binary file was converted to an ISMR file!'

  # Rename files
  if [ ${CHANGE_NAME} -eq 1 ]
  then
  for file in ${INPUT_PATH}*ismr
  do 
    file_name=$(basename ${file})
    file_path=$(dirname ${file})
    mv ${file} "${file_path}/${file_name/SEPT/${STATION_NAME}}"
  done
  echo 'An ISMR file was renamed!'
  fi

  # Move files 
  cp ${INPUT_PATH}*ismr ${OUTPUT_PATH2} 
  cp ${INPUT_PATH}*ismr ${OUTPUT_PATH3} 
  mv ${INPUT_PATH}*ismr ${OUTPUT_PATH} 
  echo 'ISMR files were moved!'

  # Delete files
  rm ${INPUT_PATH}*_
  echo 'A binary file was removed!'
done

echo "$(date)"

