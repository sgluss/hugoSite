echo "*** Starting build script ***"

HUGO_RELEASE="hugo_0.36_Linux-64bit"
AWS_RELEASE="aws-cli-1.14.37"

echo "hugo dir will be /tmp/hugo/"$HUGO_RELEASE

echo "*** Copying awscli to tmp ***"
cp -R /var/task/awscli /tmp/

echo "*** Install awscli from tar.gz ***"
tar -xzf /tmp/awscli/$AWS_RELEASE.tar.gz 
ls /tmp/awscli/

echo "*** Verifying awscli! ***"
./aws --version

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