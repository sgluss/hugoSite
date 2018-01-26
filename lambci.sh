echo "*** Starting build script ***"
echo "*** awscli installing! ***"
pip install awscli --upgrade --user

echo "*** Installing Go! ***"
pip install go --upgrade --user
echo "*** Where is Go?! ***"
pip show go
echo "*** Add Go to Path ***"
export PATH=$PATH:/tmp/lambci/home/.local/lib/python2.7/site-packages/go/bin

echo "*** Getting Govendor! ***"
go get github.com/kardianos/govendor
echo "*** Getting Hugo! ***"
govendor get github.com/gohugoio/hugo
echo "*** Installing Hugo! ***"
go install github.com/gohugoio/hugo

echo "*** copying files to AWS S3! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Environment Variables***"
printenv
echo "*** Build script complete ***"