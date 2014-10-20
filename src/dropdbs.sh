#!/bin/sh

# detect platform
unamestr=`uname`
if [ "$unamestr" = 'Darwin' ]; then
   platform='osx'
   pg_user=`whoami`
elif [ "$unamestr" = 'Linux' ]; then
   platform='linux'
   pg_user='postgres'
fi

dropdb -U $pg_user --if-exists keepright
dropdb -U $pg_user --if-exists tigerdelta
dropdb -U $pg_user --if-exists npsdiff
dropdb -U $pg_user --if-exists osmi