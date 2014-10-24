# detect platform
unamestr=`uname`
if [ "$unamestr" = 'Darwin' ]; then
   platform='osx'
   pg_user=`whoami`
elif [ "$unamestr" = 'Linux' ]; then
   platform='linux'
   pg_user='postgres'
fi

rm -rf npsdiff-tasks
mkdir npsdiff-tasks

echo "
    COPY (select ST_AsText(wkb_geometry) from ogrgeojson) to stdout DELIMITER ',' HEADER CSV;
" | psql -U $pg_user npsdiff > npsdiff-tasks/npsdiff.csv
