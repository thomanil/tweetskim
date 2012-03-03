
DESCRIPTION:
===========

A stripped down, command line-centered way to read tweets
efficiently. Combine with unix tools and pipelines - read tweets
however you want.


USAGE:
======

        tweetskim

Prints tweets to stdout: one column for your timeline, one for
mentions of your account.


PREREQUISITES:
==============

You must have some version of Ruby and RubyGems installed. That's it.


INSTALL:
========

gem install tweetskim

The first time you run it, simply run it by itself: 'tweetskim' - the
program will help you set up OAuth/pin authentication with Twitter.


TODO:
=====

usage - add usage text, handle options
tweet-skim [username]
-h, --help
-m, --mark-all-read
-l=N, --last-n-tweets=N
-a, --show-all
-i, --inverse-order
-t, --html-output
-hm, --hide-mentions
-ht, --hide-timeline
-x=USER, --exclude=USER
-o=USER, --only=USER

handle explicit, different username options
split out authorization in separate, explicit step- tweetskim authorize USER
set tokens per account (if username)

generate nicely formatted html version
point browser to that
"mark all as read, go straight to browser
for multiple accounts: show them tabbed, concated or something else
super readable, greyscale, only gfx=avatars
Links to actual tweets to enable interaction using regular twitter web gui
make the design beautiful
CSS3 workthrough
Design & typography books workthrough


LICENSE:
========

(The MIT License)

Copyright (c) 2012 tweetskim

Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
'Software'), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
permit persons to whom the Software is furnished to do so, subject to
the following conditions:

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
