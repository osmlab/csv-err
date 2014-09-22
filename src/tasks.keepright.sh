mkdir keepright

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from deadendoneway order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres keepright > keepright/deadendoneway.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from impossibleangle order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres keepright > keepright/impossibleangle.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from mixedlayer order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres keepright > keepright/mixedlayer.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from nonclosedways order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres keepright > keepright/nonclosedways.csv

echo "
    COPY (select object_type, object_id, ST_AsText(wkb_geometry) from highwaywater order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres keepright > keepright/highwaywater.csv
