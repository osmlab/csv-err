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

mkdir tigerdelta-tasks

echo "
    COPY (select name, way, ST_AsText(wkb_geometry) from ogrgeojson where name != '') to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user tigerdelta > tigerdelta-tasks/tigerdelta-named.csv

echo "
    COPY (select name, way, ST_AsText(wkb_geometry) from ogrgeojson where name = '') to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user tigerdelta > tigerdelta-tasks/tigerdelta-noname.csv
