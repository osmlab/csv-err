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

# uncompress the file
echo " --- opening up the keepright dump"
bunzip2 -kf keepright-errors.txt.bz2

# pull out header row of CSV
echo " --- removing header"
sed -i.bak '1,1d' keepright-errors.txt && rm keepright-errors.txt.bak

# fix NULL issues, NULLs for text in MySQL, not in Postgres
# COPY takes slashes literally, remove them
# the use of an actual extension w/ -i seems to be necessary to
# avoid zero-length files as output. weird.
echo " --- fixing NULL problems"
sed -i.bak -e 's/\\//g' -e 's/\\N/NULLs/g' keepright-errors.txt && rm keepright-errors.txt.bak

# create the db
dropdb -U $pg_user --if-exists keepright
createdb -U $pg_user -E UTF8 keepright
echo "CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;" | psql -U $pg_user keepright

echo "
    CREATE TYPE obj_type AS ENUM('node', 'way', 'relation');
" | psql -U $pg_user keepright

echo "
    CREATE TYPE the_state AS ENUM('new','reopened','ignore_temporarily','ignore');
" | psql -U $pg_user keepright

echo "
    CREATE TABLE errors (
        schema varchar(6) NOT NULL,
        error_id integer NOT NULL,
        error_type integer NOT NULL,
        error_name varchar(255) NOT NULL,
        object_type obj_type NOT NULL,
        object_id bigint NOT NULL,
        state the_state NOT NULL,
        first_occurrence timestamp NOT NULL,
        last_checked timestamp NOT NULL,
        object_timestamp timestamp NOT NULL,
        user_name varchar(255) NOT NULL,
        lat integer NOT NULL,
        lon integer NOT NULL,
        comment varchar(10000),
        comment_timestamp bytea,
        msgid bytea,
        txt1 bytea,
        txt2 bytea,
        txt3 bytea,
        txt4 bytea,
        txt5 bytea
    );
" | psql -U $pg_user keepright
# using bytea for now

echo " --- keepright -> postgres"
echo "
    COPY errors from '$PWD/keepright-errors.txt';
" | psql -U $pg_user keepright

echo "
    ALTER TABLE errors ADD COLUMN wkb_geometry GEOMETRY (POINT, 4326);
    UPDATE errors SET wkb_geometry = ST_SetSRID(ST_MakePoint(lon/10000000.0, lat/10000000.0), 4326);
" | psql -U $pg_user keepright

# let's pick a few errors: https://gist.github.com/aaronlidman/7bb7b84f2a6689f7e94f
echo " --- selecting nonclosedways"
echo "
    CREATE TABLE nonclosedways AS SELECT object_type, object_id, wkb_geometry from errors where error_name = 'non-closed areas';
" | psql -U $pg_user keepright

echo " --- selecting deadendoneway"
echo "
    CREATE TABLE deadendoneway AS SELECT object_type, object_id, wkb_geometry from errors where error_name = 'dead-ended one-ways';
" | psql -U $pg_user keepright

echo " --- selecting impossibleangle"
echo "
    CREATE TABLE impossibleangle AS SELECT object_type, object_id, wkb_geometry from errors where error_name = 'impossible angles';
" | psql -U $pg_user keepright

echo " --- selecting mixedlayer"
echo "
    CREATE TABLE mixedlayer as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'mixed layers intersections';
" | psql -U $pg_user keepright

echo " --- selecting highwaywater"
echo "
    CREATE TABLE highwaywater as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'highway-waterway';
" | psql -U $pg_user keepright

echo " --- selecting doubledplaces"
echo "
    CREATE TABLE doubledplaces as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'doubled places';
" | psql -U $pg_user keepright

echo " --- selecting highwayfootpath"
echo "
    CREATE TABLE highwayfootpath as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'highway-cyclew/footp';
" | psql -U $pg_user keepright

echo " --- selecting mispelledtags"
echo "
    CREATE TABLE mispelledtags as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'misspelled tags';
" | psql -U $pg_user keepright

echo " --- selecting island"
echo "
    CREATE TABLE island as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'floating islands';
" | psql -U $pg_user keepright

echo " --- selecting almostjunction"
echo "
    CREATE TABLE almostjunction as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'almost-junctions';
" | psql -U $pg_user keepright

echo " --- selecting highwayhighway"
echo "
    CREATE TABLE highwayhighway as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'highway-highway';
" | psql -U $pg_user keepright

echo " --- selecting highwayriverbank"
echo "
    CREATE TABLE highwayriverbank as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'highway-riverbank';
" | psql -U $pg_user keepright

echo " --- selecting strangelayer"
echo "
    CREATE TABLE strangelayer as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'strange layers';
" | psql -U $pg_user keepright

echo " --- selecting loopings"
echo "
    CREATE TABLE loopings as SELECT object_type, object_id, wkb_geometry from errors where error_name = 'loopings';
" | psql -U $pg_user keepright

# drop the rest of the db that we don't need
echo "
    DROP TABLE errors;
" | psql -U $pg_user keepright
