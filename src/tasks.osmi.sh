mkdir osmi

echo "
    COPY (select ST_AsText(wkb_geometry) from intersection_lines order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/intersection_lines.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from intersections order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/intersections.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from role_mismatch order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/role_mismatch.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from role_mismatch_hull order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/role_mismatch_hull.csv

echo "
    COPY (select way_id, node_id from unconnected_major1 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/unconnected_major1.csv

echo "
    COPY (select way_id, node_id from unconnected_major2 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/unconnected_major2.csv

echo "
    COPY (select way_id, node_id from unconnected_major5 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/unconnected_major5.csv

echo "
    COPY (select way_id, node_id from unconnected_minor1 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/unconnected_minor1.csv

echo "
    COPY (select way_id, node_id from unconnected_minor2 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/unconnected_minor2.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from islands order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi/islands.csv

for a in $(ls osmi/*.csv); do
    if [ $(stat -c%s "${a}") -eq 0 ]
        then
            # delete anything that was obviously empty so they don't replace what is currently in S3
            rm -rf ${a}
            echo " --- deleted empty ${a}"
    fi
done
