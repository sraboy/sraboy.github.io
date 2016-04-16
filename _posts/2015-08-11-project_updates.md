---
layout: post
title: Project Updates
date: 2015-08-11 18:10:20
author: Steven Lavoie
tags:
- blog
- project_vm_server
---

I don't have nearly the free time I did when I decided to turn the BratAlarm crackme into a tutorial. I'm still working on it though! I just end up getting 10-20min here and there, half of which is spent re-reading half of what I wrote the last time.

I squeezed out a couple little things for the sprite editor too and did a little more spring cleaning. As usual, I got distracted with some side projects. I wanted to brush up more on my C so I started doing more exercises. I also bought all the components to build my new VDI server, as well as a better router -- with DD-WRT to boot.

My VDI server went from an old Core 2 Duo with 8GB of DDR2-RAM to an i7-3820 with 16GB of DDR3-RAM (expandable to 64GB). Luckily, the Asrock X79 Extreme6 board uses the same Intel RAID controller so I was able to just migrate the VM RAID array over without issue. Ditto for the Debian host drive. I got tired of the cludgy performance too so I converted all my VirtualBox VMs to KVM and serve that up via Spice. I'm still a bit hamstrung by bandwidth though; the server's 100mbps wifi connection through a range extender struggles with streaming a 1080p desktop. I picked up another three 300GB VelociRaptors to eventually add some mirroring to the array, as well as a 3TB WD Red for file storage and backups.

For anyone curious, my coding exercises can be found here: https://github.com/sraboy/exercises. It's pretty much anything, old and new, that I've just done to refresh on or learn something.
