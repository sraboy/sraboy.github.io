---
layout: post
title: Rooting the Samsung Galaxy Tab 4 7.0 (SM-T230NU)
date: '2015-05-30 17:08:00'
author: Steven Lavoie
tags:
- tutorial
- android
- root
---

![courtesy pixabay.com](/assets/posts/root_galaxy_tablet/halt.png) Note: I hope you know what rooting is and what it does. If not, check out [LifeHacker's guide](http://lifehacker.com/5789397/the-always-up-to-date-guide-to-rooting-any-android-phone) or [WonderHowTo's](http://android.wonderhowto.com/how-to/root-android-our-always-updated-rooting-guide-for-any-phone-tablet-0157124/) to learn a bit. Then go read a bit about Linux. Then understand that you'll likely void warranties, violate EULAs and maybe [commit a crime if you live in the US](http://www.androidpolice.com/2012/10/26/new-dmca-exemptions-allow-rooting-phones-but-not-tablets-unapproved-phone-unlocks-will-be-a-thing-of-the-past/#Can_I_Root_My_Tablet) I use my Galaxy Tab as a VoIP phone, so it's a phone as far as I'm concerned. YMMV.

There's also plenty of posts out there about people bricking their devices. Obviously, your device is your responsibility. Don't do this if it's illegal or if you don't want to risk having a fancy paperweight.
<!--more-->
Unfortunately, there's still no untethered root available for this thing. I finally decided to take care of it today. Note that I did not change any settings other than to turn on USB debug mode. Device encryption remained on the whole time.

First, if you don't already have it, [get Samsung Kies](http://www.samsung.com/us/kies/). This is Samsung's clunky backup/management software. You just need it for the drivers. Those can be acquired in other ways but this is easier.

Download TWRP and Odin 3.03. I'm always nervous about downloading these things from shady sites, so for you, [I have a copy here](https://www.dropbox.com/s/1gzxshqqtjcv17u/tab4root.zip?dl=0). Chrome warned me and blocked the download. I unblocked it, extracted with 7zip and scanned it with Windows Defender; it came up clean. Defender's pretty decent with malware in my experiences with cracks and keygens. My ZIP archive includes: **Odin3 3.09.exe, Odin3.ini, openrecovery-twrp-2.8.0.1-degas.tar**.

I don't trust DropBox though, so verify this:<br /><span style="color: #e34adc;">Size:</span> <span style="color: #008c00;">9392376</span> bytes<br />CRC data checksum<span style="color: #b060b0;">:</span> <span style="background: #dd0000; color: white;">296290EE</span><br />CRC data<span style="color: #d2cd86;">+</span>names checksum<span style="color: #b060b0;">:</span> <span style="background: #dd0000; color: white;">116357A7</span><br />SHA<span style="color: #d2cd86;">-</span><span style="color: #008c00;">256</span><span style="color: #b060b0;">:</span> <span style="background: #dd0000; color: white;">29D932D558404BC2F17135E67C3C732D91D4BF33F89362D62DEB0BE17B892BF1</span><br /><br />

TWRP is easy to find though: https://twrp.me/devices/samsunggalaxytab470.html

On your tablet:


1. Go to Settings >> About and tap the "Build Number" field 7 times. You'll get a notification saying you've turned on Developer Mode.

2. Go to Settings >> Developer Options and check the box for USB Debugging.

3. It was a bit finnicky to get the buttons just right on step #5. Read ahead so you're ready.<br />


<a href="http://4.bp.blogspot.com/-V-TZqT5ROKk/VWpsOOzuNlI/AAAAAAAAUwg/gOKfVmYRCro/s1600/twrp.png" imageanchor="1" style="clear: right; float: right; margin-bottom: 1em; margin-left: 1em; text-align: center;"><img border="0" height="200" src="http://4.bp.blogspot.com/-V-TZqT5ROKk/VWpsOOzuNlI/AAAAAAAAUwg/gOKfVmYRCro/s200/twrp.png" width="125" /></a>

- Power+Volume Down+Home to reboot into download mode.
- Got a warning that it's dangerous to install a custom OS. Pressed Volume Up to continue. (Volume Down would cancel.)
- Run Odin with admin privileges. On the bottom-right quadrant of the window, choose "AP" and browse to the TWRP tarball.
- Click Start on Odin and position your fingers for the next step.
- Power+Volume Up+Home to boot into recovery mode. This should pull up the TWRP recovery. If you get the standard recovery mode, go back to Step #1 and try again. If you get something like the picture on the right, you're good to go.
- Choose "Reboot" on the bottom right. Choose "System" on the next menu. Then swipe right on the following screen to confirm you want to root.
- Check your notifications area or just browse to the SuperSU app. Let it update and reboot. Mine updated and rebooted a second time after that for some reason.
- For me, next up was cleaning bloatware. I used "<a href="https://play.google.com/store/apps/details?id=com.jumobile.manager.systemapp&amp;hl=en" target="_blank">System app remover</a>" because it does uninstalls in batch and also keeps a recycle bin, so I can restore them in case I break something. First, here's some nice lists of app information and references. Feel free to browse to the original sites at your own risk. I just Googled the hell out of everything, really:


- <a href="https://spreadsheets.google.com/spreadsheet/pub?hl=en_US&amp;hl=en_US&amp;key=0AnO2-4y6yE1gdDJRekl4QmkyNmIzUmRvX2h3UDVkQXc&amp;output=html">https://spreadsheets.google.com/spreadsheet/pub?hl=en_US&amp;hl=en_US&amp;key=0AnO2-4y6yE1gdDJRekl4QmkyNmIzUmRvX2h3UDVkQXc&amp;output=html</a>
- <a href="http://webcache.googleusercontent.com/search?q=cache:Jr_nJIbKpBoJ:kingoftweaks.blogspot.com/2014/01/now-lets-clean-phones.html&amp;hl=en&amp;gl=us&amp;strip=1">http://webcache.googleusercontent.com/search?q=cache:Jr_nJIbKpBoJ:kingoftweaks.blogspot.com/2014/01/now-lets-clean-phones.html&amp;hl=en&amp;gl=us&amp;strip=1</a>
- <a href="http://webcache.googleusercontent.com/search?q=cache:OflEZrDOfHgJ:www.downloads.galaxyunlocker.com/List-of-bloatware-apps-safe-to-remove-Samsung-Galaxy-S3-S2-GalaxyUnlocker.com.pdf+&amp;cd=2&amp;hl=en&amp;ct=clnk&amp;gl=us">http://webcache.googleusercontent.com/search?q=cache:OflEZrDOfHgJ:www.downloads.galaxyunlocker.com/List-of-bloatware-apps-safe-to-remove-Samsung-Galaxy-S3-S2-GalaxyUnlocker.com.pdf+&amp;cd=2&amp;hl=en&amp;ct=clnk&amp;gl=us</a>
- <a href="http://webcache.googleusercontent.com/search?q=cache:PU-oMJW137AJ:androidzoneforyou.weebly.com/blog/system-apps-that-are-safe-to-remove+&amp;cd=3&amp;hl=en&amp;ct=clnk&amp;gl=us">http://webcache.googleusercontent.com/search?q=cache:PU-oMJW137AJ:androidzoneforyou.weebly.com/blog/system-apps-that-are-safe-to-remove+&amp;cd=3&amp;hl=en&amp;ct=clnk&amp;gl=us</a>
- <a href="http://webcache.googleusercontent.com/search?q=cache:rqEZ7ABXacQJ:www.droidviews.com/list-of-bloatssystem-apps-on-samsung-galaxy-devices-that-can-be-safely-removed/&amp;hl=en&amp;gl=us&amp;strip=1">http://webcache.googleusercontent.com/search?q=cache:rqEZ7ABXacQJ:www.droidviews.com/list-of-bloatssystem-apps-on-samsung-galaxy-devices-that-can-be-safely-removed/&amp;hl=en&amp;gl=us&amp;strip=1</a><

Here's what I started with:


- AllShare ControlShare Service
- AllShare FileShare Service
- Backup (sCloudBackupApp.apk, Samsung's cloud)
- Basic Daydreams
- Bubbles
- BlurbCheckout
- Calculator
- Calendar (the green one, Samsung's calendar)
- CalendarStorage (the green one, Samsung's calendar)
- Calendar widget (the green one, Samsung's calendar)
- com.android.providers.partnerbookmarks (just browser bookmarks pre-installed)
- com.samsung.android.sdk.spenv10 (For Samsung's pen device, that doesn't even work with the Tab)
- DSMLawmo (<a href="http://forum.xda-developers.com/galaxy-s2/help/dsmlawmo-dafuq-t1816265" target="_blank">Apparently for phone control and security features</a>. This isn't a phone.)&nbsp;
- Dual Clock (widget for clock on the desktop)
- Galaxy Apps
- Hancom Office Hcell 2014 Viewer
- Hancom Office Hshow 2014 Viewer
- Hancom Office Hword 2014 Viewer
- Hancom Office Shared
- Hancom Office Updater
- Hancom Office Viewer
- Hancom Office Widget &amp; PDF Viewer
- Help (interactivetutorial.apk)
- HP Printer Service Plugin (I don't have an HP printer and it doesn't work with my Brother Printer, at least not with UPnP disabled on my home network)

~300MB up to this point

Got an error during the Hancom Office Hshow uninstall: "Unfortunately, Documents has stopped." I hit ok. I use Google Documents but not Hancom. Whatever. At this point, I wanted to do a normal reboot just to be sure all was well.

No problems. Moving on...


- Mobile tracker (it's a Samsung service)
- My Files (Replaced with "Root Browser")
- S Voice
- Samsung account
- Samsung Calendar SyncAdapter
- Samsung Cloud Data Relay
- Samsung Cloud Quota
- Samsung Contact Sync Adapter
- Samsung Galaxy (Samsung's social garbage)
- Galaxy App Widget
- Samsung Link Platform Connectivity
- Samsung Memo SyncAdapter
- Samsung Print Service Plugin
- Samsung Push Service
- Samsung SBrowser SyncAdapter
- Samsung setup wizard
- Samsung SNote3 SyncAdapter
- Samsung Syncadapters
- Samsung text-to-speech engine
- Samsung WatchON
- SIM Toolkit (this is a Wifi-only tablet...)
- TalkBack (Google's text-to-speech accessibility feature)
- Travel Wallpaper (feature to rotate the wallpaper through pics from the local area you're in)
- Weather and Briefing


That's another 122MB. Again, same "Documents has stopped" error. Meh. It told me one uninstall failed but I haven't figured out which yet. Another reboot went off without a hitch.

Happy trails!
