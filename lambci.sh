echo starting build script
pip install --user s3cmd
s3cmd put ./artifacts/syncme s3://hugosite-artifacts
echo build script complete