.PHONY: keepright osmi all

install:
	sh src/install.sh

keepright-errors.txt.bz2:
	echo " --- downloading keepright dump"
	curl -f http://keepright.ipax.at/keepright_errors.txt.bz2 > keepright-errors.txt.bz2

keepright: keepright-errors.txt.bz2
	sh src/import.keepright.sh
	sh src/tasks.keepright.sh
	# sh src/s3.keepright.sh

osmi:
	sh src/import.osmi.sh
	sh src/tasks.osmi.sh
	# sh src/s3.osmi.sh

tiger-missing.json.gz:
	echo " --- downloading tigerdelta"
	curl -f "http://trafficways.org/obsolete/osm-diff-2014.json.gz" -o tiger-missing.json.gz

tigerdelta: tiger-missing.json.gz
	sh src/import.tigerdelta.sh
	sh src/tasks.tigerdelta.sh
	# sh src/s3.tigerdelta.sh

npsdiff5.json.gz:
	echo " --- downloading npsdiff"
	curl -f "http://trafficways.org/obsolete/nps-diff5.json.gz" -o nps-diff5.json.gz

npsdiff: npsdiff5.json.gz
	sh src/import.npsdiff.sh
	sh src/tasks.npsdiff.sh
	# sh src/s3.npsdiff.sh

clean:
	rm -f tiger-missing.json.gz
	rm -rf tigerdelta-tasks

	rm -f keepright-errors.txt.bz2
	rm -rf keepright-tasks

	rm -f *.gml
	rm -rf osmi-tasks

	rm -rf nps-diff5.json.gz 
	rm -rf npsdiff-tasks

all: keepright osmi	