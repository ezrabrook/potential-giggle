#!/bin/bash -x
HOST='products.impactradius.com'
USER=''
PASS=''
TITLE='Bodybuilding'
cd ../feeds/impactradius/raw
pwd
ftp -inv $HOST << EOMYF
user $USER $PASS
cd Bodybuildingcom
pwd
binary
get Shoppingcom-format_IR.csv.gz "$TITLE".txt.gz
disconnect
EOMYF
gunzip "$TITLE".txt.gz
cd ../../../csvfix/csvfix/bin
pwd
./csvfix exclude -f 1,7,8,10,12,13,14,15,18,20,21,22,23,24,25,26,27,28,29,30,31$
./csvfix put -p 1 -v "Bodybuilding" -o ../../../feeds/impactradius/step2/"$TITL$
./csvfix merge -f 1,8 -k -p 1 -o ../../../feeds/impactradius/final/"$TITLE".txt$
cd ../../../feeds/impactradius/final
ls
cd ..
pwd
rm raw/"$TITLE".txt
rm step1/"$TITLE".txt
rm step2/"$TITLE".txt