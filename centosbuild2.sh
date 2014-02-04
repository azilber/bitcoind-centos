#!/bin/bash


PREFIX=/opt/coins

if [ ! -x /usr/bin/wget ] ; then
 echo "for some silly reason, wget is not executable.  Please fix this (as root do chmod +x /usr/bin/wget) and try again"
 exit
fi
CWD=`pwd`
USERNAME=`whoami`
LDFLAGS="-ltcmalloc_minimal -L/opt/gperf/lib -L/opt/coins/lib -L/usr/lib64 -L/usr/local/lib64"
CPPFLAGS="-I/opt/coins/include -I/opt/coins/include/boost -I/opt/coins/include/google -I/opt/coins/include/leveldb -I/opt/coins/include/openssl -I/usr/include"
export CPPFLAGS
export LDFLAGS

if [ ! -d ${PREFIX} ] ; then 
  mkdir ${PREFIX} 
  cd ${PREFIX}
  mkdir daemons
  mkdir build
  mkdir -p mint/Libraries
  mkdir -p mint/Trunk
  mkdir -p mint/Deps
else
  cd ${PREFIX}
fi

cd mint/Libraries

wget -qO- https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2 | tar xjv
cd protobuf-2.5.0
./configure --prefix=${PREFIX}
make
make install
cd ..
echo 'Installed protobof'
sleep 4

