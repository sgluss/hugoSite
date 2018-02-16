---
author: "Samuel Gluss"
date: 2018-02-12
linktitle: Hugo and Lambci
menu: "Home"
title: Getting Started With Hugo and Lambci
weight: 10
draft: false
type: "post"
---

### **Introduction**

Hugo with LambCI is a combination with a lot of potential: a blog that can be updated from any machine, just by pushing markdown to GitHub. This is entirely achievable with a simple AWS-based toolchain, and no servers required!
<!--more-->

This project is fundamentally based on two pieces of software: [LambCI](https://github.com/lambci) and [Hugo](https://gohugo.io/)

LambCI is the work of Michael Hart, [who did a great write-up on what is is capable of here](https://medium.com/@hichaelmart/lambci-4c3e29d6599b)

Hugo is an extremely fast static site generator written in (you guessed it) Go, and which is easy to install as a binary executable on most any system. These properties will come in handy later!

#### **Getting started**

First thing's first! You're gonna need a project dir on your local dev rig, let's call it: `project/`
and you are gonna need a GitHub repo for `project`, along with an AWS account.

#### **Setting Up Lambci**
[Follow the instructions here to get a GitHub token and launch the CloudFormation Stack in AWS](https://github.com/lambci/lambci#installation)

The default configuration utilizes Node. The interpreter will execute the script designated as the handler at the root of your repo.
**TODO::screenshot of interpreter/handler selection screen in AWS lambda config**
I used the following code in lambci.json to set a shell script to executable, and run it:
```
{
  "cmd": "chmod +x lambci.sh && ./lambci.sh"
}
```
Note that whatever handler you choose should be located in your repo base dir. In this case, my shell script `lambci.sh` is in the repo base as well.

I chose to do the heavy lifting in this shell script. If I do this again, I'll probably select Python over Node (Python is very well suited to these OS/shell automation tasks, and I'm more comfortable with it), and do the entire build process in the Python handler script.

Getting to this point is not that bad. The LambCI CloudFormation template does all the heavy lifting for you, and now you have a build script that will run on the new state of the repo, every time you push to it. With no server, how cool is that?

#### **Wait a Minute... what was Michael saying about 'Current Limitations'?**
Yeah, review those [here](https://github.com/lambci/lambci#current-limitations-due-to-the-lambda-environment-itself)

The upshot here is that if you really need to do anything serious with LambCI, it's recommended to use a [container service](https://github.com/lambci/ecs).

In my experience so far this will give you several HUGE advantages, in exchange for more tooling overhead:
1. sudo access (lacking this made installing software in the Lambda environment extremely challenging)
2. unlimited runtime (handy if you have really complex tests, for Hugo this is not an issue)
3. run any AMI you want, useful so you can match to your production environment

There's more of course, but that's the obvious stuff. We'll be OK with basic lambda for now, but if I were to do this again, I'd use ECS for the flexibility and (hopefully) relative ease of use.

With [EKS](https://aws.amazon.com/eks/) coming out in 2018, I think the Elastic Container Service is going to get a lot more attractive.

#### **Setting up LambCI to use Hugo**
We're going to need to bundle Hugo with the LambCI package so that we can build our Hugo page within the Lambda. This is slightly easier said than done, due to the aforementioned limitations with AWS Lambda.

Building the package:
1. Create a dir `lambciPackage`  
2. clone the lambci repo in 'lambciPackage': https://github.com/lambci/lambci.git  
3. in `lambciPackage/lambci` run `npm install` to get all lambci dependencies  
4. grab the latest Hugo_X.XX.X_Linux-64bit.tar.gz from [here](https://github.com/gohugoio/hugo/releases) and put it in `lambciPackage/lambci`  
5. zip up`lambciPackage/lambci` so that `package.json` is at the zip root  
6. upload the zip package to the lambda function  

**TODO:: screenshot the package upload**

#### **Do You Want To Build a Website**
Alright Anna, settle down. We're going to start building your site in `project/yourSite`. Get started by learning how to use Hugo with the
[quick start guide](https://gohugo.io/getting-started/quick-start/)

Your goal is to get a working site viewable at localhost:1313 by executing the command `hugo server -d` in `project/yourSite`.

Once you've gotten that far, running `hugo` in `project/yourSite` wil produce `project/yourSite/public`, which contains your sleek Hugo artifacts, a static web page ready to be served!

#### **Doing Something Useful With LambCI**
This is where things start getting tricky. So, you've got at least this in your project root:  
`project/yourSite`  
`project/package.json` (or whatever handler you chose to use)  
`project/lambci.sh` (if you relied on a shell script like me)  

So where do these files end up? And that package we uploaded earlier, where the hell is that? And how do we install anything without Sudo??? Lets break it down.
When the Lambda environment is started, these directories are the ones you're gonna care about:  
`/tmp/lambci/build/**your repo path here**` this is where your repo code gets pulled to, and is the initial working dir in the lambda env  
`/var/task/` is where the package zip file is loaded. Your Hugo tar.gz will be here  
`/tmp` is the wild west, this is where you can install things freely  

First thing's first: we need to move `Hugo_X.XX.X_Linux-64bit.tar.gz` from the zip package at `/var/task` to somewhere we can extract it, so let's copy it to `/tmp`  

Next, untar it with the command `tar -xzf /tmp/hugo/$HUGO_RELEASE.tar.gz`

Note: I track the Hugo version (`Hugo_X.XX.X`) in a var in the shell script. This is a good way to make your life less painful if you're going to refer to it more than once, or ever change it.  

Verify Hugo installed correctly by running `./hugo version`, and if this spits out a sensible output, you're ready to build your page! Otherwise, go fish.  

Now let's actually build your site. Use this command:  
`./hugo -s yourSite`  
This will put the Hugo output in `yourSite/public`, where it would be viewable if it only it were on a webserver, and not trapped in this Lambda...

#### **Escape From Lambda: Get To S3!**
**Stay Tuned Folks!**
