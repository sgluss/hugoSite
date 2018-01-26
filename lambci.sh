echo "*** Starting build script ***"
echo "*** awscli installing! ***"
pip install awscli --upgrade --user

echo "*** Installing Hugo! ***"
apt-get install hugo
ls

echo "*** Verifying Hugo! ***"
hugo -h
cd ..

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"