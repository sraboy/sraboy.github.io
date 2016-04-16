---
layout: post
title: iPhone on TV
date: 2015-04-16 19:49:00
author: Steven Lavoie
tags:
- project_iphone_on_tv
- electronics
- hardware
- iphone
- hacking
---

**Sorry for the funky formatting; this was imported from Blogger and I haven't had a chance to fix it yet.**

![My Devices](/assets/posts/iphone_on_tv/iphone-on-tv_multiple_devices.jpg)
Clockwise from top-left: 2x iPod touches, Blackberry, Samsung flip-phone, Garmin GPS watch, classic iPod, iPhone 4S, HTC 8525, HP iPaq

A (very) long-term NerdGoal<sup>™</sup> mine is to use an iPhone as a robot's brain. As smartphones increase in sophistication and decrease in cost, more and more of these will pile up in people's drawers -- not to mention landfills.

I'd love to see a standardized platform that re-purposes smartphones in a way useful to the average consumer. I'm no engineer so I'm sure I'll [be eclipsed at some point](http://redpark.com/about/) but my first idea was a Roomba-style home cleaning bot. Rather than paying hundreds of dollars for a Roomba, which includes money to pay for the programmers who designed the AI and a lot of internal circuitry to handle it. I paid $300 for my Braava and $40 for my Arduino. I've got multiple devices just lying around that could both be offering me a lot of bang for the buck I've already spent.

![old iPhone](/assets/posts/iphone_on_tv/iphone-on-tv_iphone_1g_65p.jpg)

The screen is smaller than I like but I miss phones when they had a reasonable thickness. So, why not plug my first-generation iPhone into a robot to give a brain and eyes [Romo](http://www.romotive.com/) notwithstanding as it requires a newer device. The [30-pin interface](http://pinouts.ru/PortableDevices/ipod_pinout.shtml) for the old iWhatevers [allows for serial communication](http://www.computerworld.com.au/slideshow/365979/great-iphone-serial-port-hack/?image=1) as well as video out. As I said, I'm no engineer, but as I learn more about some of these things, I hope to eventually work out an useful way to do this.

First, I knew I had to jailbreak this thing. [JailbreakMe is perfect](http://stateofjailbreak.com/tutorials/jailbreakme/). Except, of course, my home wifi is N. I run it in N-only mode to keep me from accidentally attaching an old 802.11b device and slowing everything else down. The original iPhone only supports 802.11b/g so I set up a wifi repeater [Netgear WN300RP](http://www.netgear.com/home/products/networking/wifi-range-extenders/WN3000RP.aspx) in my office and have it spit out a separate guest network at b/g speeds.

![radio](/assets/posts/iphone_on_tv/iphone-on-tv_radio_front_45p.jpg)

I wanted video out. I did not want to buy a cable or a 30-pin connector. Well, my very old and rickety radio has an iPhone dock and was ripe for the picking. It's been sitting in the "garage sale" box for a couple months so why not see what this thing's made of?

![radio innards](/assets/posts/iphone_on_tv/iphone-on-tv_radio_internal.jpg)

...electronics apparently.

![radio closeup](/assets/posts/iphone_on_tv/iphone-on-tv_radio_internal_closeup_65p.jpg)

Here's the other side of the mainboard. The switch on the left is the AM/FM toggle. The other is the source/mode selector. The two biggest cables in the back go to the LCD inputs and the front-most red/black lines, right, are for LCD power. My main interest is that front-center 4x1 (MTA 156?) plug. That goes back to the 30-pin connector.

![radio closeup](/assets/posts/iphone_on_tv/iphone-on-tv_radio_internal_lcd_35p.jpg)

Not a bad little LCD... With cables!

![radio closeup](/assets/posts/iphone_on_tv/iphone-on-tv_radio_ic_epoxy_65p.jpg)

With that epoxy, I'll never figure out what they used to actually interface with the iPhone or how.

![radio closeup](/assets/posts/iphone_on_tv/iphone-on-tv_radio_dock_connector_65p.jpg)

This is the connector for the dock. Notice the solder points on both sides. The 5-pin cable goes to the video out board (see below). The other four go to the mainboard, the plug I pointed out above. Part of the problem in following the pins is that there's only 28 pins on this connector, not 30. The pin numbers in parentheses correspond to the left column in <a href="http://pinouts.ru/PortableDevices/ipod_pinout.shtml" target="_blank">this pinout</a>.<br /><br /><u>A/V Cable (5-pin)</u><br /><span style="font-family: Courier New, Courier, monospace;">1. ground (pin 1)</span><br /><span style="font-family: Courier New, Courier, monospace;">2. video out (pin 8)</span><br /><span style="font-family: Courier New, Courier, monospace;">3. grounded on A/V board</span><br /><span style="font-family: Courier New, Courier, monospace;">4. not connected on A/V board</span><br /><span style="font-family: Courier New, Courier, monospace;">5. grounded on A/V board</span><br /><span style="font-family: Courier New, Courier, monospace; font-size: small;"><br /></span><u>Data Cable (4-pin)</u><br /><span style="font-family: Courier New, Courier, monospace;">1.&nbsp;grounded on mainboard (pin 11?)</span><br /><span style="font-family: Courier New, Courier, monospace;">2.&nbsp;</span><br /><span style="font-family: Courier New, Courier, monospace;">3.&nbsp;</span><br /><span style="font-family: Courier New, Courier, monospace;">4.&nbsp;</span><br /><br /><br />I can't seem to count these out in any way that makes all these pins line up with the pinout&nbsp;considering those four in the middle of the <strike>30</strike>28-pin connector: one connection, two shorted, one connection. Since grounding pin 11 would send audio through pins 3 and 4, which would align with the A/V cable, I'm wondering if data cable pin 1 is pin 11.<br /><br /><br /><a href="http://4.bp.blogspot.com/-nkXUBaRw1Oo/VTBIw8NL8YI/AAAAAAAATHQ/nk20x6bQV2E/s1600/20150416_133601.jpg" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" height="180" src="http://4.bp.blogspot.com/-nkXUBaRw1Oo/VTBIw8NL8YI/AAAAAAAATHQ/nk20x6bQV2E/s1600/20150416_133601.jpg" width="320" /></a><br /><span style="font-family: inherit;">This tiny brown board on the left has a composite video out, line out and line in. The five pin cable from here goes to the 30-pin connector above.&nbsp;</span><br /><span style="font-family: inherit;"><br /></span><span style="font-family: inherit;">The red line appears to be&nbsp;+4V from the mainboard.</span><br /><span style="font-family: inherit;"><br />The other cable has four lines labeled R, W, G and Y.</span><br /><span style="font-family: inherit;"><br /></span><br /><div class="separator" style="clear: both; text-align: center;"><a href="http://2.bp.blogspot.com/-CBwLYNnno2E/VTBU2vmUPjI/AAAAAAAATJE/iDZTrP9JtHc/s1600/20150416_133948.jpg" imageanchor="1" style="clear: left; float: left; margin-bottom: 1em; margin-right: 1em;"><img border="0" height="640" src="http://2.bp.blogspot.com/-CBwLYNnno2E/VTBU2vmUPjI/AAAAAAAATJE/iDZTrP9JtHc/s640/20150416_133948.jpg" width="360" /></a></div><br /><br />Using TvOut2, I get video out with only the 5-pin cable plugged into the 30-pin connector and an RCA cable from the A/V board to the TV.<br /><br />
