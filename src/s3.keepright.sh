set -e -u

FILE="keepright-$(date +%s).zip"

mkdir -p keepright-tasks/dupes/
mv keepright-tasks/*.csv keepright-tasks/dupes/

for a in $(ls keepright-tasks/dupes/*.csv); do
    uniq $a > "keepright-tasks/$(basename $a)"
done

rm -rf keepright-tasks/dupes
zip -r ${FILE} keepright-tasks/
cp ${FILE} keepright-latest.zip

s3cmd put --acl-public ${FILE} s3://to-fix/$FILE
s3cmd put --acl-public keepright-latest.zip s3://to-fix/keepright-latest.zip

rm -rf keepright-*.zip
