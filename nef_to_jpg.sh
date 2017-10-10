#!/bin/bash

IMAGE_FOLDER='./JPG/'

# gimp control
gimp -v foo >/dev/null 2>&1 || { 
  echo "Gimp isn't installed!" >&2;
  sudo apt-get install gimp
}

# ufraw control
ufraw --version >/dev/null 2>&1 || {
  echo "ufraw isn't installed yet!" >&2;
  sudo apt-get install ufraw
}


# if images file doesn't exist
if [ ! -d $IMAGE_FOLDER ]; then  mkdir $IMAGE_FOLDER; fi

NEF_FILES=$(ls *.[Nn][Ee][Ff])

# change nef file to ppm

for image in $NEF_FILES
do
  ppm=$(echo $image | sed "s/[.].*/.ppm/")
  jpg=$(echo $image | sed "s/[.].*/.jpg/")

  ufraw-batch $image
  if [ -f $ppm ];
  then
    convert $ppm $IMAGE_FOLDER$jpg;
    if [ -f $ppm ]; then rm $ppm; fi
  fi
done
