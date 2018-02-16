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

#### Getting started

First thing's first! You're gonna need a project dir on your local dev rig, let's call it: `project/`
and you are gonna need a GitHub repo, along with an AWS account.

#### Setting Up Lambci
[Follow the instructions here to get a GitHub token and launch the CloudFormation Stack in AWS](https://github.com/lambci/lambci#installation)

The default configuration utilizes Node, I used the following code in lambci.json to set a shell script to executable, and run it:
```
{
  "cmd": "chmod +x lambci.sh && ./lambci.sh"
}
```
Getting to this point is not that bad. The LambCI CloudFormation template does all the heavy lifting for you, and now you have a build script that will run on the new state of the repo, every time you push to it. With no server, how cool is that?

#### Wait a Minute... what was Michael saying about 'Current Limitations'?
Yeah, review those [here](https://github.com/lambci/lambci#current-limitations-due-to-the-lambda-environment-itself)

The upshot here is that if you really need to do anything serious with LambCI, it's recommended to use a [container service](https://github.com/lambci/ecs).

In my experience so far this will give you several HUGE advantages, in exchange for more tooling overhead:
1. sudo access (this made installing software in the Lambda extremely challenging)
2. unlimited runtime (handy if you have really complex tests, for Hugo this is not an issue)
3. run any AMI you want, useful so you can match to your production environment

There's more of course, but that's the obvious stuff. We'll be OK with basic lambda for now, but if I were to do this again, I'd use ECS for the flexibility and (hopefully) relative ease of use.

With [EKS](https://aws.amazon.com/eks/) coming out in 2018, I think the Elastic Container Service is going to get a lot more attractive.

#### Let's Build a Website
