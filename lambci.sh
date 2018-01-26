echo "*** Starting build script ***"

echo "*** Installing Hugo! ***"
npm install --prefix=~/lambdaTestFunction hugo-cli
echo "*** Verifying Hugo! ***"
hugo -h

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv

echo "*** Build script complete ***"