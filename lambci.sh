echo "*** Starting build script ***"
echo "*** awscli installing! ***"
pip install awscli --upgrade --user

echo "*** Installing Hugo! ***"
npm install hugo-cli
npm install hugo
echo "*** Verifying Hugo! ***"
ls /tmp/node_modules
hugo -h

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"