set -e -u

FILE="osmi-$(date +%s).zip"

mkdir -p osmi-tasks/dupes/
mv osmi-tasks/*.csv osmi-tasks/dupes/

for a in $(ls osmi-tasks/dupes/*.csv); do
    uniq $a > "osmi-tasks/$(basename $a)"
done

rm -rf osmi-tasks/dupes
zip -r ${FILE} osmi-tasks/
cp ${FILE} osmi-latest.zip

if $(which s3cmd); then
    s3cmd put --acl-public ${FILE} s3://to-fix/${FILE}
    s3cmd put --acl-public osmi-latest.zip s3://to-fix/osmi-latest.zip
fi

rm -rf osmi-*.zip
