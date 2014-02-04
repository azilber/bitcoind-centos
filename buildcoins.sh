#!/bin/bash


PREFIX=/opt/coins

CWD=`pwd`
USERNAME=`whoami`
LDFLAGS="-ltcmalloc_minimal -L/opt/gperf/lib -L/opt/coins/lib -L/usr/lib64 -L/usr/local/lib64"
CPPFLAGS="-I/opt/coins/include -I/opt/coins/include/boost -I/opt/coins/include/google -I/opt/coins/include/leveldb -I/opt/coins/include/openssl -I/usr/include"
export CPPFLAGS
export LDFLAGS

cd ${PREFIX}/build

coin=bitcoin
echo "Building $coin"
if [ -d ${coin} ]; then
cd ${coin}
git pull
else
mkdir ${coin}
git clone https://github.com/${coin}/${coin}.git ${coin}
cd ${coin}
fi
cd src
git checkout 0.8.5
make -f $CWD/makefile.bitcoin.unix
cp -vap ${coin}d ${PREFIX}/daemons/
cd ${PREFIX}/build
ls -al ${PREFIX}/daemons/${coin}d
strip ${PREFIX}/daemons/${coin}d
sleep 4

