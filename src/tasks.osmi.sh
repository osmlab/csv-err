set -e -u

mkdir osmi-tasks

echo "
    COPY (select ST_AsText(wkb_geometry) from intersection_lines order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/intersection_lines.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from intersections order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/intersections.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from role_mismatch order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/role_mismatch.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from role_mismatch_hull order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/role_mismatch_hull.csv

echo "
    COPY (select way_id, node_id from unconnected_major1 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/unconnected_major1.csv

echo "
    COPY (select way_id, node_id from unconnected_major2 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/unconnected_major2.csv

echo "
    COPY (select way_id, node_id from unconnected_major5 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/unconnected_major5.csv

echo "
    COPY (select way_id, node_id from unconnected_minor1 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/unconnected_minor1.csv

echo "
    COPY (select way_id, node_id from unconnected_minor2 order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/unconnected_minor2.csv

echo "
    COPY (select ST_AsText(wkb_geometry) from islands order by random()) to stdout DELIMITER ',' HEADER CSV;
" | psql -U postgres osmi > osmi-tasks/islands.csv
