---
layout: post
title: Encryption & Hashing
date: 2015-06-18 18:04:39
author: Steven Lavoie
tags:
- tutorial
- blog
- encryption
- hashing
---

I was recently asked what the difference was between hashing and encryption by a non-technical person who didn't really want a technical answer; she was just curious. Not being an expert myself, it's difficult to explain what I do understand. This is just an expansion on my explanation to her. It's amazing how much you can learn when attempting to teach.

Simply put, hashing is a one-way operation. Encryption is two-way, meaning it can be decrypted with a mathematical operation. The easiest way to explain this is with a couple simple math problems. Keep in mind that everything on a computer is really just a bunch of numbers, which is how we do "math" on our email, so let's just work with numbers. 

Much like a computer is restricted to binary, let's assume we're restricted to a world of positive integers. Specifically, let's say an "English" sentence starts with an even number, has an odd number for the verb next, and always ends with a 0.
<!--more-->
# Symmetric Encryption

Now, let's say your passphrase is the number 1500. Your secret message is 250.
The encryption algorithm is: Add the passphrase to the secret message.
Now your cipher text is 1750... gibberish to us since it starts with an odd number.

Since algorithms are usually open/public, if I wanted to bruteforce this encryption, I'd take the cipher text, 1750, and subtract numbers from it until I got an intelligible plain-text message out of it. I'd start with 1750-1=1749 and keep going until I got 1750-250=1500. If I don't know what I'm looking for, or have no way to verify it, then I can't brute force it. For example, I don't need to know what I'm looking for if I'm just entering every result into a piece of software hoping it logs me in.

Most of the mathematically-possible answers here are going to be gibberish, like seeing "aZske kXKdke J9Kd" in a sentence. This is symmetric encryption; given the algorithm of adding the passphrase to the secret message, the only way to get the secret message, 250, from the cipher text, 1750, is to reverse the algorithm and subtract the password, 1500, from the cipher text.

# Hashing

Hashing, on the other hand does not go in reverse. It destroys information in the process of working on it. Ideally, the resulting hash is unique. Let's see a (very poor) example hashing algorithm with some basic math and hash your password of 1500.

The algorithm says to add digits to the end of the passphrase until it's a multiple-of-5-digits long; you must always add at least one digit. That newly-added digit is the last digit of the passphrase multiplied by two. If you go over nine, roll over to zero. Then add as many zeros as there are digits in the number. Divide the whole number by two-times the original number.

| Start | Operation | Result |
| ----- | --------- | ------ |
| 1500 | Needs one more digit. The last digit is 0, so add another 0 (0*2). | 15000 |
| 15000 | It's five digits, so add on 5 zeros. | 1500000000 |
| 1500000000 | 1500000000 / (1500 * 2) | 500000 |

500000 is your hashed passphrase.

To reverse it, we need to solve for either X or Z. Let's try solving for Z:

1. 500000 = Z / (X * 2)
2. 500000(2X) = Z
3. Z = 1000000X

This tells us that the previous steps added a total of six zeros to our original. Let's guess that the passphrase was 10000 and work through the algorithm again. Since it's five digits, we have to add on five more zeros. Wait! We can't add five zeros since we know that we added six zeros total because the last step, Z, is the secret number times a million.

Now let's guess that the passphrase was 100000. We'd have to add digits to this until it was ten digits long, so we'd add four zeros. That means the next step tacks on another ten zeros. Wait! We can't do that either since we only add six zeros total. 

We can safely say that the passphrase is less than five digits long. Let's guess 1000.

| Start | Operation | Result |
| ----- | --------- | ------ |
| 1000 | Needs one more digit. The last digit is 0, so add another 0 (0*2). | 10000 |
| 10000 | It's five digits, so add on 5 zeros. | 1000000000 |
| 1000000000 | 1000000000 / (1000 * 2) | 1000000 |

Hmm. We're supposed to get 500000, not 1000000. Oh well, knowing that it's less than five digits, we could just write a simple program to try every number 1-9999. In this case, it's extremely easy to do so. If the number was actually -- I don't know -- 500 digits long, it would take significantly longer to try every possibility. 

Luckily, we don't have to try all of those numbers anyway!

Since our hash (500000) ends in zero, the division in the previous step has limited possibilities. We know it was: **hash = Z / (X * 2)**. Well, in order to get a hash ending in a zero we must have divided a multiple of ten by some number. So, Z must be a multiple of 10. (This is obvious considering Z was the result of adding zeros to the number.)

But wait! There's more! The first number in the hash is a five. The only place in the entire algorithm that could have modified the first digits was the last step, where we multiplied it by two. Getting a five in the most significant place could have only happened if our passphrase's first digit was a multiple of five. So five and ten are the only options.

| Start | Operation | Result |
| ----- | --------- | ------ |
| 15 | Needs three digits. 5*2 = 10, rollover to 0. | 15000 |
| 15000 | It's five digits, so add on 5 zeros. | 1500000000 |
| 1500000000 | 1500000000 / (1500 * 2) | 500000 |

We got it!

Uh oh. This is a "collision". Two different plaintexts resulted in the same hash. This is a serious weakness and is why MD5 is no longer considered secure. If identifying collisions is this easy by hand, imagine using a computer.

The only vaguely secure hashes out of this algorithm will be ones that result in decimals that get truncated in that last step. That fraction information is destroyed and unrecoverable.

| Start | Operation | Result |
| ----- | --------- | ------ |
| 21 | Needs 3 digits. The last is 1, so 1*2 = 2. | 21222 |
| 21222 | Now it's five digits, so add five zeros | 2122200000 |
| 2122200000 | 21 * 2 = 42. Divide by 42. | 50528571.428571428571428571428571 |

The hash is 50528571.

1. 50528571 = Z / (X*2)
2. 50528571 * X * 2 = Z
3. Z = 101057142X

Considering that the step prior to that added a bunch of zeros to a number, and 101057142 has no zeros, we can't reverse this without just bruteforcing every possibility until we find one that matches this hash.

# Conclusion

Another major factor in cryptographic security is the difficulty with which the calculations are done. If it takes you 15 seconds to encrypt something, it will take an attacked 15*X seconds to resolve it where X is the total number of possibilities. In the above algorithm, any hash ending in a 0 must have started as a multiple of 5. In this case, X would equal the total number of multiples of 5 between 1 and whatever the hash is.

I'm not enough of a math whiz to work through it, but I'm sure someone could work out a pattern for the final digits in the non-zero hashes as well.

There's a million ways to poke holes in these terrible algorithms. I actually stumbled on how terrible they were by accident (and with some help of [Wolfram Alpha](http://www.wolframalpha.com)); this is why cryptography needs experts. If the attacker has an idea what they're looking for, this can be bruteforced easily. If what they're looking for is a website to say "Welcome!" after logging in, then they can just try every possibility until the hash is accepted.

Last, I left out asymmetric encryption partially due to laziness and partially due to a lack of confidence in my own math ability. Asymmetric encryption is based on polynomial equations. Remember the quadratic formula from high school and how it sometimes gave two different results for X? Well, one of those is the private key and the other is the public key. Using one or the other will give you the "answer". In reality, the other primary concern with asymmetric encryption is making it incredibly difficult (or impossible with current technology) to calculate one possible value of X given the other.
