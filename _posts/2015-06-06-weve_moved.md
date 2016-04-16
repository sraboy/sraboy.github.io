---
layout: post
title:  "We've Moved!"
date:   2015-06-06 13:22:00
author: Steven Lavoie
tags:
- blog
---

For a secure connection, use these two URLs:

1. https://d2nh6fndvq714b.cloudfront.net - This is my Amazon CloudFront URL.
2. http://secure.daffysduck.com - HTTP Redirect to the above URL.
<!--more-->
I moved to Amazon's S3 cloud services to make use of [Jekyll](http://jekyllrb.com/). I was able to easily migrate all of the posts via Google's XML export and a simple Ruby Gem called [jekyll-import](https://github.com/jekyll/jekyll-import). A quick [quick Ruby script later](http://import.jekyllrb.com/docs/blogger/) and I was good to go. Luckily, someone else already [wrote a gem](https://github.com/laurilehmijoki/jekyll-s3) to automate pushing to S3 as well.

Using https on the daffysduck.com domain requires redirecting to CloudFront which causes browsers to display a warning since the certificate is for CloudFront but the URL is daffysduck.com; it appears to the browser to be malicious. Rather than visitors see a scary warning -- or pay my domain registrar -- I just switched everything back to HTTP and provided the redirect above.
