echo "*** Verify AWS CLI ***"
node /var/task/node_modules/aws-cli/bin/aws.js --version

HUGO_RELEASE="hugo_0.36_Linux-64bit"
AWS_RELEASE="aws-cli-1.14.37"

echo "hugo dir will be /tmp/hugo/"$HUGO_RELEASE

echo "*** Starting build script ***"

echo "*** Install awscli from tar.gz ***"
tar -xzf /var/task/awscli/$AWS_RELEASE.tar.gz 

echo "*** Verifying awscli! ***"
aws --version

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