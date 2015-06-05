set -e -u

FILE="tigerdelta-$(date +%s).zip"

zip -r ${FILE} tigerdelta-tasks/

cp ${FILE} tigerdelta-latest.zip

if $(which s3cmd); then
    s3cmd put --acl-public ${FILE} s3://to-fix/${FILE}
    s3cmd put --acl-public tigerdelta-latest.zip s3://to-fix/tigerdelta-latest.zip
fi

rm -rf tigerdelta-*.zip
