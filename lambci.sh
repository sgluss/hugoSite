echo "*** Starting build script ***"
pip install awscli --upgrade --user
echo "*** awscli installed! ***"
aws s3 cp artifacts/syncme s3://hugosite-artifacts
echo "*** Build script complete ***"