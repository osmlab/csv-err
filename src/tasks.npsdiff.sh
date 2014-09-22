mkdir npsdiff

echo "
    COPY (select ST_AsText(wkb_geometry) from ogrgeojson order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres npsdiff > npsdiff/npsdiff.csv
