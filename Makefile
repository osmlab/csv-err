.PHONY: keepright osmi all

install:
	sh src/install.sh

all:
	sudo make keepright
	sudo make osmi

keepright:
	sh src/import.keepright.sh
	sh src/tasks.keepright.sh
	sh src/s3.keepright.sh

osmi:
	sh src/import.osmi.sh
	sh src/tasks.osmi.sh
	sh src/s3.osmi.sh

tigerdelta:
	sh src/import.tigerdelta.sh
	sh src/tasks.tigerdelta.sh
	sh src/s3.tigerdelta.sh

npsdiff:
	sh src/import.npsdiff.sh
	sh src/tasks.npsdiff.sh
	sh src/s3.npsdiff.sh
