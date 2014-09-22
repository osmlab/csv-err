# sh geocode.sh "San Francisco, CA"
# creates 'cities/San Francisco, CA.geojson' with results from the mapbox geocoder

# replace spaces with a hyphen
place=`echo ${1} | tr ' ' $'-'`
mkdir -p places
curl --retry 5 -f "http://api.tiles.mapbox.com/v4/geocode/mapbox.places-v1/${place}.json?access_token=pk.eyJ1IjoibWFwYm94IiwiYSI6IlhHVkZmaW8ifQ.hAMX5hSW-QnTeRCMAy9A8Q" -o places/${place}.geojson
echo "create places/${place}.geojson"
