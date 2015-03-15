The Flashbsm
============

The flashbsm is a settings manager for the compiz window manager
(especially when compiz-fusion is installed alongside it).

Flashbsm is written in actionscript 3 and mxml, using the flex framework.

Then, to communicate with compiz so that settings can actually be changed,
a python server is used along with pyamf (https://github.com/hydralabs/pyamf) so that I can talk
to the python server from the flashbsm.

Please note however, that since the beginning of this project I have mainly made
this just to mess around and familiarise myself with actionscript so if you end
up looking at the code, excuse the mess that it is :).

History
-------

Compiz itself has a very colourful history. Without going much into it there used
to be a fork to Compiz called Beryl which eventually merged back with Compiz
beginning the days of compiz-fusion.

Back then we had a fairly horrible settings manager.

So a person called Franzrogar and myself started making some mockups for a new settings manager.
Eventually Franzrogar's mockup ended up being used for the “bsm” (beryl settings manager).

Mine however, which was originally made in the flash 8 ide (oh it was horrible :))
was very similar to the franzrogar's mockup. If you're interested to have a look
this is what I have left from that time http://delfick.storage.googlepages.com/bsmMockups.tar.gz

Even after the bsm was made I continued to work on my mockup and eventually
deciding to use it to figure out how to actionscript.

After many months I ended up with a .fla file that had nothing on the stage but
just actionscript that drew and operated the entire thing.

It was around this time that it was suggested that I start to use actionscript 3
(April 2007) so that I didn't have to rely on the flash ide and so anyone would
be able to help make it.

I decided not to go to actionscript 3 at that time and instead found a way of
making it completely in actionscript 2, along with the help of kagswf (http://kagswf.tensus.net/).

I believe that was when I left the project alone for quite a while.

Until I found pyamf.

It was then I decided to cleanup the code (the preCleanup branch shows its mess)
Eventually I finished the cleanup (Jan 18 2008) and resulted in the preAS3 branch.

At this time however I came to the situation where the flashbsm required the
classes that come with flash 8 to be able to compile
(due to mx.remoting, which in turn was due to my need for pyamf).

This meant that in order to compile the flashbsm you needed the flash 8 ide
installed which defeated the whole purpose of using pure actionscript in the first place.

After asking the people behind pyamf if there was an alternative to mx.remoting
in as2 they told me no but if I went to AS3 then there would be alternatives.

And so, 10 months after it was first suggested, I moved to AS3.

After yet another cleanup after I had a working version in AS3 I have now got to
the point where every feature in the original mockup is now implemented in as3.

It can also disable/enable plugins and displays every setting for every plugin.
(however only boolean settings are configurable atm).

This project has since been abandoned and will never be picked up again.

Working Demo
------------

You can find a working demo of the latest version of the flashbsm over at http://flashbsm.appspot.com

(it doesn't change settings on your computer but it does everything else :))

The Original Mockup
-------------------

You can look at a version of the orignal mockup over `here <http://delfick.storage.googlepages.com/mockup.html>`_

