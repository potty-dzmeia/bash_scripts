#!/bin/bash


#for every file in the current directory
for file in ./*".MOV"; do

  movFile=${file##*/}
  
  #echo "compressVideo.sh $movFile"
  compressVideo.sh $movFile
  
  # remove temp files
  fileWithoutExtension=${movFile%.*}
  
  # if something failed we will have "temp" files
  rm $fileWithoutExtension.stat.mbtree.temp
  rm $fileWithoutExtension.stat.temp
  
  # if success we will have such leftovers
  rm $fileWithoutExtension.stat.mbtree
  rm $fileWithoutExtension.stat
 
done