mkdir npsdiff-tasks

echo "
    COPY (select ST_AsText(wkb_geometry), name, way from ogrgeojson) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres npsdiff > npsdiff-tasks/npsdiff.csv