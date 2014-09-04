.PHONY: keepright osmi all

# need tigerdelta
	# import, tasks, backup
	# waiting for it to stabilize

install:
	sh install.sh

all:
	sudo make keepright
	sudo make osmi

keepright:
	sh import.keepright.sh
	sh tasks.keepright.sh
	sh s3.keepright.sh

osmi:
	sh import.osmi.sh
	sh tasks.osmi.sh
	sh s3.keepright.sh
