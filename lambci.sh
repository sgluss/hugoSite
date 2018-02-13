echo "installing AWS CLI"
npm install aws-cli --save-dev
aws --version

HUGO_RELEASE="hugo_0.36_Linux-64bit"
echo "hugo dir will be /tmp/hugo/"$HUGO_RELEASE

echo "*** Starting build script ***"

echo "*** Copying hugo to tmp ***"
cp -R /var/task/hugo /tmp/

echo "*** Install hugo from tar.gz ***"
tar -xzf /tmp/hugo/$HUGO_RELEASE.tar.gz

echo "*** Verifying Hugo! ***"
./hugo version

echo "*** Building site with Hugo! ***"
./hugo -s light-hugo/site

echo "*** copying files to AWS S3! ***"
aws s3 cp light-hugo/site/public s3://hugosite-artifacts --recursive

echo "*** Build script complete ***"