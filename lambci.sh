echo "Starting build script"
pip install --user s3cmd
echo "*** pip installed! ***"
s3cmd put ./artifacts/syncme s3://hugosite-artifacts
echo "Build script complete"