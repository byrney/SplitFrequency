#!/bin/bash

set -u -e

# help for convert:
# convert gradient_dst.png gradient_src.png \
#           -compose Mathematics -define compose:args='1,0,0,0' -composite \
#           mathematics_multiply.png
# The four arguments, "A", "B", "C", and "D", define the formula...
#		A*Sc*Dc + B*Sc + C*Dc + D
# where "Sc" is the source or overlay image, and "Dc" is the background or destination image.  
#    high  = original - low + 0.5
#    recom = low + high - 0.5
#          = low + original - low + 0.5 - 0.5
#          = original	

original=${1:?Need to specify an input file}
imagename=${original%.*}
ext=${original##.*}

# Generate a PSD file with Low, High Frequency and Original Layers
convert  "$original"  -set label 'input' -alpha off -background none \
	\( +clone -set label 'copy' \) \
	\( +clone -blur 0x12 -set label 'LF' \)  \
	\( -clone 1,2  -compose mathematics -set option:compose:args "0,-1,1,0.5" -composite -set label 'HF' \)  \
	\( -clone 1 -set label 'original' \) \
	-delete 0 -alpha Off 	 "$imagename.psd"

# Copy exif data from the original file to the psd
exiftool -tagsFromFile "$original" -Make -Model -Artist -ExposureTime -FNumber -ISO -DateTimeOriginal -FocusMode -FlashMode  -Orientation -overwrite_original "$imagename.psd"

echo "$imagename.psd"


