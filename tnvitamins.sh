#!/bin/bash -x
HOST='datatransfer.cj.com'
USER=''
PASS=''
TITLE='TNVitamins-'
FILE='TNVitamins'
cd ../feeds/cj/raw
pwd
ftp -inv $HOST << EOMYF
user $USER $PASS
cd outgoing/productcatalog/149800
pwd
binary
get "$TITLE"Product_Catalog.txt.gz "$FILE".txt.gz
disconnect
EOMYF
gunzip "$FILE".txt.gz
cd ../../../csvfix/csvfix/bin
pwd
./csvfix exclude -f 3,8,10,12,13,14,17,21,22,23,24,25,26,27,28,29,30,31,32,33,3$
./csvfix merge -f 1,8 -k -p 1 -o ../../../feeds/cj/step2/"$FILE".txt ../../../f$
cd ../../../feeds/cj/final
pwd
mv ../step2/"$FILE".txt "$FILE".txt
cd ..
pwd
rm raw/"$FILE".txt
rm step1/"$FILE".txt