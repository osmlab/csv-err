#!/bin/sh

set -e -u

# detect platform
unamestr=`uname`
if [ "$unamestr" = 'Darwin' ]; then
   platform='osx'
   pg_user=`whoami`
elif [ "$unamestr" = 'Linux' ]; then
   platform='linux'
   pg_user='postgres'
fi

echo " --- unzipping"
gunzip tiger-missing.json.gz

echo " --- splitting into chunks"
split -l 100000 missing.json chunks-

# sudo -u postgres createdb -U postgres -T template_postgis -E UTF8 tigerdelta
createdb -U $pg_user -T template_postgis -E UTF8 tigerdelta

# http://gis.stackexchange.com/a/16357/26389
echo '{"type":"FeatureCollection","features":[' > head
echo ']}' > tail

# add commas to each line
for f in chunks-*;
    do
        awk '{print $0","}' $f > c-$f
        rm -rf $f
    done

echo " --- creating valid geojson"
# add featurecollection head and tail
for f in c-*;
    do
        cat head $f tail > j-$f
        rm -f $f;
    done

echo " --- inserting into postgis"
# insert each chunk into postgis
for f in j-*;
    do
        # sudo -u $pg_user ogr2ogr -update -append -f PostgreSQL PG:"dbname='tigerdelta' user='$pg_user'" $f
        ogr2ogr -update -append -f PostgreSQL PG:"dbname='tigerdelta' user='$pg_user'" $f
        rm -rf $f
    done
