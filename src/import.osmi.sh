set -e -u

# http://wiki.openstreetmap.org/wiki/OSM_Inspector/WxS

# views:
# http://tools.geofabrik.de/osmi/view

# layers:
# http://tools.geofabrik.de/osmi/views/multipolygon/view.json
# http://tools.geofabrik.de/osmi/views/addresses/view.json
# http://tools.geofabrik.de/osmi/views/geometry/view.json
# http://tools.geofabrik.de/osmi/views/tagging/view.json
# http://tools.geofabrik.de/osmi/views/boundaries/view.json
# http://tools.geofabrik.de/osmi/views/water/view.json
# http://tools.geofabrik.de/osmi/views/places/view.json
# http://tools.geofabrik.de/osmi/views/highways/view.json
# http://tools.geofabrik.de/osmi/views/routing/view.json

# I'm only interested in certain layers
# commented out lines send 500 err, I think there are just too many, want to find a way around that
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=role_mismatch_hull" -o role_mismatch_hull.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=role_mismatch" -o role_mismatch_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=intersections" -o intersection_points.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=intersection_lines" -o intersection_lines.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_major5" -o routing_major5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_major2" -o routing_major2.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_major1" -o routing_major1.gml
# curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_minor5" -o routing_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_minor2" -o routing_minor2.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_minor1" -o routing_minor1.gml
# curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=duplicate_ways" -o duplicate_ways.gml

# islands
# a request every 5 degrees
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=0,-80,5,80&TYPENAME=islands" -o 1.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=5,-80,10,80&TYPENAME=islands" -o 2.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=10,-80,15,80&TYPENAME=islands" -o 3.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=15,-80,20,80&TYPENAME=islands" -o 4.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=20,-80,25,80&TYPENAME=islands" -o 5.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=25,-80,30,80&TYPENAME=islands" -o 6.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=30,-80,35,80&TYPENAME=islands" -o 7.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=35,-80,40,80&TYPENAME=islands" -o 8.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=40,-80,45,80&TYPENAME=islands" -o 9.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=45,-80,50,80&TYPENAME=islands" -o 10.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=50,-80,55,80&TYPENAME=islands" -o 11.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1..0&REQUEST=GetFeature&BBOX=55,-80,60,80&TYPENAME=islands" -o 12.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=60,-80,65,80&TYPENAME=islands" -o 13.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=65,-80,70,80&TYPENAME=islands" -o 14.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=70,-80,75,80&TYPENAME=islands" -o 15.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=75,-80,80,80&TYPENAME=islands" -o 16.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=80,-80,85,80&TYPENAME=islands" -o 17.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=85,-80,90,80&TYPENAME=islands" -o 18.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=90,-80,95,80&TYPENAME=islands" -o 19.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=95,-80,100,80&TYPENAME=islands" -o 20.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=100,-80,105,80&TYPENAME=islands" -o 21.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=105,-80,110,80&TYPENAME=islands" -o 22.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=110,-80,115,80&TYPENAME=islands" -o 23.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=115,-80,120,80&TYPENAME=islands" -o 24.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=120,-80,125,80&TYPENAME=islands" -o 25.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=125,-80,130,80&TYPENAME=islands" -o 26.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=130,-80,135,80&TYPENAME=islands" -o 27.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=135,-80,140,80&TYPENAME=islands" -o 28.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=140,-80,145,80&TYPENAME=islands" -o 29.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=145,-80,150,80&TYPENAME=islands" -o 30.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=150,-80,155,80&TYPENAME=islands" -o 31.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=155,-80,160,80&TYPENAME=islands" -o 32.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=160,-80,165,80&TYPENAME=islands" -o 33.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=165,-80,170,80&TYPENAME=islands" -o 34.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=170,-80,175,80&TYPENAME=islands" -o 35.islands.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=175,-80,180,80&TYPENAME=islands" -o 36.islands.gml

sudo -u postgres createdb -U postgres -T template_postgis -E UTF8 osmi

echo " --- importing osmi"
for a in $(ls *.gml); do
    sudo -u postgres ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:4326 -overwrite -f PostgreSQL PG:dbname=osmi $a
done

rm -rf *.gml
