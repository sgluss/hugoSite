echo "*** Starting build script ***"

HUGO_RELEASE="hugo_0.55.6_Linux-64bit"
AWS_RELEASE="aws-cli-1.14.37"

echo "hugo dir will be /tmp/hugo/"$HUGO_RELEASE

echo "*** Copying hugo to tmp ***"
cp -R /var/task/hugo /tmp/
[ $? -eq 0 ]  || exit 1

echo "*** Install hugo from tar.gz ***"
tar -xzf /tmp/hugo/$HUGO_RELEASE.tar.gz
[ $? -eq 0 ]  || exit 1

echo "*** Verifying Hugo! ***"
./hugo version
[ $? -eq 0 ]  || exit 1

echo "*** Building site with Hugo! ***"
./hugo -s samHomePage
[ $? -eq 0 ]  || exit 1

echo "*** Copying Hugo artifacts to AWS S3! ***"
node uploadSiteToS3.js
[ $? -eq 0 ]  || exit 1

echo "*** Build script complete ***"
