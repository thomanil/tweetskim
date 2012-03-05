
DESCRIPTION:
===========

A stripped down, command line-centered way to read tweets
efficiently.

Combine with unix tools and pipelines to read tweets
however *you* want.


USAGE:
======

`tweetskim [options]`

Prints the tweet timeline to stdout, either as plain lines, more readable column
or extra-readable single html page.

Use it like any other command line tool: page the output (`tweetskim |
less`), concat it to file (`tweetskim > tweets.txt`), search for specific stuff (`tweetskim | grep conference`) and so on.

Default behavior if you don't pass any options: Print out last 10
tweets in your timeline, one on each line.

Options:

-a, --show-all                   Show all tweets (200max), not just unread tweets

-e, --mentions:                  Show mentions instead of timeline

-i, --inverse-order              Inverse/reverse ordered tweets

-h, --help                       Help page

-m, --mark-all-read              Mark everything up to now as read

-n, --last-n-tweets N            Show the last N tweets in your timeline

-o, --output-mode MODE           Output as 'lines', 'column' or 'html'

-v, --version                    Current version


PREREQUISITES:
==============

You must have some version of Ruby and RubyGems installed first. That's it.


INSTALL:
========

`gem install tweetskim`

The program will help you set up OAuth/pincode authentication with Twitter
the first time you run it.


TODO:
=====


show status identifier
----

option to prefix tweets with their status id and/or direct link (all modes)


multiple accounts
------

handle explicit, different username options

split out authorization in separate, explicit step: tweetskim authorize USER

set tokens per account (if username given)

html output mode
-----

output single-page html version of tweets, do pretty and readable stuff here


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
