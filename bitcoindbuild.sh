#!/bin/bash

if [ ! -x /usr/bin/wget ] ; then
 echo "for some silly reason, wget is not executable.  Please fix this (as root do chmod +x /usr/bin/wget) and try again"
 exit
fi
CWD=`pwd`
USERNAME=`whoami`
LDFLAGS='-l tcmalloc_minimal -L /opt/gperf/lib'
export LDFLAGS

cd ~/Bitcoin/Libraries

if [ -d bitcoin-master ];then
  rm -Rf bitcoin-master
fi

mkdir bitcoin-master

cd bitcoin-master

pwd
sleep 5
wget -qO- https://github.com/bitcoin/bitcoin/tarball/master --no-check-certificate | tar xzv --strip-components 1
cd src
make -f $CWD/makefile.new bitcoind
cp -vap bitcoind ~$USERNAME/
cd $CWD
