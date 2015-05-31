#!/bin/bash
#resize images for website and upload

## Folders listed below must be created before use
#Source of files
source=
#Temp work space left empty at end
temp=
#local mirror folder of website images
live=
#webfolder in shh form u/n@host:/full path (pwd output)
webfolder=USERNAME@HOST:/FULL/PATH/TO/IMAGE/DIR/ON/SERVER

hash mogrify 2>/dev/null || { echo >&2 "I require mogrify it's not installed.  That's sad."; exit 1; }

#check for local folders
if [ ! -d "$source" ]; then
  echo "Source Directory not found"
  exit 0
fi

if [ ! -d "$temp" ]; then
  echo "Temp Directory not found"
  exit 0
fi

if [ ! -d "$live" ]; then
  echo "Live Directory not found"
  exit 0
fi

#newfile found variable
newfiles=0

#Move new files from source in to temp area
cd $source

#look for files in source folder greater than zero in size and move to temp
for filename in *; do
    name=${filename##*/}
    if [ -s "$name" ]
      then mv $name $temp
      newfiles=1
      # write zero size file so file name shown as used
      touch $name
      echo "new image"
    fi
done

if (( $newfiles == 1 )); then
#move to temp area and then make new file sizez
echo "resizing"
cd $temp

for filename in *; do
    name=${filename##*/}
    cp $name 740-$name
    mogrify -path $live -resize 1600 $name
    mogrify -path $live -resize 740 740-$name
    rm $name
    rm 740-$name
done

#upload files to webserver via rsync over ssh
echo "uploading"
cd $live
rsync -re ssh * $webfolder
else
echo "no new images"
fi
