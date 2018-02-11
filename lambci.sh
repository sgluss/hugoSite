HUGO_RELEASE = "hugo_0.36_Linux-64bit"

echo "*** Starting build script ***"

echo "*** Copying hugo to tmp ***"
cp -R /var/task/hugo /tmp/

echo "*** Install hugo from tar.gz ***"
tar -xzf /tmp/hugo/$HUGO_RELEASE.tar.gz

echo "*** Verifying Hugo! ***"
./tmp/hugo/$HUGO_RELEASE/hugo -h

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"