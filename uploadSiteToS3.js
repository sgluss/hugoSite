const AWS = require('aws-sdk');
const path = require("path");
const fs = require('fs');

const uploadDir = function(s3Path, bucketName) {

    let s3 = new AWS.S3();

    function walkSync(currentDirPath, callback) {
        fs.readdirSync(currentDirPath).forEach(function (name) {
            let filePath = path.join(currentDirPath, name)
            let stat = fs.statSync(filePath)
            if (stat.isFile()) {
                callback(filePath, stat)
            } else if (stat.isDirectory()) {
                walkSync(filePath, callback)
            }
        })
    }

    walkSync(s3Path, function(filePath, stat) {
        let bucketPath = filePath.substring(s3Path.length + 1)
		
		let contentType
		
        let params = {
			Bucket: bucketName, 
			Key: bucketPath, 
			Body: fs.readFileSync(filePath),
			ACL: 'public-read',	// make bucket contents readable so people can see the site
			Content-Type: 'text/html'
		}
        s3.putObject(params, function(err, data) {
            if (err) {
                console.log(err)
            } else {
                console.log('Successfully uploaded '+ bucketPath +' to ' + bucketName)
            }
        })

    })
}

uploadDir('light-hugo/site/public', 'hugosite-artifacts');
