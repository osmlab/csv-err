mkdir tigerdelta

echo "
    COPY (select ST_AsText(wkb_geometry), name, way from ogrgeojson where name != '' order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres tigerdelta > tigerdelta/tigerdelta-named.csv

echo "
    COPY (select ST_AsText(wkb_geometry), name, way from ogrgeojson where name = '' order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres tigerdelta > tigerdelta/tigerdelta-noname.csv
