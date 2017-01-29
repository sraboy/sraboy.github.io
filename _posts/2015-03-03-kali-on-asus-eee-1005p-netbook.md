---
layout: post
title: Repairing the Asus EEE 1005p Netbook
date: '2015-03-03T17:24:00.000-08:00'
author: Steven Lavoie
tags:
- repair
- hardware
---

_This post was updated. See the original further down, which details some issues I had booting before I bothered replacing hardware._

<div class="tr_bq"><a imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;">
</a><a imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" height="225" src="/assets/posts/kali_on_asus/netbook_inside.jpg" width="400" /></a></div><div style="text-align: center;"></div>

I got this little gem from a friend. It sat under her couch for quite a while after "it broke". She asked if I could pull all her music and photos off it. She's not a techie by any means so she wouldn't get rid of it until someone saved the baby pictures of her son. That was the easy part; I just plugged the drive into your standard SATA-USB connector. I offered to fix everything but she had long since moved on so I gave her $50 and took it home.

I could tell the LCD was bad, as was the keyboard, both probably related to the stick substance I could only presume was Coca Cola syrup. She'd also said "the internet wasn't working" too well either so something must have been wrong with the Wi-Fi module.

The LCD took a little while to hunt down but I went with [this one](http://www.amazon.com/gp/product/B003TP6D9A) for $50 and it works great. Turns out the wifi antenna was severed but the card was still good and I replaced the keyboard with [this thing from eBay](http://www.ebay.com/itm/ASUS-MP-09A33US-5283-04GOA191KUS10-2-US-Keyboard-white-new-/110796731509) for $16. (If you need to replace either of these components for your eee PC, take note of the model numbers on each item. There were multiple versions of each model with slightly different hardware, just nothing really visible to the end user.)

I didn't buy/build a new Wi-Fi antenna since I put the whole thing back together before I remembered. I'd have to buy a new one of those tiny [Hirose U.FL connectors](http://en.wikipedia.org/wiki/Hirose_U.FL) to fashion a new antenna, which isn't the biggest PITA. The main problem with replacing it, if I ever do, is that the antenna needs to be soldered to a metallic sheet that's glued inside the cover _behind the LCD I just wrestled back into the case_. Not to mention, I tore up that sheet (of whatever substance) in the process of fixing this thing. I just use a USB adapter but you can see the antenna hanging out of the right speaker opening (never put those back in either) and it works well enough for home use.

The new keyboard doesn't always work but I think that's because I haven't totally put everything back together; the top of case is slightly bowed so it's mostly one line of keys in the center that aren't responsive. It had worked once or twice when everything was back together like normal.

Why is not back together like normal, you ask? The hard drive was bad too. I didn't notice any issues when pulling her photos off it but Windows wouldn't boot. So then I tried Kali. Below is my Log of Failure (and this original blog post before the above edits were added). Once I swapped the drive, everything was fine, but I lost interest in putting the case back together nicely.

I've got a small pile of screws left over, which is really just par for the course when I'm repairing laptops.

---

Here's the original post:


I've had a lot of weird issues with my netbook and Kali 1.1.0 (32-bit). First, I can boot via Live USB just fine. I can install just fine. Everything runs fine (other than some quirky issues with wifi that I didn't bother with much).

The install goes through just fine but after reboot, I get a "Gave up waiting for root device" error before getting dropped to initramfs and ash. Rebooting to Live USB is then inconsistent. Sometimes it'll load just fine and sometimes I have to boot to the failsafe mode. Something else that's inconsistent, or maybe me going crazy, is that the brightness on the (recently replaced) LCD seems to drop randomly. I just noticed it this time while booting to failsafe on Live USB again.

The SATA options in the BIOS make little difference:


- "Enhanced" works whether in IDE or AHCI. By "works" I mean I get the same errors.
- "Compatible" is just like Enhanced.
- "Disabled" actually causes the Live USB to be booted by default. It is a SATA drive so I guess that makes sense.

Using a normal USB keyboard works fine since the BIOS supports it. Using a wireless Logitech mouse/keyboard combo (K400r) also works... until I get to initramfs. Doing the install via the Logitech keyboard seems to have dropped the USB support from initramfs; even going back to the normal USB keyboard after a reboot doesn't work.

I tried to rebuild initramfs but it failed and left me with a totally broken system. Rather than try to wrestle with that, I figured I'd go for round 3 of a Live USB install but set up the network beforehand via a handy Ethernet cable and let the installer run updates. This worked like a charm... until I tried to boot. Back to square one.

This time, I booted to Live USB again and chroot'd to the HDD install:


1. To make sure I didn't screw it up, I followed [some instructions](http://superuser.com/questions/111152/whats-the-proper-way-to-prepare-chroot-to-recover-a-broken-linux-installation).
2. I also added my swap (before chroot): `swapon /dev/sda5`
3. I copied over my resolv.conf, just in case: `cp -L /etc/resolv.conf /mnt/etc/resolv.conf`
4. I updated my `/etc/initramfs-tools/modules`:
	* Added the following modules for [USB keyboard support](https://wiki.debian.org/Keyboard#How_to_enable_USB_keyboard_in_initramfs): usbcore, uhci_hcd, ehci_hcd, usbhid
	* Even though MODULES=most was set, I changed it to =list so I could try to add modules piecemeal and see what fixes things.
	* I added ahci and libahci, in case that's the issue with the boot not finding my root partition.
5. Then: `update-initramfs -u`
6. FAIL!

After a few seconds of 'thinking', I got two different I/O errors for scsi_mod.ko, one each for "reading" and "failed to extend," the latter pointing to the /var/tmp folder. That was followed by a "Bus error". Then a `could not read: Input/output error` for `/usr/sbin/iucode_tool: /lib/firmware/intel-ucode/06-0f-0b`.

Separately, I noticed I was getting this error on booting today, before the failure to mount my root partition. I wasn't getting it yesterday though, or at least hadn't noticed it. What's changed since yesterday and today? I cleared the BIOS by removing the CMOS battery and let them go to defaults (before the aforementioned SATA configuration changes). I also chose not to disable the onboard Wi-Fi (Mini-PCI Express module). I'd disabled it previously because the antenna is broken so I just didn't want to deal with it. I'd also plugged the speakers back in. At this point, the only thing different from the factory default is the new LCD and the fact that the mic/webcam isn't plugged in, but it wasn't yesterday either.

Following that last error was a read error for /sbin/lvm and another "failed to extend" for the same. Then there was an assertion failure from depmod in `libkmod-elf.c:207: elf_get_mem for "offset < efl->size"`.

Hrmf. What to do? Is the HDD bad? Quite possibly. I'm too lazy to umount and run fsck right now though so let's try something else.

Changed `MODULES=most` back to `list`. Same issue, except two Bus errors this time and more I/O errors for other modules before it aborts. Ruh roh, maybe the HDD is bad.

`dmesg` shows a ton of ata1.00 errors, including `READ FPDMA QUEUED` [which has previously been an issue](https://bugs.launchpad.net/ubuntu/+source/linux/+bug/550559) for some Linux users. Perhaps I'll go change the BIOS SATA settings: Ehanced IDE. Reboot to the recovery mode makes no change. Back to Live USB's failsafe. Interestingly, it didn't mount my local filesystem this time. Oh well, chroot'd again.

Let's look into that goofy microcode error from earlier. Kernel config has nothing special I noticed. Rna apt-get intel-microcode... it's already installed. Let's try [something](http://ubuntuforums.org/archive/index.php/t-1040648.html):

`echo 1 > /sys/devices/system/cpu/microcode/reload`
`dmesg`

The relevant line from the output is `platform microcode: firmware: direct-loading firmware intel-ucode/06/1c/0a`. That's a different version from the error earlier: `/lib/firmware/intel-ucode/06-0f-0b`. Let's try `update-initramfs -uv`.

A few errors throughout but `Calling hook dmsetup` had the same assertion failure as before. It then said "Aborted," then "Bus error" and then said it was building the new initramfs anyway.

I called `file` on the new initrd image and got a bus error again. Let me look at `dmesg` again:
`microcode: CPU0 sig=0x106ca, pf=0x4, revision=0x107`
`microcode: Microcode Update Driver: v2.00 <tigran@aivazian.fsnet.co.uk>, Peter Oruba`

Checked out an old [mailing list post](https://lists.debian.org/debian-user/2013/07/msg00380.html). Nothing good. Tried: `iucode_tool -s 0x000106ca -l /lib/firmware/intel-ucode/` and got the same IO error as above, referring to `06-0f-0b`. That file exists in the directory!

Let me just steal the initrd.img from the live USB and see what happens. Stopped at Grub and just booted from the command line:
`linux (hd0,msdos1)/boot/vmlinuz root=/dev/sda1`
`initrd (hd0,msdos1)/initrd.img`
`boot`

Weird that it's `msdos1` today. Yesterday it was just `1`. Boot worked just fine except I got the Black Screen of Death like the non-failsafe mode on the Live USB.

I'll have to dig into the module differences between the two and see what's going on... another time. Gah.
