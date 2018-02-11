echo "*** Starting build script ***"

echo "*** Checking /var/task/ ***"
cd /var/task/
ls

echo "copying hugo to tmp"
cp -R /var/task/hugo /tmp/

echo "going to tmp hugo dir"
cd /tmp
echo "contents of tmp"
ls
cd /tmp/hugo

echo "what's in hugo?"
ls

echo "install hugo for tar.gz"
tar -xzf hugo_0.36_Linux-64bit.tar.gz

echo "*** Verifying Hugo! ***"
hugo -h
cd ..

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"