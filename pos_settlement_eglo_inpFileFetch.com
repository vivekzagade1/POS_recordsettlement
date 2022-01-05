#!/bin/bash
shopt -s extglob

cpFlPath=$1
outRecCntFile=$2
inpFlName=""
cntStat=""
zeF="Z"
onF="O"
moF="M"
word=""
word="EGBAZ510_"
word1=".txt"
echo $cpFlPath
inpFlCnt=`ls -t ${cpFlPath}${word}[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]${word1}|wc -l`
#inpFlCnt=`ls -t ${cpFlPath}[0-9]{9}[A-Za-z]{11}[0-9]{6}|wc -l`
echo $inpFlCnt
if [ $inpFlCnt -eq 0 ]; then
	cntStat=$zeF
else
	if [ $inpFlCnt -eq 1 ]; then
		cntStat=$onF
		inpFlName=`ls -t ${cpFlPath}${word}[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]${word1}`
		#inpFlName=`ls -t ${cpFlPath}[0-9]{9}[A-Za-z]{11}[0-9]{6}`
	else
		cntStat=$moF
		inpFlName=`ls -tr ${cpFlPath}${word}[0-9][0-9][0-9][0-9][0-9][0-9][0-9][0-9]${word1}`
	fi 
fi	

echo "${cntStat}${inpFlName}" >> ${outRecCntFile}