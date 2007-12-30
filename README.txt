***********************
**HOW TO COMPILE WITHOUT THE IDE
***********************

to compile without the ide, you'll need kagswf which you can download from here http://kagswf.graf.slask.pl/download.html

just extract that to a folder

and then in the terminal, cd to where the flashbsm is and then do this command

wine /location/to/kagswf.exe -out flashbsm.swf -html -w 1240 -h 830 -fps 48

where /localtion/to/kagswf is the location to kagswf, the number after -w is the width of the movie, the number after -h is the height of the move, and the number after -fps is the frame rate of the movie
(the above numbers are best suited for a screen with a resolution of 1280x1024)

***********************
**HOW TO USE
***********************

If you have cws running (see the "connecting to localhost problem.txt") then you need to have this folder under localhost, and run the flashbsm.html through localhost 

if you don't have cws running, then it doesn't have to be under localhost, and you run flashbsm.html



**************************
****RANDOM INFORMATION
**************************



the flashbsm.fla file contains a single frame of code

-----------------------QUOTE---------------------
var theArrays = new objects.arrays(this);
theArrays.createArrays()
------------------------ENDQUOTE-----------------

To see some trace statements (not completely finished yet) then just open the flashbsm/tracer/tracer/html file through localhost before you load flashbsm.html



I can't be bothered explaining how exactly flashbsm works yet.....


To generate the plugins.xml file untill i learn php to make a php script, I used a fla file with a single frame of code (the following)

-----------------------QUOTE---------------------
var groupArray:Array = new Array ();
var pluginArray:Array = new Array ();
pluginArray = new Array ("3d", "fade", "neg", "snap", "fakeargb", "opacify", "snow", "addhelper", "firepaint", "place", "splash", "animation", "plane", "svg", "annotate", "fs", "png", "switcher", "atlantis", "gconf", "put", "text", "bench", "gears", "reflex", "thumbnail", "blur", "glib", "regex", "tile", "clone", "gotovp", "resizeinfo", "trailfocus", "core", "group", "resize", "video", "crashhandler", "ring", "vpswitch", "cubereflex", "imgjpeg", "rotate", "wallpaper", "cube", "ini", "scaleaddon", "wall", "dbus", "inotify", "scalefilter", "water", "decoration", "mblur", "scale", "winrules", "expo", "minimize", "wobbly", "extrawm", "move", "screenshot", "zoom", "fadedesktop", "mswitch", "showdesktop");
pluginArray = pluginArray.concat ().sort (order);
var pluginObject:Object = new Object ();
for (var i = 0; i < pluginArray.length; i++)
{
	pluginObject[pluginArray[i]] = new Object ();
}
var groupArray:Array;
var xmlData;
var xmlGlobal;
var count:Number = 0;
xmlData = new XML ();
xmlData.ignoreWhite = true;
xmlData.onLoad = loadNext;
xmlGlobal = new XML ();
xmlGlobal.ignoreWhite = true;
xmlGlobal.onLoad = loadGlobal;
xmlGlobal.load ("z:/usr/local/share/compizconfig/global.xml");
function loadGlobal ()
{
	xmlData.load ("z:/usr/local/share/compiz/" + pluginArray[i] + ".xml");
}
var i = 0;
function loadNext ()
{
	getInformation (i);
	count++;
	if (i < (pluginArray.length - 1))
	{
		i++;
		xmlData.load ("z:/usr/local/share/compiz/" + pluginArray[i] + ".xml");
	}
	else
	{
		groupArray = groupArray.concat ().sort (order);
		for (var i = 0; i < groupArray.length; i++)
		{
			if (groupArray[i] == "General")
			{
				groupArray.unshift (groupArray.splice (i, 1));
			}
			if (groupArray[i] == "Uncategorized")
			{
				groupArray.push (groupArray.splice (i, 1));
			}
		}
		trace ("<everything>");
		trace ("\t<theGroups>");
		for (var i = 0; i < groupArray.length; i++)
		{
			trace ("\t\t<group>" + groupArray[i] + "</group>");
		}
		trace ("\t</theGroups>");
		traceEverything ();
		trace (count);
	}
}
function addToArray (array:Array, string:String)
{
	var match = false;
	for (var i = 0; i < array.length; i++)
	{
		if (array[i].toString () == string.toString ().split ("&amp;").join ("&"))
		{
			match = true;
		}
	}
	if (match == false)
	{
		array.push (string.toString ().split ("&amp;").join ("&"));
	}
}
function traceEverything ()
{
	trace ("\t<thePlugins>");
	for (var i = 0; i < pluginArray.length; i++)
	{
		var plugin = pluginObject[pluginArray[i]];
		trace ("\t\t<plugin>");
		trace ("\t\t\t<name short=\"" + plugin.short + "\" icon=\"" + plugin.icon + "\">" + plugin.name + "</name>");
		trace ("\t\t\t<group>" + plugin.group + "</group>");
		trace ("\t\t\t<description>" + plugin.description + "</description>");
		trace ("\t\t\t<options>");
		for (var j = 0; j < plugin.tabArray.length; j++)
		{
			trace ("\t\t\t\t<tab name=\"" + plugin.tabArray[j] + "\">");
			trace ("\t\t\t\t</tab>");
		}
		trace ("\t\t\t</options>");
		trace ("\t\t</plugin>");
	}
	trace ("\t</thePlugins>");
	trace ("<everything>");
}
function getInformation (index:Number)
{
	var plugin = pluginObject[pluginArray[index]];
	trace (pluginArray[index]);
	plugin.tabArray = new Array ();
	if (xmlData.firstChild.childNodes[0].nodeName == "plugin")
	{
		plugin.short = xmlData.firstChild.childNodes[0].childNodes[0].firstChild.nodeValue;
		plugin.icon = xmlData.firstChild.childNodes[0].attributes.name;
		plugin.name = pluginArray[index];
	}
	else
	{
		plugin.short = xmlData.firstChild.childNodes[0].childNodes[0].firstChild.nodeValue;
		plugin.icon = xmlData.firstChild.childNodes[0].nodeName;
		plugin.name = pluginArray[index];
	}
	for (var t = 0; t < xmlData.firstChild.childNodes[0].childNodes.length; t++)
	{
		if (xmlData.firstChild.childNodes[0].childNodes[t].nodeName == "category")
		{
			plugin.group = xmlData.firstChild.childNodes[0].childNodes[t].firstChild.nodeValue;
		}
		if (t == (xmlData.firstChild.childNodes[0].childNodes.length - 1))
		{
			if (plugin.group == undefined)
			{
				for (var s = 0; s < xmlGlobal.firstChild.childNodes.length; s++)
				{
					if (xmlGlobal.firstChild.childNodes[s].attributes.name == pluginArray[index])
					{
						plugin.group = xmlGlobal.firstChild.childNodes[s].childNodes[0].firstChild.nodeValue;
					}
					if (s == (xmlGlobal.firstChild.childNodes.length - 1))
					{
						if (plugin.group == undefined)
						{
							if (pluginArray[index] == "core")
							{
								plugin.group = "General";
							}
							else
							{
								plugin.group = "Uncategorized";
							}
						}
					}
				}
			}
		}
	}
	addToArray (groupArray, plugin.group);
	for (var t = 0; t < xmlData.firstChild.childNodes[0].childNodes.length; t++)
	{
		if (xmlData.firstChild.childNodes[0].childNodes[t].nodeName == "long")
		{
			if (xmlData.firstChild.childNodes[0].childNodes[t].attributes["xml:lang"] == undefined)
			{
				plugin.description = xmlData.firstChild.childNodes[0].childNodes[t].firstChild.nodeValue;
			}
		}
	}
	for (var t = 0; t < xmlData.firstChild.childNodes[0].childNodes.length; t++)
	{
		if (xmlData.firstChild.childNodes[0].childNodes[t].nodeName == "screen")
		{
			if (xmlData.firstChild.childNodes[0].childNodes[t].childNodes[0].nodeName == "group")
			{
				for (var i = 0; i < xmlData.firstChild.childNodes[0].childNodes[t].childNodes.length; i++)
				{
					addToArray (plugin.tabArray, xmlData.firstChild.childNodes[0].childNodes[t].childNodes[i].firstChild.firstChild);
				}
			}
			else
			{
				addToArray (plugin.tabArray, "screen");
			}
		}
		if (xmlData.firstChild.childNodes[0].childNodes[t].nodeName == "display")
		{
			if (xmlData.firstChild.childNodes[0].childNodes[t].childNodes[0].nodeName == "group")
			{
				for (var i = 0; i < xmlData.firstChild.childNodes[0].childNodes[t].childNodes.length; i++)
				{
					if (xmlData.firstChild.childNodes[0].childNodes[t].childNodes[i].firstChild.firstChild.nodeName == null)
					{
						addToArray (plugin.tabArray, xmlData.firstChild.childNodes[0].childNodes[t].childNodes[i].firstChild.firstChild);
					}
				}
			}
			else
			{
				addToArray (plugin.tabArray, "display");
			}
		}
	}
	if (pluginArray[index] == "core")
	{
		for (var k = 0; k < xmlGlobal.firstChild.childNodes[0].childNodes.length; k++)
		{
			for (var h = 0; h < xmlGlobal.firstChild.childNodes[0].childNodes[k].childNodes.length; h++)
			{
				addToArray (plugin.tabArray, xmlGlobal.firstChild.childNodes[0].childNodes[k].childNodes[h].firstChild.firstChild);
			}
		}
	}
	for (var t = 0; t < xmlGlobal.firstChild.childNodes.length; t++)
	{
		if (xmlGlobal.firstChild.childNodes[t].attributes.name == pluginArray[index])
		{
			for (g = 0; g < xmlGlobal.firstChild.childNodes[t].childNodes.length; g++)
			{
				if (xmlGlobal.firstChild.childNodes[t].childNodes[g].nodeName == "screen")
				{
					for (var k = 0; k < xmlGlobal.firstChild.childNodes[t].childNodes[g].childNodes.length; k++)
					{
						addToArray (plugin.tabArray, xmlGlobal.firstChild.childNodes[t].childNodes[g].childNodes[k].firstChild.firstChild);
					}
				}
			}
		}
	}
	plugin.tabArray = plugin.tabArray.concat ().sort (order);
}
function order (a, b):Number
{
	var name1:String = a.toLowerCase ();
	var name2:String = b.toLowerCase ();
	if (name1 < name2)
	{
		return -1;
	}
	else if (name1 > name2)
	{
		return 1;
	}
	else
	{
		return 0;
	}
}
--------------------------------------ENDQUOTE------------------------------------------
