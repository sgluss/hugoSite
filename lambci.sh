HUGO_RELEASE="hugo_0.36_Linux-64bit"
echo "hugo dir will be /tmp/hugo/"$HUGO_RELEASE

echo "*** Starting build script ***"

echo "*** Copying hugo to tmp ***"
cp -R /var/task/hugo /tmp/

echo "*** Install hugo from tar.gz ***"
tar -xzf /tmp/hugo/$HUGO_RELEASE.tar.gz

echo "*** Verifying Hugo! ***"
./hugo version

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts

echo "*** Environment Variables***"
printenv

echo "*** Build script complete ***"