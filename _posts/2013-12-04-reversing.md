---
layout: post
title: Reversing
date: '2013-12-04 19:01:00'
author: Steven Lavoie
tags:
- blog
- reversing
---
---

I'm working on some reverse engineering for work. Specifically, I need to head into the malware analysis arena to be useful but, for now, I'm working on the basics.

I've had a few books on my Amazon Wish List forever and never pulled the trigger because I didn't have time to actually sit down with them and I'd rather wait around for newer prints and updates when I do need them. I went ahead and picked up two today: [Malware Analyst's Cookbook](http://www.amazon.com/gp/product/0470613033) and [Practical Malware Analyst](http://www.amazon.com/gp/product/1593272901). They cover some of the reversing stuff but are obviously centered around malware analysis and forensics. I haven't seen too many great books on reversing that I'm comfortable buying yet due to the prerequisite knowledge... but there's some great tutorials online.

I've got some experience with IDA Pro, OllyDbg and several programming languages, including x86 ASM so I decided to start with www.crackmes.de. I'd worked on a few of these months ago just for kicks but I'm actually trying to learn more about it now. I was able to knock out [this one relatively easily](http://crackmes.de/users/winundlin13/crackmeandgetkeybywinundlin13).

While I usually get irritated with trial and error and the long process of making mistakes and taking forever to realize I've made a mistake, I understand the value in it. This one, I was looking at in OllyDbg and could not for the life of me figure out what the hell was going on. I started Googling some of the modules it was pulling up assuming it was hooked into some OS code or (and fuck me sideways if it's true) was actually malware and I was discovering it trying to break things. Anywho, I eventually realized that it's a .NET assembly... I should probably have read the instructions first. I checked out some of the comments on the page to get a clue and decided to try a decompiler like one of the commenters mentioned. Eventually, I did learn that you can easily tell whether an assembly is .NET by running it and using Process Explorer to search for references to mscorlib.dll to see if it's hooked in.

I tried out ILSpy first. It was pretty good but doesn't offer the ability to alter code. I could have just rewritten the relevant code in a custom app but I hadn't yet installed VS Studio since my last reformat. I pulled up Telerik's JustDecompile app (free trial) and loaded the Reflexil plugin (auto-download and install can be found in the Plugins dropdown menu). It took me a while of screwing around to figure out how to do things but I was able to insert a "call" instruction right after a string was loaded on the the stack... I'd worked out that this particular string was the finalized dynamic password. The password is recalculated every time you attempt to "log in" based on some system settings and the time.

Anywho, I could see that just by viewing it in the decompiler. The real cheese for newbies like me is actually cracking the app so that you're always right or it just doesn't bother you for the password. I simply changed the assembly instruction for the wrong answer to do the same thing as instruction for the right answer and voila! I was all set.
