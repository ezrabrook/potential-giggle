#!/bin/bash -x
HOST='datatransfer.cj.com'
USER=''
PASS=''
cd ../feeds/cj/raw
pwd
ftp -inv $HOST << EOMYF
user $USER $PASS
cd outgoing/productcatalog/149800
pwd
binary
get A1Supplements_com-A1_Supplements_Product_Catalog.txt.gz A1Supplements.txt.gz
disconnect
EOMYF
gunzip A1Supplements.txt.gz
cd ../../../csvfix/csvfix/bin
pwd
./csvfix exclude -f 3,8,10,12,13,14,17,21,22,23,24,25,26,27,28,29,30,31,32,33,3$
./csvfix merge -f 1,8 -k -p 1 -o ../../../feeds/cj/step2/A1Supplements.txt ../.$
cd ../../../feeds/cj/final
pwd
mv ../step2/A1Supplements.txt A1Supplements.txt
cd ..
pwd
rm raw/A1Supplements.txt
rm step1/A1Supplements.txt
