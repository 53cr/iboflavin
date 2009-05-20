#!/bin/sh

cd ~
git clone git://github.com/etrepum/tokyo-cabinet.git 
cd tokyo-cabinet
./configure && make && sudo make install

cd ~
git clone git://github.com/etrepum/tokyo-tyrant.git 
cd tokyo-tyrant
./configure && make && sudo make install

sudo gem install rufus-tokyo

echo "Run Tyrant server like: ttserver -port 45001 data.tch"
echo "iBoflavin uses 45001, data.tch will be created."
