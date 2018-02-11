echo "*** Starting build script ***"

echo "*** Checking /var/task/ ***"
echo cd /var/task/
echo ls

echo "*** Verifying Hugo! ***"
hugo -h
cd ..

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"