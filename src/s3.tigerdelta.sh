set -e -u

FILE="tigerdelta-$(date +%s).zip"

zip -r ${FILE} tigerdelta-tasks/

cp ${FILE} tigerdelta-latest.zip

s3cmd put --acl-public ${FILE} s3://to-fix/${FILE}
s3cmd put --acl-public tigerdelta-latest.zip s3://to-fix/tigerdelta-latest.zip

rm -rf tigerdelta-*.zip
