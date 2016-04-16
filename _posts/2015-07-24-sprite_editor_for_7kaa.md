---
layout: post
title: Sprite Editor for 7KAA
date: 2015-07-24 00:22:20
author: Steven Lavoie
tags:
- blog
- programming
---

I'm almost done with Part IV of the Bratalarm Crackme tutorial series. I've been plugging away at it little by little but I'm still working on a few other projects as well.

I started sifting through code in old backups and dumping anything halfway useful or interesting to [GitHub](https://github.com/sraboy). I also started working on a [sprite editor](https://github.com/sraboy/skaa_editor) for [Seven Kingdoms](www.7kfans.com), one of my favorite games of all time. It was released as open source a few years back and I've been following the project closely for a bit. It's definitely helped me brush up on my C++. I have a lot of fun altering the AI moreso than anything else, though I've helped out with a couple bugs too.

I've always hated just about anything to do with graphics and design and that was part of what drew me to working on the sprite editor. I realized it's one (of the undoubtedly many) element of programming I've pretty much never dealt with. My first project with graphics was a [mini Zelda clone](https://github.com/sraboy/MyRPG) proof-of-concept in QBASIC.

![zelda clone](/assets/posts/sprite_editor_for_7kaa/zelda_clone.png)

<!--more-->

All that luscious imagery was hand-coded in QB with color values. A few years later, I'd started another game project, a [Pokemon clone](https://github.com/sraboy/BattleForm) that I'd worked on with a friend. We were in college at the time and stayed too busy to keep working on it, especially after I left early for a job and he took on an engineering major.

![pokemon clone](/assets/posts/sprite_editor_for_7kaa/battleform_world.png)
![pokemon clone](/assets/posts/sprite_editor_for_7kaa/battleform_battle.png)

That was done in .NET and with standard functions to load and use the images so it didn't take much learning on graphics beyond a bit of animation and tiling.

Doing this sprite editor, however, required me to translate C to C# -- and that C was translated from pure assembly a little while back. C to C# isn't as easy as it seems, mostly because the syntax is so similar yet has enough differences to drive you mad when you accidentally code in C in the Visual Studio editor. Plus, some constructs in C are poorly replicated in C#, like Arrays. In C#, you should be using Lists or some other newer IEnumerable which are much more feature rich and easier to deal with.

I'm about a week into the project thus far and it's going well. It took me several days to figure out the precise format of some of the SPR/sprite files and another day or two to figure how to deal with 8-bit-indexed bitmaps in C#; it is not set up to be terribly easy since no one uses that stuff anymore.

Anywho, now I can edit sprites. I can almost save them back to their native format too; it was *a lot* easier to implement saving 32-bit bitmaps. The custom-indexed bitmap is proving to be a bit more difficult but I'm almost there.

![skaaeditor](/assets/posts/sprite_editor_for_7kaa/skaa_editor.png)


