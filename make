#!/bin/bash
#Script to compile flashbsm or the tracer
#Made by delfick
#flashbsm and tracer by delfick

#location of kagswf
kagswf=~/source/kagswf/kagswf
ccsmImages=/usr/local/share/ccsm/images

#Help Function
  helpme() 
  {
  	echo -e "\tUsage: flashbsm | tracer | images"
  }

#lets compile :D
if [ "$1" == "flashbsm" ]; then
	$kagswf -out flashbsm.swf -html -w 1240 -h 830 -fps 48 -cp classPath
	#$kagswf -out flashbsm.swf -html -w 667 -h 412 -fps 48 -cp classPath
	exit 0

elif [ "$1" == "tracer" ]; then
	$kagswf -out tracer.swf -html -w 700 -h 400 -fps 48 -p tracer -cp classPath 
	cp html/tracer.html .
	exit 0
	
elif [ "$1" == "images" ]; then
	ls $ccsmImages
	cp $ccsmImages/* images/icons/
	cd images/icons
	for i in *.svg; do inkscape -f "$i" -e "${i%%.svg*}.png" -w 50; done
	cd ../..
	exit 0
	
else
	helpme
	exit 1

fi
