echo "*** Starting build script ***"

echo "*** Checking /var/task/ ***"
cd /var/task/
ls

echo "*** Copying hugo to tmp ***"
cp -R /var/task/hugo /tmp/

echo "*** Going to tmp hugo dir ***"
cd /tmp
echo "*** Contents of tmp ***"
ls
cd /tmp/hugo

echo "*** What's in hugo? ***"
ls

echo "*** Install hugo from tar.gz ***"
tar -xzf hugo_0.36_Linux-64bit.tar.gz
ls
cd hugo_0.36_Linux-64bit

echo "*** Contents of hugo release: ***"
ls

echo "*** Verifying Hugo! ***"
./hugo -h

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"