#!/bin/bash



if [ $# -eq 0 ]
  then
    echo "Usage: $0 [filename_to_be_converted] [optional_new_file_name__without_extension]"
    exit 0 
fi

newFileName="${1%.*}"
newFileSize=$(stat -c%s "$1")


set -x
yes n | avidemux2_cli --load $1 --audio-codec ac3 --video-codec x264 --video-conf 2pass=$((newFileSize / 10000000)) --output-format avi --save $newFileName.avi
set +x