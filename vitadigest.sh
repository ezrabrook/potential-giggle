#!/bin/bash -x
HOST='datafeeds.shareasale.com'
USER=''
PASS=''
FILE='17329'
TITLE='VitaDigest'
cd ../feeds/shareasale/raw
pwd
ftp -inv $HOST << EOMYF
user $USER $PASS
cd /"$FILE"
pwd
binary
get "$FILE".txt.gz
disconnect
EOMYF
gunzip "$FILE".txt.gz
cd ../../../csvfix/csvfix/bin
pwd
./csvfix read_dsv -o ../../../feeds/shareasale/step1/"$FILE".txt ../../../feeds$
./csvfix edit -e s/YOURUSERID/743702/g -f 5 -o ../../../feeds/shareasale/step2/$
./csvfix exclude -f 1,3,6,10,14,16,17,21,22,23,24,25,27,28,29,30,31,32,33,34,35$
cd ../../../feeds/shareasale/step3
sed -i.bak 1i""Title","Catalog","URL","Image","Sale","Retail","Category","Descr$
cd ../../../csvfix/csvfix/bin
./csvfix merge -f 2,14 -k -p 1 -o ../../../feeds/shareasale/step4/"$FILE".txt .$
cd ../../../feeds/shareasale/step4
mv "$FILE".txt ../final/"$TITLE".txt
cd ../final
ls
rm ../raw/"$FILE".txt
rm ../step1/"$FILE".txt
rm ../step2/"$FILE".txt
rm ../step3/"$FILE".txt
rm ../step3/"$FILE".txt.bak