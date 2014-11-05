#!/bin/sh
set -e -u

# detect platform
unamestr=`uname`
if [ "$unamestr" = 'Darwin' ]; then
   platform='osx'
   pg_user=`whoami`
   stat='stat -f%z'
elif [ "$unamestr" = 'Linux' ]; then
   platform='linux'
   pg_user='postgres'
   stat='stat -c%s'
fi

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

echo " --- downloading general errors from osmi"
# only interested in certain layers
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=role_mismatch_hull" -o role_mismatch_hull.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=role_mismatch" -o role_mismatch_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=intersections" -o intersection_points.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/multipolygon/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=intersection_lines" -o intersection_lines.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_major5" -o routing_major5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_major2" -o routing_major2.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_major1" -o routing_major1.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_minor2" -o routing_minor2.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&TYPENAME=unconnected_minor1" -o routing_minor1.gml

echo " --- downloading osmi unconnected_minor5"
# a request every 5 degrees
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=0,-80,5,80&TYPENAME=unconnected_minor5" -o 1.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=5,-80,10,80&TYPENAME=unconnected_minor5" -o 2.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=10,-80,15,80&TYPENAME=unconnected_minor5" -o 3.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=15,-80,20,80&TYPENAME=unconnected_minor5" -o 4.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=20,-80,25,80&TYPENAME=unconnected_minor5" -o 5.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=25,-80,30,80&TYPENAME=unconnected_minor5" -o 6.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=30,-80,35,80&TYPENAME=unconnected_minor5" -o 7.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=35,-80,40,80&TYPENAME=unconnected_minor5" -o 8.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=40,-80,45,80&TYPENAME=unconnected_minor5" -o 9.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=45,-80,50,80&TYPENAME=unconnected_minor5" -o 10.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=50,-80,55,80&TYPENAME=unconnected_minor5" -o 11.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=55,-80,60,80&TYPENAME=unconnected_minor5" -o 12.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=60,-80,65,80&TYPENAME=unconnected_minor5" -o 13.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=65,-80,70,80&TYPENAME=unconnected_minor5" -o 14.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=70,-80,75,80&TYPENAME=unconnected_minor5" -o 15.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=75,-80,80,80&TYPENAME=unconnected_minor5" -o 16.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=80,-80,85,80&TYPENAME=unconnected_minor5" -o 17.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=85,-80,90,80&TYPENAME=unconnected_minor5" -o 18.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=90,-80,95,80&TYPENAME=unconnected_minor5" -o 19.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=95,-80,100,80&TYPENAME=unconnected_minor5" -o 20.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=100,-80,105,80&TYPENAME=unconnected_minor5" -o 21.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=105,-80,110,80&TYPENAME=unconnected_minor5" -o 22.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=110,-80,115,80&TYPENAME=unconnected_minor5" -o 23.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=115,-80,120,80&TYPENAME=unconnected_minor5" -o 24.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=120,-80,125,80&TYPENAME=unconnected_minor5" -o 25.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=125,-80,130,80&TYPENAME=unconnected_minor5" -o 26.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=130,-80,135,80&TYPENAME=unconnected_minor5" -o 27.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=135,-80,140,80&TYPENAME=unconnected_minor5" -o 28.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=140,-80,145,80&TYPENAME=unconnected_minor5" -o 29.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=145,-80,150,80&TYPENAME=unconnected_minor5" -o 30.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=150,-80,155,80&TYPENAME=unconnected_minor5" -o 31.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=155,-80,160,80&TYPENAME=unconnected_minor5" -o 32.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=160,-80,165,80&TYPENAME=unconnected_minor5" -o 33.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=165,-80,170,80&TYPENAME=unconnected_minor5" -o 34.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=170,-80,175,80&TYPENAME=unconnected_minor5" -o 35.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=175,-80,180,80&TYPENAME=unconnected_minor5" -o 36.unconnected_minor5.gml

curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-5,-80,0,80&TYPENAME=unconnected_minor5" -o 37.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-10,-80,-5,80&TYPENAME=unconnected_minor5" -o 38.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-15,-80,-10,80&TYPENAME=unconnected_minor5" -o 39.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-20,-80,-15,80&TYPENAME=unconnected_minor5" -o 40.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-25,-80,-20,80&TYPENAME=unconnected_minor5" -o 41.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-30,-80,-25,80&TYPENAME=unconnected_minor5" -o 42.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-35,-80,-30,80&TYPENAME=unconnected_minor5" -o 43.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-40,-80,-35,80&TYPENAME=unconnected_minor5" -o 44.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-45,-80,-40,80&TYPENAME=unconnected_minor5" -o 45.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-50,-80,-45,80&TYPENAME=unconnected_minor5" -o 46.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-55,-80,-50,80&TYPENAME=unconnected_minor5" -o 47.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-60,-80,-55,80&TYPENAME=unconnected_minor5" -o 48.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-65,-80,-60,80&TYPENAME=unconnected_minor5" -o 49.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-70,-80,-65,80&TYPENAME=unconnected_minor5" -o 50.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-75,-80,-70,80&TYPENAME=unconnected_minor5" -o 51.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-80,-80,-75,80&TYPENAME=unconnected_minor5" -o 52.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-85,-80,-80,80&TYPENAME=unconnected_minor5" -o 53.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-90,-80,-85,80&TYPENAME=unconnected_minor5" -o 54.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-95,-80,-90,80&TYPENAME=unconnected_minor5" -o 55.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-100,-80,-95,80&TYPENAME=unconnected_minor5" -o 56.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-105,-80,-100,80&TYPENAME=unconnected_minor5" -o 57.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-110,-80,-105,80&TYPENAME=unconnected_minor5" -o 58.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-115,-80,-110,80&TYPENAME=unconnected_minor5" -o 59.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-120,-80,-115,80&TYPENAME=unconnected_minor5" -o 60.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-125,-80,-120,80&TYPENAME=unconnected_minor5" -o 61.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-130,-80,-125,80&TYPENAME=unconnected_minor5" -o 62.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-135,-80,-130,80&TYPENAME=unconnected_minor5" -o 63.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-140,-80,-135,80&TYPENAME=unconnected_minor5" -o 64.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-145,-80,-140,80&TYPENAME=unconnected_minor5" -o 65.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-150,-80,-145,80&TYPENAME=unconnected_minor5" -o 66.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-155,-80,-150,80&TYPENAME=unconnected_minor5" -o 67.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-160,-80,-155,80&TYPENAME=unconnected_minor5" -o 68.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-165,-80,-160,80&TYPENAME=unconnected_minor5" -o 69.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-170,-80,-165,80&TYPENAME=unconnected_minor5" -o 70.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-175,-80,-170,80&TYPENAME=unconnected_minor5" -o 71.unconnected_minor5.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-180,-80,-175,80&TYPENAME=unconnected_minor5" -o 72.unconnected_minor5.gml

echo " --- downloading osmi duplicate_ways"
# a request every 5 degrees
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=0,-80,5,80&TYPENAME=duplicate_ways" -o 1.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=5,-80,10,80&TYPENAME=duplicate_ways" -o 2.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=10,-80,15,80&TYPENAME=duplicate_ways" -o 3.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=15,-80,20,80&TYPENAME=duplicate_ways" -o 4.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=20,-80,25,80&TYPENAME=duplicate_ways" -o 5.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=25,-80,30,80&TYPENAME=duplicate_ways" -o 6.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=30,-80,35,80&TYPENAME=duplicate_ways" -o 7.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=35,-80,40,80&TYPENAME=duplicate_ways" -o 8.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=40,-80,45,80&TYPENAME=duplicate_ways" -o 9.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=45,-80,50,80&TYPENAME=duplicate_ways" -o 10.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=50,-80,55,80&TYPENAME=duplicate_ways" -o 11.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=55,-80,60,80&TYPENAME=duplicate_ways" -o 12.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=60,-80,65,80&TYPENAME=duplicate_ways" -o 13.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=65,-80,70,80&TYPENAME=duplicate_ways" -o 14.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=70,-80,75,80&TYPENAME=duplicate_ways" -o 15.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=75,-80,80,80&TYPENAME=duplicate_ways" -o 16.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=80,-80,85,80&TYPENAME=duplicate_ways" -o 17.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=85,-80,90,80&TYPENAME=duplicate_ways" -o 18.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=90,-80,95,80&TYPENAME=duplicate_ways" -o 19.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=95,-80,100,80&TYPENAME=duplicate_ways" -o 20.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=100,-80,105,80&TYPENAME=duplicate_ways" -o 21.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=105,-80,110,80&TYPENAME=duplicate_ways" -o 22.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=110,-80,115,80&TYPENAME=duplicate_ways" -o 23.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=115,-80,120,80&TYPENAME=duplicate_ways" -o 24.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=120,-80,125,80&TYPENAME=duplicate_ways" -o 25.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=125,-80,130,80&TYPENAME=duplicate_ways" -o 26.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=130,-80,135,80&TYPENAME=duplicate_ways" -o 27.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=135,-80,140,80&TYPENAME=duplicate_ways" -o 28.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=140,-80,145,80&TYPENAME=duplicate_ways" -o 29.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=145,-80,150,80&TYPENAME=duplicate_ways" -o 30.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=150,-80,155,80&TYPENAME=duplicate_ways" -o 31.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=155,-80,160,80&TYPENAME=duplicate_ways" -o 32.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=160,-80,165,80&TYPENAME=duplicate_ways" -o 33.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=165,-80,170,80&TYPENAME=duplicate_ways" -o 34.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=170,-80,175,80&TYPENAME=duplicate_ways" -o 35.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=175,-80,180,80&TYPENAME=duplicate_ways" -o 36.duplicate_ways.gml

curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-5,-80,0,80&TYPENAME=duplicate_ways" -o 37.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-10,-80,-5,80&TYPENAME=duplicate_ways" -o 38.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-15,-80,-10,80&TYPENAME=duplicate_ways" -o 39.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-20,-80,-15,80&TYPENAME=duplicate_ways" -o 40.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-25,-80,-20,80&TYPENAME=duplicate_ways" -o 41.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-30,-80,-25,80&TYPENAME=duplicate_ways" -o 42.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-35,-80,-30,80&TYPENAME=duplicate_ways" -o 43.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-40,-80,-35,80&TYPENAME=duplicate_ways" -o 44.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-45,-80,-40,80&TYPENAME=duplicate_ways" -o 45.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-50,-80,-45,80&TYPENAME=duplicate_ways" -o 46.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-55,-80,-50,80&TYPENAME=duplicate_ways" -o 47.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-60,-80,-55,80&TYPENAME=duplicate_ways" -o 48.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-65,-80,-60,80&TYPENAME=duplicate_ways" -o 49.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-70,-80,-65,80&TYPENAME=duplicate_ways" -o 50.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-75,-80,-70,80&TYPENAME=duplicate_ways" -o 51.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-80,-80,-75,80&TYPENAME=duplicate_ways" -o 52.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-85,-80,-80,80&TYPENAME=duplicate_ways" -o 53.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-90,-80,-85,80&TYPENAME=duplicate_ways" -o 54.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-95,-80,-90,80&TYPENAME=duplicate_ways" -o 55.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-100,-80,-95,80&TYPENAME=duplicate_ways" -o 56.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-105,-80,-100,80&TYPENAME=duplicate_ways" -o 57.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-110,-80,-105,80&TYPENAME=duplicate_ways" -o 58.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-115,-80,-110,80&TYPENAME=duplicate_ways" -o 59.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-120,-80,-115,80&TYPENAME=duplicate_ways" -o 60.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-125,-80,-120,80&TYPENAME=duplicate_ways" -o 61.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-130,-80,-125,80&TYPENAME=duplicate_ways" -o 62.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-135,-80,-130,80&TYPENAME=duplicate_ways" -o 63.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-140,-80,-135,80&TYPENAME=duplicate_ways" -o 64.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-145,-80,-140,80&TYPENAME=duplicate_ways" -o 65.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-150,-80,-145,80&TYPENAME=duplicate_ways" -o 66.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-155,-80,-150,80&TYPENAME=duplicate_ways" -o 67.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-160,-80,-155,80&TYPENAME=duplicate_ways" -o 68.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-165,-80,-160,80&TYPENAME=duplicate_ways" -o 69.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-170,-80,-165,80&TYPENAME=duplicate_ways" -o 70.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-175,-80,-170,80&TYPENAME=duplicate_ways" -o 71.duplicate_ways.gml
curl --retry 5 -f "http://tools.geofabrik.de/osmi/view/routing/wxs?SERVICE=WFS&VERSION=1.0.0&REQUEST=GetFeature&BBOX=-180,-80,-175,80&TYPENAME=duplicate_ways" -o 72.duplicate_ways.gml

dropdb -U $pg_user --if-exists osmi
createdb -U $pg_user -E UTF8 osmi
echo "CREATE EXTENSION postgis;
CREATE EXTENSION postgis_topology;" | psql -U $pg_user osmi

echo " --- importing islands"
for a in $(ls *.islands.gml); do
    if [ $($stat "$a") -gt 1000 ]
        then
            ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:4326 -append -f PostgreSQL PG:"dbname='osmi' user='$pg_user'" $a            
            rm -rf $a
        else
            echo " ---- problem with ${a}, not imported"
    fi
done

echo " --- importing osmi"
for a in $(ls *.gml); do
    if [ $($stat "$a") -gt 1000 ]
        then
            ogr2ogr -s_srs EPSG:4326 -t_srs EPSG:4326 -overwrite -f PostgreSQL PG:"dbname='osmi' user='$pg_user'" $a            
            rm -rf $a
        else            
            echo " ---- problem with ${a}, not imported"
    fi
done

