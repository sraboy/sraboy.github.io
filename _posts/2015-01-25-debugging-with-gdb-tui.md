---
layout: post
title: Debugging Assembly Code with GDB TUI
date: '2015-01-25T18:47:00.001-08:00'
author: Steven Lavoie
tags:
- linux
- tutorial
- reversing
- assembly
---

![Apple II Display](/assets/posts/debugging_gdbtui/apple_ii.png)

This is just a mini introduction to using [GDB's text user interface](https://sourceware.org/gdb/onlinedocs/gdb/TUI.html), or GDBTUI. I use a Linux VM on my home laptop; tunneling in to my university's linux server is painfully slow, so I just develop locally and then scp (ssh copy) my complete ASM file to the university server to verify that it compiles/runs there. If you have a Linux box that struggles with a VM, try out an older window manager like [Openbox](http://openbox.org/wiki/Main_Page), though you'll lose some fancy features.

On my Linux VM, I use [Codeblocks](http://www.geany.org/) (which I'm not a fan of for assembly), you're probably using GDB to debug. GDB can be a pain to use with input and output, usually by redirecting input/output to another terminal or files, or integrating it into vi/emacs.

First, you just open/edit the ASM file in Geany, for this example it's "Homework2.asm". I have three terminals:


- Terminal 1: Use to compile/run the app with the Homework2.sh script. The app runs, allowing me to use it as normal. Simply type  `./Homework2.out`. It runs the app and, in this case, just sits there waiting for you to enter the first number.

- Terminal 2: This terminal is solely for getting the process ID of my running app. While the app is sitting in Terminal 1 waiting for input, I type `ps aux | grep Homework2.out` in this terminal. This lists all the processes with "Homework2.out" in the process name. It'll show geany, GDB if it's already running and the app running in the first terminal, like this:

<pre style="background: #000000; color: #d1d1d1;">steve@debian<span style="color: #d2cd86;">:</span>~$ ps aux <span style="color: #e34adc;">|</span> grep Homework2<span style="color: #e66170; font-weight: bold;">.</span>out
steve  <span style="color: #008c00;">5180</span>  <span style="color: #008c00;">0</span><span style="color: #e66170; font-weight: bold;">.</span><span style="color: #008c00;">0</span>  <span style="color: #008c00;">0</span><span style="color: #e66170; font-weight: bold;">.</span><span style="color: #008c00;">2</span>  <span style="color: #008c00;">44668</span> <span style="color: #008c00;">11284</span> <span style="color: #66347b;">pts/0</span>  S+ <span style="color: #008c00;">08</span><span style="color: #d2cd86;">:</span><span style="color: #008c00;">30</span>   <span style="color: #008c00;">0</span><span style="color: #d2cd86;">:</span><span style="color: #008c00;">00</span> <span style="color: #66347b;">/usr/bin/gdb</span> --tui Homework2<span style="color: #e66170; font-weight: bold;">.</span>out
steve  <span style="color: #008c00;">5346</span>  <span style="color: #008c00;">0</span><span style="color: #e66170; font-weight: bold;">.</span><span style="color: #008c00;">0</span>  <span style="color: #008c00;">0</span><span style="color: #e66170; font-weight: bold;">.</span><span style="color: #008c00;">0</span>   <span style="color: #008c00;">2004</span>   <span style="color: #008c00;">268</span> <span style="color: #66347b;">pts/2</span>  S+ <span style="color: #008c00;">08</span><span style="color: #d2cd86;">:</span><span style="color: #008c00;">34</span>   <span style="color: #008c00;">0</span><span style="color: #d2cd86;">:</span><span style="color: #008c00;">00</span> <span style="color: #e66170; font-weight: bold;">.</span><span style="color: #66347b;">/Homework2.out</span>
steve  <span style="color: #008c00;">5349</span>  <span style="color: #008c00;">0</span><span style="color: #e66170; font-weight: bold;">.</span><span style="color: #008c00;">0</span>  <span style="color: #008c00;">0</span><span style="color: #e66170; font-weight: bold;">.</span><span style="color: #008c00;">0</span>   <span style="color: #008c00;">8024</span>   <span style="color: #008c00;">912</span> <span style="color: #66347b;">pts/3</span>  S+ <span style="color: #008c00;">08</span><span style="color: #d2cd86;">:</span><span style="color: #008c00;">35</span>   <span style="color: #008c00;">0</span><span style="color: #d2cd86;">:</span><span style="color: #008c00;">00</span> grep --color<span style="color: #d2cd86;">=</span>auto Homework2<span style="color: #e66170; font-weight: bold;">.</span>out
</pre>

That second one is my program running in Terminal 1. Its process ID is 5346, the first four-digit number on that line.

- Terminal 3: In this terminal, run GDBTUI. Just type `./gdbtui`. An overview of the TUI features can be found [here](https://sourceware.org/gdb/onlinedocs/gdb/TUI.html). Size this terminal properly before running GDBTUI; there's sometimes a goofy bug, depending on your WM, that will crash it if you try to resize after firing up the terminal. I just make the terminal about twice its regular size. There are multiple layouts available for GDBTUI. The one that's best for us has three "windows" in the terminal: "Registers", "Assembly", and "Command".

Once GDBTUI is running, you'll be at the GDB command prompt. The commands in GDBTUI are all the same as they are for GDB: si, c, r, etc. There's some extra TUI commands. First, type `layout prev`. This should just bring you to a layout that shows the three "windows" I mentioned above. If not, continue cycling with `layout next` or `layout prev` to see the other layouts.

Now that you've got the proper layout, just type `attach 5346` and GDB will attach to your program in Terminal 1. Set your breakpoints as needed and you can now interact with the app in Terminal 1 while viewing the assembly and register values in the GDBTUI interface.

Some extra things that may help you:

- You can adjust the individual "windows" in GDBTUI. Type `info win` to get a list of the "windows" in the interface. For example:

<pre style="background: #000000; color: #d1d1d1;"><span style="color: #d2cd86;">(</span>gdb<span style="color: #d2cd86;">)</span> info win
        <span style="color: #008073;">ASM</span>     (<span style="color: #008c00;">13</span> lines)
        REGS    <span style="color: #d2cd86;">(</span><span style="color: #008c00;">12</span> lines<span style="color: #d2cd86;">)</span>
        CMD     <span style="color: #d2cd86;">(</span><span style="color: #008c00;">12</span> lines<span style="color: #d2cd86;">)</span>  <span style="color: #b060b0;">&lt;</span>has focus<span style="color: #b060b0;">&gt;</span>
</pre>

To adjust the heights, described in lines of text, just type `winheight ASM +5`. Substitute `ASM` for whatever window and you can use +/- to adjust the height.

- You can change the focus within GDBTUI. Notice CMD has focus for me. That means I can use Up and Down to scroll through previously commands. Change focus by typing `focus CMD`, replacing `CMD` with whatever window. If you focus on `ASM`, you can use Up and Down to scroll through the code in the disassembly window.

- Place labels throughout your code, like after parts of code getting input so GDBTUI will pause there and you can continue stepping through with `si` line-by-line. GDBTUI will automatically step into the functions `read_int`, `read_char` and whatever else, so I always place a random label after all my input/output. For me, I set a breakpoint at asm_main to start. I type `c` in GDB so it just continues and waits for my input since that's the first thing I do. After the input, it'll just continue. I want it to break right after that, so I just have a label called `cmps` after all my input/output so I don't have to step through all of the instructions in `read_int` or `read_char` (and there are a lot). I just set a new breakpoint at `cmps`, do my input and GDB breaks after that.

- You can view memory locations and the stack like this:
<pre style="background: #000000; color: #d1d1d1;"><span style="color: #d2cd86;">(</span>gdb<span style="color: #d2cd86;">)</span> x<span style="color: #d2cd86;">/</span><span style="background: #dd0000; color: white;">10x</span> $sp
<span style="color: #00a800;">0xffcb1c40</span><span style="color: #e34adc;">:</span>     <span style="color: #00a800;">0xf7561940</span>      <span style="color: #00a800;">0x00000400</span>      <span style="color: #00a800;">0xf7733000</span>      <span style="color: #00a800;">0xf763bf13</span>
<span style="color: #00a800;">0xffcb1c50</span><span style="color: #e34adc;">:</span>     <span style="color: #00a800;">0xf7709000</span>      <span style="color: #00a800;">0xf75d1ab3</span>      <span style="color: #00a800;">0x00000000</span>      <span style="color: #00a800;">0xf7733000</span>
<span style="color: #00a800;">0xffcb1c60</span><span style="color: #e34adc;">:</span>     <span style="color: #00a800;">0x00000400</span>      <span style="color: #00a800;">0x00000001</span>
<span style="color: #d2cd86;">(</span>gdb<span style="color: #d2cd86;">)</span></pre>

The first `x` is for "examine". The `/10x` tells GDB how many words to display. You can increase or decrease "10" as needed. The `$sp` is the location. `$sp` tells GDB to display starting at the stack pointer. You can replace `$sp` with a memory location like `0xffcb1c40` to view the contents of a variable.

- Most systems should have `disable-randomization` set by default. If not, just type `set disable-randomization on`. This causes GDB to reuse the same memory locations over and over while you're debugging. It makes it easier since you'll start to become familiar with memory locations and won't have to look those up every time you run the app.

- This is a great reference to have open while coding too: [http://x86.renejeschke.de/](http://x86.renejeschke.de/).

Once the program crashes or closes, GDBTUI will still be open. You can simply make changes as needed in Geany/Vi/Emacs and run through the same process outlined above: run it in Terminal 1, get the process ID in Terminal 2 and attach GDBTUI in Terminal 3. Since GDBTUI continues running even after the app dies, it'll maintain memory addresses, etc.

Everyone has their own method but this one works great for me. Hopefully it helps someone else out. Happy coding!
