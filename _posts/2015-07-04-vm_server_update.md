---
layout: post
title: VM Server Update
date: 2015-07-04 20:11:25
author: Steven Lavoie
tags:
- project_vm_server
- virtualization
- blog
---

*[Update to this post about my new server.]({% post_url 2015-06-30-vm_server %})*

I got my Raptors in. It took a bit to figure out how to get everything working correctly, especially the RAID. Turns out the RAID is technically software RAID provided by the SATA controller. 

Once I set up the volume in the RAID configuration utility (by pressing CTRL+I during POST), I had to mount it from **/dev/mapper/isw\_bbahhidib\_raid**... not a device handle I'd expected. Afterwards, **mkfs.xfs** did the trick.

Next up was copying all the VMs over. I still haven't had time to set up anything in KVM yet but I can tell I'll need to to squeeze a wee bit more performance out of this poor little Core 2 Duo. For now, VirtualBox does the trick via [phpvitualbox]  (http://sourceforge.net/projects/phpvirtualbox/), with special thanks to [this tutorial](http://www.tecmint.com/install-phpvirtualbox-to-manage-virtualbox-virtual-machines-centos-debian-ubuntu/).
<!--more-->
Everything's gone off without a hitch, really. The only issue I have thus far, other than sluggish performance, is heat. The current heatwave shows no sign of abating and, in the middle of the day, it was over 90F in the house... the Raptors were hot to the touch, uncomfortably so. I removed the case cover and replaced with the side panel from my other box that has another fan in it. I also cranked up the fan speeds to max... the biggest pain about that is the noise and the fan speed can only be adjusted via the BIOS so, unless I restart and change it, the obnoxiously-loud fan continues to run overnight.

Now that I've had a chance to test this whole thing out, I'm on the prowl for a real server... and potentially a cheap water cooling kit so I can reduce the noise.
