#!/bin/bash

Usage="Usage: thrift-gen.sh <thrift_version>"

if [ "$#" -ne 1 ]; then
  echo $Usage
  exit 1
fi

thrift_version=$1

bin=`cd "$( dirname "$0" )"; pwd`

rm -rf $bin/../src/main/java/tachyon/thrift

thrift_binary=/usr/share/thrift-${thrift_version}/bin/thrift
if [ ! -f "${thrift_binary}" ]; then
  thrift_binary=thrift
fi

if [ "$( ${thrift_binary} -version )" != "Thrift version ${thrift_version}" ]; then
  echo "Incorrect Thrift version installed, ${thrift_version} required" >&2
  echo "Thrift binary: ${thrift_binary}" >&2
  exit 1
fi

set -x
${thrift_binary} --gen java -out $bin/../src/main/java/. $bin/../src/thrift/tachyon.thrift

