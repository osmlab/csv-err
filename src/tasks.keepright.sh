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

rm -rf keepright-tasks
mkdir keepright-tasks

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from nonclosedways) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/nonclosedways.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from deadendoneway) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/deadendoneway.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from impossibleangle) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/impossibleangle.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from mixedlayer) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/mixedlayer.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from doubledplaces) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/doubledplaces.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from highwayfootpath) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/highwayfootpath.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from mispelledtags) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/mispelledtags.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from highwayhighway) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/highwayhighway.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from highwayriverbank) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/highwayriverbank.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from strangelayer) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/strangelayer.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from loopings) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user keepright > keepright-tasks/loopings.csv
