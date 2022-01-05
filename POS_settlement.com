######################################################################################################
#   Name                            : POS_settlement.com
#   Description                     : 
#   Author                          : Sharmila B M
#   Input                           : Input File Name
#   Output                          : NA
#   Menu Option                     : 
#   Calling Script                  : 
#   Called Script                   :  
#   Modification History            :
#   <Serial No.>    <Date>      <Author Name>   <Description>
#   1               01-Dec-2021  Sharmila B M
######################################################################################################
actFlag=$1
input1="${actFlag}"
##########################################################
#####Generating Session Id
##########################################################
FILE_PREFIX="$$"
PREFIX_PARAM="-p $$"
SOL_ID_PARAM=""
MODULE_ID_PARAM=""
export SOL_ID_PARAM
export MODULE_ID_PARAM
export FILE_PREFIX PREFIX_PARAM

Login=`execom trustedUserLogin.com`
Logout=`execom trustedUserLogout.com`

. $Login $PREFIX_PARAM $SOL_ID_PARAM $MODULE_ID_PARAM

if [ $exitStatus -ne 0 ]
then

       echo "Logon Failed"
       exit 1
fi

bc=$B2K_SESSION_ID
export bc



exebatch babx4061 $B2K_SESSION_ID pos_settlement_FileProcessing.scr $actFlag
ret_code=$?
echo $ret_code>>inpVals_${fileLoc}.lst

if [ $ret_code -eq 0 ]; then
	exit 0
else
	exit 1
fi

exit 0