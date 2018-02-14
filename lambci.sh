echo "*** Starting build script ***"

HUGO_RELEASE="hugo_0.36_Linux-64bit"
AWS_RELEASE="aws-cli-1.14.37"

echo "hugo dir will be /tmp/hugo/"$HUGO_RELEASE

echo "*** Copying hugo to tmp ***"
cp -R /var/task/hugo /tmp/

echo "*** Install hugo from tar.gz ***"
tar -xzf /tmp/hugo/$HUGO_RELEASE.tar.gz

echo "*** Verifying Hugo! ***"
./hugo version

echo "*** Building site with Hugo! ***"
./hugo -s samHomePage

echo "*** Copying Hugo artifacts to AWS S3! ***"
node uploadSiteToS3.js

echo "*** Build script complete ***"