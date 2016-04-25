---
layout: post
title: Bratalarm Crackme (Part III)
date: 2015-06-24 11:00:20
author: Steven Lavoie
tags:
- tutorial
- crackmes
- reversing
- project_bratalarm
---

*[Continued from Part II]({% post_url 2015-06-23-bratalarm_crackme_part_ii %}) and [Part I]({% post_url 2015-06-22-bratalarm_crackme_part_i %})*

**_Hops on soapbox._**

Right off the bat, I want to talk about the ethics of "keygenning." **Bottom Line: Pay for your software.** If you can't pay for someone else's creative works, you should use something else. If you're a student, look into student programs through your school, or programs like [DreamSpark](http://www.dreamspark.com). The crackme (or "keygenme") we're using was created by someone for fun, for us to crack for fun. Reversing someone else's code with a specific, achievable goal in mind is fun for me.

<!--more-->

All that said, sometimes companies go too far in trying to thwart professional pirates and prevent the rest of us from legally using our own software licenses, or we're shrouded in convoluted laws where the only way to understand its interpretation is to spend millions battling it out in court. I'm not going to pay Microsoft for a new Windows license because I upgraded my motherboard after a power surge destroyed the original. Nor will I just throw out my legally-purchased copy of Diablo II because the "Play CD" is too scratched. If it's legal where you live, perhaps you can resolve your issues with a bit of reversing know-how.

**_Steps down from soapbox._**

Okay, so to understand all the algorithmic changes going on to our data, we need to dig in and do some intense static analysis. Having an extremely analytical personality, and being someone who learns intuitively, I like to know all the little details.

Some of you may want to watch this in real-time as well. The best way to do that in OllyDbg is with the Run Trace. Every step taken (as long as you don't skip it with F8 vs F7) is recorded and you can step back in time to view register values. This helps me a lot when I accidentally punch F9 before putting in a breakpoint, or when I skip too much too fast.

Simply go to the menu bar and chooes Trace>>Open Run Trace. I'm running on v2.01b so even if the Run Trace window is already open, I still need to do this. Just start debugging normally and you can see every instruction logged in Run Trace. You can go back in time in read-only mode only, meaning you can't go back and restart execution a la Visual Studio's source code debugger.

If we just wanted to find a working code, we could probably do that without too much work. However, let's first take a go at faithfully recreating the algorithm in C from the assembly. If you've got the Hex-Rays Decompiler, lucky you; the rest of us will do it manually. *(The decompiler is really handy sometimes but you have to know C pretty well to understand some of the crazy source code it spits out. For our purposes, it's wholly unnecessary anyway.)*

Let's start with that **subChangeQWORD** function (né sub_4012C5). I've kept the memory addresses from IDA this time so you can follow along easier:

{% highlight nasm %}
.text:004012C5                 push    ebp
.text:004012C6                 mov     ebp, esp
.text:004012C8                 pusha
.text:004012C9                 xor     eax, eax
.text:004012CB                 xor     edx, edx
.text:004012CD                 mov     ecx, 8          ; length of string
.text:004012D2                 mov     esi, [ebp+stringQWORD]
.text:004012D5
.text:004012D5 updateCharLoop:
.text:004012D5                 mov     dl, [esi]       ; get first char
.text:004012D7                 test    dl, dl          ; check for /0
.text:004012D9                 jz      short Lbl_allDone
.text:004012DB                 sub     dl, 30h
.text:004012DE                 cmp     dl, 0Ah
.text:004012E1                 jb      short Lbl_skipSubSeven
.text:004012E3                 sub     dl, 7
.text:004012E6
.text:004012E6 Lbl_skipSubSeven:
.text:004012E6                 shl     eax, 4
.text:004012E9                 or      eax, edx
.text:004012EB                 inc     esi
.text:004012EC                 dec     ecx
.text:004012ED                 jnz     short updateCharLoop
.text:004012EF
.text:004012EF Lbl_allDone:
.text:004012EF                 mov     [ebp+stringQWORD], eax
.text:004012F2                 popa
.text:004012F3                 mov     eax, [ebp+stringQWORD] ; put encoded string in EAX
.text:004012F6                 leave
.text:004012F7                 retn    4
{% endhighlight %}

We see that it pushes all the registers onto the stack. That means parameters, if any, must have been passed on the stack. IDA will show you stringQWORD is a parameter and right before returning, it gets put into EAX.

Initially, we'd think we're returning a string (or char array) but, if you remember, our char array of eight characters (eight bytes) gets turned into a four-byte value whose individual byte values may or may not be represented in ASCII. Therefore, we'll simply treat it like an integer. Specifically, it needs to be an unsigned integer so our first bit isn't stolen to interpret negative/positive.

You can work on this in one of two ways: 1) Use a text editor and compile with gcc, or 2) Just use [IDEOne](http://www.ideone.com). The latter is a nice way of doing this if you don't want to deal with setting up an entire IDE on your system and/or aren't familiar with using the commandline. I started with IDEOne while writing this due to some technical issues but moved to GCC once I fixed my VM.

To run our function, we'll need a code stub to call it:

{% highlight c %}
#include <stdio.h>

unsigned int subChangeQWORD(char *);

int main(void)
{
    printf("serialnum is %x\n", subChangeQWORD("serialnum"));
    return 0;
}
{% endhighlight %}

Now we get started:

{% highlight c %}
unsigned int subChangeQWORD(char * stringQWORD)
{
    unsigned int eax = 0;      //[0x4012C9] xor eax, eax

    //do stuff

    return eax;  //[0x4012F3] mov eax, [ebp+stringQWORD]
}
{% endhighlight %}

Next, let's look for constants. The original programmer may have used constant values instead of variables but it will be easier for us to build this out if we start with variables. It's a bit more of a pain to write out in code but it makes it easier to align to the assembly if we get lost in the code or, like I often do, we take a day or two off of project.

{% highlight c %}
unsigned int subChangeQWORD(char * stringQWORD)
{
    const int strlen = 8;       //[0x4012CD] mov ecx, 8
    const int dlSub = 48;       //[0x4012DB] sub dl, 0x30
    const int dlCmp = 10;       //[0x4012DE] cmp dl, 0x0A
    const int dlCmpMaybe = 7;   //[0x4012E3] sub dl, 0x7
    const int eaxSHL = 4;       //[0x4012E6] shl eax, 0x4
    unsigned int eax = 0;       //[0x4012C9] xor eax, eax
    //unsigned int edx = 0;     //[0x4012CB] xor edx, edx

    //do stuff

    return eax;  //[0x4012F3] mov eax, [ebp+stringQWORD]
}
{% endhighlight %}

Notice that I've commented out EDX. It actually took me some time in messing with the code to realize it's unnecessary because the loop uses DL for the current character and the single byte in DL is all we need of the entire EDX register. This will be clearer in the next part. We need to reconstruct the loop. Any type of loop could be used for this but I'm partial to **for** loops so I'm going to start with that.

{% highlight c %}
unsigned int subChangeQWORD(char * stringQWORD)
{
    const int strlen = 8;       //[0x4012CD] mov ecx, 8
    const int dlSub = 48;       //[0x4012DB] sub dl, 0x30
    const int dlCmp = 10;       //[0x4012DE] cmp dl, 0x0A
    const int dlCmpMaybe = 7;   //[0x4012E3] sub dl, 0x7
    const int eaxSHL = 4;       //[0x4012E6] shl eax, 0x4
    unsigned int eax = 0;       //[0x4012C9] xor eax, eax
    //unsigned int edx = 0;     //[0x4012CB] xor edx, edx

    int i; //Depending on your compiler, this may be embedded in the for loop instead.

    for(i = 0; i < strlen; i++) //since we start at 0, i<strlen will get us through all 8 chars
    {
        unsigned int dl = (unsigned int)stringQWORD[i];   //[0x4012D5] mov dl, [esi]
        printf("dl: %c\t", dl);
    }

    return eax;  //[0x4012F3] mov eax, [ebp+stringQWORD]
}
{% endhighlight %}

Instead of counting down to zero like the assembly does, I counted up so I could use my incrementer as an array indexer as well. Going the other way would require keeping track of two variables. The assembly does this with **[esi]** for indexing and **ecx** for decrementing. If you're not using a full IDE, then the **printf** will help you debug and see your results without having to resort to GDB.

Let's work on the encoding stuff now.

{% highlight c %}
unsigned int subChangeQWORD(char * stringQWORD)
{
    const int strlen = 8;       //[0x4012CD] mov ecx, 8
    const int dlSub = 48;       //[0x4012DB] sub dl, 0x30
    const int dlCmp = 10;       //[0x4012DE] cmp dl, 0x0A
    const int dlCmpMaybe = 7;   //[0x4012E3] sub dl, 0x7
    const int eaxSHL = 4;       //[0x4012E6] shl eax, 0x4
    unsigned int eax = 0;       //[0x4012C9] xor eax, eax
    //unsigned int edx = 0;     //[0x4012CB] xor edx, edx

    int i; //Depending on your compiler, this may be embedded in the for loop instead.

    for(i = 0; i < strlen; i++) //since we start at 0, i<strlen will get us through all 8 chars
    {
        unsigned int dl = (unsigned int)stringQWORD[i];   //[0x4012D5] mov dl, [esi]
        printf("dl: %c\t", dl);

        dl -= dlSub;              //[0x4012DB] sub dl, 0x30
        printf("dl - 48: %c\t", dl);

        if(dl == dlCmp)           //[0x4012DE] cmp dl, 0x0A
        {
            printf("Break!\n");
            break;
        }

        dl -= dlCmpMaybe;        //[0x4012E3] sub dl, 0x7
        printf("dl - 7: %c\t", dl);

        printf("eax: 0x%08x\t\t", eax);

        eax = eax << eaxSHL;     //[0x4012E6] shl eax, 0x4
        printf("eax << 4: 0x%08x\t", eax);

        eax |= dl;               //[0x4012E9] or eax, edx

        printf("eax |= dl: 0x%08x\n", eax);
        printf("---------------------------------------------------------------------------------------------------------------\n");
    }

    return eax;  //[0x4012F3] mov eax, [ebp+stringQWORD]
}
{% endhighlight %}

With the commenting, you should be able to follow the logic pretty easily. The **printf** statements are set up with formatting to make it all look good and line up on the commandline.

Here's the entire code block:

{% highlight c %}
#include <stdio.h>

unsigned int subChangeQWORD(char *);

int main(void)
{
	printf("serialnum is %x\n", subChangeQWORD("serialnum"));
	return 0;
}

unsigned int subChangeQWORD(char * stringQWORD)
{
    const int strlen = 8;       //[0x4012CD] mov ecx, 8
    const int dlSub = 48;       //[0x4012DB] sub dl, 0x30
    const int dlCmp = 10;       //[0x4012DE] cmp dl, 0x0A
    const int dlCmpMaybe = 7;   //[0x4012E3] sub dl, 0x7
    const int eaxSHL = 4;       //[0x4012E6] shl eax, 0x4
    unsigned int eax = 0;       //[0x4012C9] xor eax, eax
    //unsigned int edx = 0;     //[0x4012CB] xor edx, edx

    int i; //Depending on your compiler, this may be embedded in the for loop instead.

    for(i = 0; i < strlen; i++) //since we start at 0, i<strlen will get us through all 8 chars
    {
        unsigned int dl = (unsigned int)stringQWORD[i];   //[0x4012D5] mov dl, [esi]
        printf("dl: %c\t", dl);

        dl -= dlSub;              //[0x4012DB] sub dl, 0x30
        printf("dl - 48: %c\t", dl);

        if(dl == dlCmp)           //[0x4012DE] cmp dl, 0x0A
        {
            printf("Break!\n");
            break;
        }

        dl -= dlCmpMaybe;        //[0x4012E3] sub dl, 0x7
        printf("dl - 7: %c\t", dl);

        printf("eax: 0x%08x\t\t", eax);

        eax = eax << eaxSHL;     //[0x4012E6] shl eax, 0x4
        printf("eax << 4: 0x%08x\t", eax);

        eax |= dl;               //[0x4012E9] or eax, edx

        printf("eax |= dl: 0x%08x\n", eax);
        printf("---------------------------------------------------------------------------------------------------------------\n");
    }

    return eax;  //[0x4012F3] mov eax, [ebp+stringQWORD]
}
{% endhighlight %}

Compare the output to the output you get while running this in OllyDbg. Just set a breakpoint at 0x4012EF and punch in the serial "serialnumbergoesherenowandstuffyay!" (or whatever) and compare. Your output should look like this:

{% highlight objdump %}
steve@debian:/media/sf_E_DRIVE/MalwareDisk/Crackmes/bratalarm$ gcc algorithm.c
steve@debian:/media/sf_E_DRIVE/MalwareDisk/Crackmes/bratalarm$ ./a.out
dl: s   dl - 48: C      dl - 7: <       eax: 0x00000000         eax << 4: 0x00000000    eax |= dl: 0x0000003c
---------------------------------------------------------------------------------------------------------------
dl: e   dl - 48: 5      dl - 7: .       eax: 0x0000003c         eax << 4: 0x000003c0    eax |= dl: 0x000003ee
---------------------------------------------------------------------------------------------------------------
dl: r   dl - 48: B      dl - 7: ;       eax: 0x000003ee         eax << 4: 0x00003ee0    eax |= dl: 0x00003efb
---------------------------------------------------------------------------------------------------------------
dl: i   dl - 48: 9      dl - 7: 2       eax: 0x00003efb         eax << 4: 0x0003efb0    eax |= dl: 0x0003efb2
---------------------------------------------------------------------------------------------------------------
dl: a   dl - 48: 1      dl - 7: *       eax: 0x0003efb2         eax << 4: 0x003efb20    eax |= dl: 0x003efb2a
---------------------------------------------------------------------------------------------------------------
dl: l   dl - 48: <      dl - 7: 5       eax: 0x003efb2a         eax << 4: 0x03efb2a0    eax |= dl: 0x03efb2b5
---------------------------------------------------------------------------------------------------------------
dl: n   dl - 48: >      dl - 7: 7       eax: 0x03efb2b5         eax << 4: 0x3efb2b50    eax |= dl: 0x3efb2b77
---------------------------------------------------------------------------------------------------------------
dl: u   dl - 48: E      dl - 7: >       eax: 0x3efb2b77         eax << 4: 0xefb2b770    eax |= dl: 0xefb2b77e
---------------------------------------------------------------------------------------------------------------
serialnum is efb2b77e
steve@debian:/media/sf_E_DRIVE/MalwareDisk/Crackmes/bratalarm$
{% endhighlight %}

In the next part, we'll move on to figure out the rest of the encoding.

*///TO BE CONTINUED///*
