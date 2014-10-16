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

echo " --- downloading npsdiff"
curl -f "http://trafficways.org/obsolete/nps-diff5.json.gz" -o nps-diff5.json.gz

echo " --- unzipping"
gunzip nps-diff5.json.gz

echo " --- splitting into chunks"
split -l 100000 nps-diff5.json chunks-

createdb -U $pg_user -E UTF8 npsdiff
echo "CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;" | psql -U $pg_user npsdiff

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
        ogr2ogr -update -append -f PostgreSQL PG:"dbname='npsdiff' user='$pg_user'" $f
        rm -rf $f
    done
