.PHONY: keepright osmi all

# need tigerdelta
	# import, tasks, backup
	# waiting for it to stabilize

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
	sh src/s3.keepright.sh
