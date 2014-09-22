IFS="
"

mkdir -p dump

for file in $(ls places/*.geojson); do

    bbox=$(cat ${file} | jq '.features[0].bbox')
    place=${file/places\/}
    place=${place/.geojson}

    if [ $(echo $bbox | jq 'length') -gt 0 ]
        then
            pieces=( `echo $bbox | tr ',[] ' $'\n'` )

            echo "
                COPY (select ST_AsText(wkb_geometry) from intersection_lines where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/intersection_lines.csv

            echo "
                COPY (select ST_AsText(wkb_geometry) from intersections where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/intersections.csv

            echo "
                COPY (select ST_AsText(wkb_geometry) from role_mismatch where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/role_mismatch.csv

            echo "
                COPY (select ST_AsText(wkb_geometry) from role_mismatch_hull where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/role_mismatch_hull.csv

            echo "
                COPY (select way_id, node_id from unconnected_major1 where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/unconnected_major1.csv

            echo "
                COPY (select way_id, node_id from unconnected_major2 where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/unconnected_major2.csv

            echo "
                COPY (select way_id, node_id from unconnected_major5 where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/unconnected_major5.csv

            echo "
                COPY (select way_id, node_id from unconnected_minor1 where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/unconnected_minor1.csv

            echo "
                COPY (select way_id, node_id from unconnected_minor2 where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/unconnected_minor2.csv

            echo "
                COPY (select ST_AsText(wkb_geometry) from islands where ST_Contains(ST_Envelope(ST_GeomFromText('MULTIPOINT(${bbox[0]} ${bbox[1]}, ${bbox[2]} ${bbox[3]})', 4326)), wkb_geometry) order by random()) to stdout DELIMITER ',' HEADER CSV;
            " | psql -U postgres osmi > dump/${place}/islands.csv

            echo " --- done: ${place}"
    fi

done
