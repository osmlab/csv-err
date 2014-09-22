set -e -u

date=$(date)

for file in $(ls npsdiff/*.csv); do
    if [ $(stat -c%s "$a") -gt 1000 ]
        # filter out request errors, don't want to wipe out good stuff
        then
            basename=${file:0,-4}
            s3cmd put --acl-public ${file} s3://to-fix/${basename}-${date}.csv
            s3cmd put --acl-public ${file} s3://to-fix/${basename}-latest.csv
        else
            echo " --- problem with ${file}, not uploaded"
    fi
    rm -rf $file
done
