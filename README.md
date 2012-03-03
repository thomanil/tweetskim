
DESCRIPTION:
===========

A stripped down, command line-centered way to read tweets
efficiently. Combine with unix tools and pipelines - read tweets
however you want.


USAGE:
======

`tweetskim`

Prints tweets to stdout: one column for your timeline, one for
mentions of your account: 

` > tweetskim

--Alex Payne-- An Martinez.             	--Jo Ring Giske-- @thomanil velkommen   
                                        	i snobbeklubben                         
                                        	                                        
                                        	                                        
                                        	--Bodil Stokke-- @thomanil It is. I     
                                        	have. :) @augustl                       
                                        	                                        
--Evan Light-- What he said. RT         	                                        
@doktahahpah: Thanks to the organizers, 	--Elisabeth Irgens-- @thomanil Jeg tror 
attendees, and many new friends at      	ikke det skal så mye til. Også bare     
#roa2012. Looking forward to next year! 	helt grei presskanne daglig over tid    
                                        	gjør at sutlete traktekaffe blir sur    
                                        	og vond.                                
--Evan Light-- Grateful that the        	                                        
organizers facilitated coming out       	                                        
and humbled that my talk was so         	--Rolf Rander Næss-- @thomanil Ingen    
well received.  Thank you all very      	av delene. Rammen var dynamiske språk   
much. #roa2012                          	og jeg ville demonstrere at de gamle    
                                        	er eldst. Men jeg har lyst til å se     
                                        	på clojure.                             
--Evan Light-- Realized that            	
#roa2012 is the first west coast        	
conference I've spoken at much less     	
attended! Surprising after so many      	
trips to SFO. #roa2012                  	
                                        	
                                        	
--Daniel Bogan-- My niece, who is 4,    	
via Skype: BACON AND EGGS AND SAUSAGES! 	
`



PREREQUISITES:
==============

You must have some version of Ruby and RubyGems installed. That's it.


INSTALL:
========

`gem install tweetskim`

(The program will help you set up OAuth/pin authentication with Twitter
the first time you run it.)


TODO:
=====


options
----

add usage text, handle options

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


multiple accounts
------
handle explicit, different username options

split out authorization in separate, explicit step- tweetskim authorize USER

set tokens per account (if username)


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
