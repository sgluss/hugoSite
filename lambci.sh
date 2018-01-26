echo "*** Starting build script ***"
echo "*** awscli installing! ***"
pip install awscli --upgrade --user

echo "*** Downloading Hugo! ***"
mkdir hugo && cd hugo
curl https://github.com/gohugoio/hugo/releases/download/v0.34/hugo_0.34_Linux-64bit.tar.gz --output hugo.tar.gz
echo "*** Unzipping Hugo! ***"
tar -xvf hugo.tar.gz
echo "*** Verifying Hugo! ***"
hugo -h
cd ..

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"