csv-err
==============

Normalizes existing datasources into minimal CSVs to fuel [to-fix](https://github.com/osmlab/to-fix). Currently uses KeepRight and OSM Inspector data.

### Installation on OS X
- We assume that you have the following prerequisites installed/would prefer that we not install them for you: GDAL, postgis and s3cmd. All are available via [Homebrew](http://brew.sh). Be sure to install GDAL with Postgres support: `brew install gdal --with-postgresql`.

### Installation on Ubuntu
- create your instance, I use `c3.xlarge`, others likely need some adjustments
- log in: `ssh -i ~/.ssh/<your key.pem> ubuntu@<instance public DNS>`
- `cd /mnt`
- `sudo apt-get install git make`
- `git clone https://github.com/osmlab/csv-err.git && cd csv-err/`
- when prompted by s3cmd provide your s3 key and secret
  - this is for uploading the finished product to s3, paths are hardcoded to the to-fix bucket, if you want to use your own you will have to change those paths in each s3.*.sh file

### Usage
- `sudo make install` - installs postgis and other prerequisites
- `sudo make keepright` - download, import, export, upload KeepRight only
- `sudo make osmi` - download, import, export, upload OSMI only
