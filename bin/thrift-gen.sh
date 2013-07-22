#!/bin/bash

Usage="Usage: thrift-gen.sh"

if [ "$#" -ne 0 ]; then
  echo $Usage
  exit 1
fi

bin=`cd "$( dirname "$0" )"; pwd`

rm -rf $bin/../src/main/java/tachyon/thrift

thrift_version=0.7.0
thrift_binary=/usr/share/thrift-${thrift_version}/bin/thrift
if [ ! -f "${thrift_binary}" ]; then
  thrift_binary=thrift
fi

if [ "$( ${thrift_binary} -version )" != "Thrift version ${thrift_version}" ]; then
  echo "Incorrect Thrift version installed, ${thrift_version} required" >&2
  echo "Thrift binary: ${thrift_binary}" >&2
  exit 1
fi

${thrift_binary} --gen java -out $bin/../src/main/java/. $bin/../src/thrift/tachyon.thrift

