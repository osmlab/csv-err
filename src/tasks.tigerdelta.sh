mkdir tigerdelta-tasks

echo "
    COPY (select ST_AsText(wkb_geometry), name, way from ogrgeojson where name != '' order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres tigerdelta > tigerdelta-tasks/tigerdelta-named.csv

echo "
    COPY (select ST_AsText(wkb_geometry), name, way from ogrgeojson where name = '' order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres tigerdelta > tigerdelta-tasks/tigerdelta-noname.csv
