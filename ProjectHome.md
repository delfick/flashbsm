# The Flashbsm #

The flashbsm is a settings manager for the compiz window manager (especially when compiz-fusion is installed alongside it). (information about compiz/compiz-fusion can be found over at wiki.compiz-fusion.org.

Flashbsm is written in actionscript 3 and mxml, using the flex framework. Then, to communicate with compiz so that settings can actually be changed, a python server is used along with pyamf (http://pyamf.org/) so that I can talk to the python server from the flashbsm.

Please note however, that since the beginning of this project, I have mainly made this just to mess around and familiarise myself with actionscript, so if you end up looking at the code, excuse the mess that it is :) .


# History #

Back in the days of beryl (compiz itself has a very colourful history. Without going much into it, there used to be a fork to compiz called beryl, which eventually merged back with compiz, beginning the days of compiz-fusion) we had a fairly horrible settings manager.

So a person called Franzrogar and myself started making some mockups for a new settings manager (I'm not sure who started first, but it was around the same time). Unfortunately we lost the forum where that thread was originally posted and earliest I can find is this http://forum.beryl-project.org/viewtopic.php?f=40&t=1249.

Eventually Franzrogar's mockup ended up being used for the “bsm” (beryl settings manager).

Mine however, which was originally made in the flash 8 ide (oh it was horrible :)) was very similar to the franzrogar's mockup but it had a few more features than his that couldn't really be converted to the real thing anyways.

If you're interested to have a look, this is what I have left from that time http://delfick.storage.googlepages.com/bsmMockups.tar.gz (unfortunately my harddrive died a few years ago and I didn't have many backups of anything :()

Anyway, even after the bsm was made I continued to work on my mockup, eventually deciding to use it to figure out how to use actionscript. After many months I ended up with a .fla file that had nothing on the stage, but just actionscript that drew and operated the entire thing. It was around this time that it was suggested that I start to use actionscript 3 (http://forum.compiz-fusion.org/showpost.php?p=7399&postcount=32) (April 2007) so that I didn't have to rely on the flash ide and so anyone would be able to help make it. I decided not to go to actionscript 3 at that time, and instead found a way of making it completely in actionscript 2, along with the help of kagswf (http://kagswf.tensus.net/).

Then cws was created by one of the key members of the compiz community, mikedee ( http://forum.compiz-fusion.org/showthread.php?t=753&highlight=cws (that thread was originally in compiz.org and didn't merge to well when it was put into the compiz-fusion forums). Which I started to use to be able to edit settings (http://forum.compiz-fusion.org/showthread.php?t=760). Unfortunately it was very cumbersome and din't end up working. Along with the fact mikedee ended up leaving the compiz community resulting in cws being unmaintained.

I believe that was when I left the project alone for quite a while.

Until I found pyamf http://forum.compiz-fusion.org/showpost.php?p=41801&postcount=8 (this project wouldn't be alive if it weren't for pyamf)

It was then I decided to cleanup the code, which as you can see here http://flashbsm.googlecode.com/svn/branches/preCleanup/ was incredibly messy. Eventually I finished the cleanup (Jan 18 2008) http://flashbsm.googlecode.com/svn/branches/preAS3/.

At this time however I came to the situation where the flashbsm required the classes that come with flash 8 to be able to compile (due to mx.remoting, which in turn was due to my need for pyamf). This meant that in order to compile the flashbsm you needed the flash 8 ide installed, which defeated the whole purpose of using pure actionscript in the first place.

After asking the people behind pyamf if there was an alternative to mx.remoting in as2, they told no, but if I went to AS3 then there would be alternatives. At first I was a bit reluctant to do so as I had a few other things I still wanted to reimplement in the cleanup. Those things only ended up actually taking about half an hour, so I moved to AS3  http://forum.compiz-fusion.org/showpost.php?p=45802&postcount=44 (about a 10 months after it was first suggested)

After yet another cleanup after I had a working version in AS3, I have now got to the point where every feature in the original mockup is now implemented in as3. It can also disable/enable plugins and displays every setting for every plugin. (however only boolean settings are configurable atm).

As it is, I currently don't have time to continue working on the flashbsm, but I do intend to finish it one day......

To find some links to some of my other projects, go here http://stephen-m.appspot.com/

# Working Demo #

You can find a working demo of the latest version of the flashbsm over at http://flashbsm.appspot.com

(it doesn't change settings on your computer but it does everything else :))

# The Original Mockup #

You can look at a version of the orignal mockup over here   http://delfick.storage.googlepages.com/mockup.html