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

rm -rf osmi-tasks
mkdir osmi-tasks

echo "
    COPY (select ST_AsText(wkb_geometry) from role_mismatch) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/role_mismatch.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from intersections) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/intersections.csv

echo "
    COPY (select way_id, node_id from unconnected_major1) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/unconnected_major1.csv

echo "
    COPY (select way_id, node_id from unconnected_major2) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/unconnected_major2.csv

echo "
    COPY (select way_id, node_id from unconnected_major5) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/unconnected_major5.csv

echo "
    COPY (select way_id, node_id from unconnected_minor1) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/unconnected_minor1.csv

echo "
    COPY (select way_id, node_id from unconnected_minor2) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/unconnected_minor2.csv

echo "
    COPY (select way_id, node_id from unconnected_minor5) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/unconnected_minor5.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from duplicate_ways) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user osmi > osmi-tasks/duplicate_ways.csv

rm -f *.gml
