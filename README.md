csv-err
==============

Normalizes existing datasources into minimal CSVs to fuel [to-fix](https://github.com/osmlab/to-fix). Currently uses KeepRight and OSM Inspector data.

![](./csv-err.png)

### Installation
- create your instance
- log in: `ssh -i ~/.ssh/<your key.pem> ubuntu@<instance public DNS>`
- `cd /mnt`
- `sudo apt-get install git make`
- `git clone https://github.com/osmlab/csv-err.git && cd csv-err/`

### Actions
- `sudo make install` - installs postgis and other prerequisites
- `sudo make keepright` - download, import, export, upload KeepRight only
- `sudo make osmi` - download, import, export, upload OSMI only
