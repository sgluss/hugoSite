---
title: "Static Page S3 Route53"
date: 2018-02-28T22:04:13-08:00
draft: true
type: "post"

author: "Samuel Gluss"
---

# Hosting A Static Page on AWS S3 with Route53
So yes, I should get out more and try some Google cloud services maybe. Next week, I swear.

In the meantime, why would you want to host your static page on Route53? Well, it's easy enough, albeit with the usual AWS idiosyncracies. I was able to reserve this domain for just 11 bucks a year, so the price is right. Finally, I can keep my info relatively private (contact info is kept as private as possible, and they throw that in for free!)

First things first, go to Route53 in AWS console, and get yourself a shiny new domain.

![Pick a Domain](https://s3-us-west-1.amazonaws.com/samgluss.net/img/static-site-s3-route53/pickADomain.png "Pick the one you want and select 'add to cart'")

Next, make sure your S3 bucket name MATCHES the domain name you chose. You may need to copy your bucket to a new one with the right name. 

![Bucket Setup](https://s3-us-west-1.amazonaws.com/samgluss.net/img/static-site-s3-route53/bucketConfig.png "Set up your bucket")

Furthermore, the bucket should be configured for static web hosting, which can be found in the bucket properties. Default options are going to be ok for most sites.

![Bucket Static Site Setup](https://s3-us-west-1.amazonaws.com/samgluss.net/img/static-site-s3-route53/setAsStaticSite.png "Make sure your bucket is configured to host a static site")

Next, let's get your domain name actually pointing to that statically hosted page.

Head over to Route53, and select Hosted Zones. From here, click on the domain you created.

![Route53 HostedZones Setup](https://s3-us-west-1.amazonaws.com/samgluss.net/img/static-site-s3-route53/hostedZones.png "Now we'll create a hosted zone alias for your site")

Click `Create Record Set`, then set up your bucket Alias

![Route53 Record Set Setup](https://s3-us-west-1.amazonaws.com/samgluss.net/img/static-site-s3-route53/addRecordSet.png "Set up a Record Set for your site Alias")

Leave `Name` blank, and select `Alias` for ContentType

For Alias Target, select your S3 Static Page (this should be something like `s3-website-us-west-1.amazonaws.com`)

Click Create, which will cause this alias to point your domain at your S3 site. Now you can try visiting your domain URL in a browser to admire your shiny site!