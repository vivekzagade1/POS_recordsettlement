#!/bin/bash
shopt -s extglob

cpFlPath1=$1
footer=$2
echo $cpFlPath1
header1=`head -1 $cpFlPath1`
footer1=`tail -1 $cpFlPath1`
echo $header1
echo $footer1
echo $footer1 >> ${footer}