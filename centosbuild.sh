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
fi

cd ${PREFIX}
mkdir daemons
mkdir build
mkdir -p mint/Libraries
mkdir -p mint/Trunk
mkdir -p mint/Deps
cd mint/Libraries

wget -qO- http://sourceforge.net/projects/boost/files/boost/1.54.0/boost_1_54_0.tar.bz2/download | tar xjv
cd boost_1_54_0
./bootstrap.sh
./bjam --prefix=${PREFIX} link=static runtime-link=static install
cd ..
echo 'Installed boost'
sleep 4
wget -qO- http://www.openssl.org/source/openssl-1.0.1e.tar.gz| tar xzv
cd openssl-1.0.1e
if uname -a | grep -q x86_64 ; then
 ./Configure no-shared --prefix=${PREFIX} --openssldir=${PREFIX}/openssl linux-x86_64 -threads
 ./config --prefix=${PREFIX} -threads --openssldir=${PREFIX}/openssl
else
 ./Configure no-shared --prefix=${PREFIX} --openssldir=${PREFIX}/openssl linux-generic32
fi

echo "Installed openssl"
sleep 4
make
make install
cd ..

wget -qO- http://download.oracle.com/berkeley-db/db-4.8.30.tar.gz | tar xzv
cd db-4.8.30/build_unix
../dist/configure --prefix=${PREFIX}/ --enable-cxx
make
make install
cd ../..
echo "Installed Berkeley db"
sleep 4


wget -qO- https://leveldb.googlecode.com/files/leveldb-1.14.0.tar.gz | tar xzv
#cd leveldb-1.14.0/
cd ${PREFIX}/lib
make -f ${PREFIX}/leveldb-1.14.0/Makefile
cd ../
echo "installed leveldb"

wget -qO- https://protobuf.googlecode.com/files/protobuf-2.5.0.tar.bz2 | tar xjv
cd protobuf-2.5.0
./configure --prefix=${PREFIX}
make
make install
cd ..
echo 'Installed protobof'
sleep 4

