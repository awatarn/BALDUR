#!/bin/csh -f
# Apiwat wrote this script on Feb 6, 2015
# The script will call slist-sim to obtain data 
# usage:
# ./callSlist iter a001
# Note that the script must be call outside folder a001
#
echo "callSlist.sh is starting"
set fn1 = $argv[1]
set fn2 = $argv[2]
set filename = $fn1$fn2 

cd $fn2
echo "Enter director: "
pwd
echo "Working......... (please wait)..........."
/home/apiwat/Research_plasma/scripts/slist-sim $filename TI0 1.
/home/apiwat/Research_plasma/scripts/slist-sim $filename WTOT 1.E-7
/home/apiwat/Research_plasma/scripts/slist-sim $filename POHT 1.E-7
/home/apiwat/Research_plasma/scripts/slist-sim $filename PRAD 1.E-7
/home/apiwat/Research_plasma/scripts/slist-sim $filename TE0 1.
/home/apiwat/Research_plasma/scripts/slist-sim $filename NEVAVO 1.E-12
/home/apiwat/Research_plasma/scripts/slist-sim $filename PALFT 1.E-6
/home/apiwat/Research_plasma/scripts/slist-sim $filename NE0 1.E-12
/home/apiwat/Research_plasma/scripts/slist-sim $filename NI0 1.E-12
cd ..
echo 'Done. Have a good result!'

