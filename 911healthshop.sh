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
get 911HealthShop_com-Product_Catalog.txt.gz 911HealthShop_com.txt.gz
disconnect
EOMYF
gunzip 911HealthShop_com.txt.gz
cd ../../../csvfix/csvfix/bin
pwd
./csvfix exclude -f 3,8,10,12,13,14,17,21,22,23,24,25,26,27,28,29,30,31,32,33,3$
./csvfix merge -f 1,8 -k -p 1 -o ../../../feeds/cj/step2/911HealthShop.txt ../.$
cd ../../../feeds/cj/final
pwd
mv ../step2/911HealthShop.txt 911HealthShop.txt
cd ..
pwd
rm raw/911HealthShop_com.txt
rm step1/911HealthShop.txt
