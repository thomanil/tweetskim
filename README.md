
DESCRIPTION:
===========

A stripped down, command line-centered way to read tweets
efficiently.

Combine with unix tools and pipelines - read tweets
however you want.


USAGE:
======

`tweetskim [options]`

Prints tweets to stdout: one column for your timeline, one for
mentions of your account. Use it like any other command line tool:
page the output (`less tweetskim`), concat it to file (`tweetskim >
tweets.txt`), and so on.

options
----




PREREQUISITES:
==============

You must have some version of Ruby and RubyGems installed. That's it.


INSTALL:
========

`gem install tweetskim`

The program will help you set up OAuth/pincode authentication with Twitter
the first time you run it.


TODO:
=====


options
----

-a, --show-all

-c, --count-new

-e, --mentions

-i, --inverse-order

-h, --help

-l, --line-formatted

-m, --mark-all-read

-n, --last-n-tweets=N

-t, --html-output

-u, --user

-v, --version 


multiple accounts
------

handle explicit, different username options

split out authorization in separate, explicit step: tweetskim authorize USER

set tokens per account (if username given)


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
