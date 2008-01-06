import base.*;
import objects.*;
import ui.*;
class base.arrays extends MovieClip
{
	//
	// Arrays
	//
	static var groupArray:Array = new Array ();
	static var pluginArray:Array = new Array ();
	static var pl_groupArray:Array = new Array ();
	static var funcBarArray:Array = new Array ();
	static var activePlugins:Array = new Array ();
	static var tabNameArray:Array = new Array ();
	static var groupOrderArray:Array = new Array ();
	static var windowArray:Array = new Array ();
	static var groupArrayAlpha:Array = new Array ();
	static var pluginArrayAlpha:Array = new Array ();
	static var pluginArrayAlphaEnabled:Array = new Array ();
	static var arguements:Array = new Array ();
	static var groupLengthArray:Array = new Array ();
	//
	// Objects
	//
	static var groupObject:Object = new Object ();
	static var pluginObject:Object = new Object ();
	static var funcBarObject:Object = new Object ();
	static var activePluginsObject:Object = new Object ();
	static var menuObject:Object = new Object ();
	static var groupNumbers:Object = new Object ();
	static var stageObject:Object = new Object ();
	static var mouseObject:Object = new Object ();
	static var descriptionObject:Object = new Object ();
	static var windowObject:Object = new Object ();
	static var theWindow:Object;
	static var communicate:Object;
	static var tempObject:Object;
	//
	// Xml
	//
	static var ArraysXmlData:XML;
	static var stageDimensionsData:XML;
	//
	// Other
	//
	static var activePluginsString:String = new String ();
	static var depth:Number = 0;
	static var activePluginVars:LoadVars;
	static var interval:Number;
	static var container:MovieClip;
	static var count:Number;
	static var tempLength:Number;
	//
	//
	public function arrays (__container:MovieClip)
	{
		container = __container;
	}
	function createArrays (theStage:Number)
	{
		switch (theStage)
		{
		case 0 :
			base.trace ("Opening the start window")
			communicate = new base.communicate ();
			arrays.theWindow = new ui.windows (400);
			arrays.theWindow.addItem ("text", "testing0", "This has been compiled with kagswf");
			arrays.theWindow.addItem ("text", "LoadingTitle", "Loading....");
			arrays.theWindow.addItem ("text", "Loading", "...");
			arrays.theWindow.addItem ("button", "done");
			arrays.theWindow.container.canvas.done.onRelease = function ()
			{
				arrays.theWindow.closeWindow (false);
				arrays.theWindow.inactivePress ();
			};
			arrays.theWindow.openWindow (false);
			communicate.createService ("getCategories");
			communicate.activateService ("getCategories", 0);
			interval = setInterval (EventDelegate.create (this, getFromServer), 10, "categories");
			arrays.count = 0;
			break;
		case 1 :
			base.trace ("Recieving length for category " + arrays.groupArray[arrays.count]);
			communicate.createService ("getCategoryListSize");
			communicate.activateService ("getCategoryListSize", 1, arrays.groupArray[arrays.count]);
			interval = setInterval (EventDelegate.create (this, getFromServer), 10, "categorySize", arrays.count);
			break;
		case 2 :
			base.trace ("Recieving plugin list for the " + arrays.groupArray[arrays.count] + "category");
			communicate.createService ("getCategoryList");
			communicate.activateService ("getCategoryList", 1, arrays.groupArray[arrays.count]);
			interval = setInterval (EventDelegate.create (this, getFromServer), 10, "plugins", arrays.count);
			break;
		case 3 :
			base.trace("######################################################");
			for (var i:Number = 0; i < pl_groupArray.length; i++)
			{
				arrays.groupArray[i] == "" ?	base.trace("\n UnCategorised", base.red):base.trace ("\n" + arrays.groupArray[i], base.red);
				for (var j:Number = 0; j < pl_groupArray[i].length; j++)
				{
					base.trace ("\t" + pl_groupArray[i][j], base.blue);
				}
			}
			break;
		}
		//load arrays xml data
		//	//	if it loads, create the following arrays
		//	//	//	groupArray -> group names
		//	//	//	groupObject -> Associative array for group names
		//	//	//	pl_groupArray -> plugins by groups
		//	//	//	|=_>pluginArray
		//	//	//	|=_>plugin array alpha
		//	// fill out the arrays with createObjects();
		//
		//Discover active plugins
		//Load stage dimensions xml
		//	//	 if success, then create stage1 and stage2
		//initiate the window
		//add text and the button
		//open the window, no animation
	}
	function getFromServer (theType:String)
	{
		var theParams:Array = arguments.splice (1, arguments.length - 1);
		switch (theType)
		{
			//
			//	// Rectangle
			//
		case "categories" :
			arrays.theWindow.editItem ("text", "Loading", "Finding Categories");
			if (tempObject != undefined)
			{
				clearInterval (interval);
				for (var i:Number = 0; i < tempObject.length; i++)
				{
					groupArray[i] = tempObject[i];
					arrays.groupObject[arrays.groupArray[i]] = i;
					arrays.pl_groupArray[i] = new Array ();
				}
				createArrays (1);
			}
			break;
		case "categorySize" :
			var groupNum:Number = theParams[0];
			arrays.theWindow.editItem ("text", "Loading", "Finding category length");
			if (tempObject != undefined)
			{
				clearInterval (interval);
				groupLengthArray[arrays.count] = Number (tempObject);
				arrays.tempObject = null;
				arrays.tempLength = null;
				if (groupNum + 1 == arrays.groupArray.length)
				{
					arrays.count = 0;
					groupLengthArray[0]=1;
					createArrays (2);
				}
				else
				{
					arrays.count++;
					createArrays (1);
				}
			}
			break;
		case "plugins" :
			var groupNum:Number = theParams[0];
			arrays.theWindow.editItem ("text", "Loading", "Finding Plugins for the " + arrays.groupArray[groupNum] + " category");
			if (tempObject != undefined)
			{
				if (tempObject.length > groupLengthArray[arrays.count]-1)
				{
					clearInterval (interval);
					for (var i:Number = 0; i < tempObject.length; i++)
					{
						arrays.pl_groupArray[groupNum].push (tempObject[i]);
						arrays.pl_groupArray[groupNum] = arrays.pl_groupArray[groupNum].concat ().sort (_root.theArrays.order);
					}
					arrays.tempObject = null;
					arrays.tempLength = null;
					if (groupNum + 1 == arrays.groupArray.length)
					{
						createArrays (3);
						arrays.count = 0;
					}
					else
					{
						// trace (arrays.groupArray[groupNum] + " done\n");
						//	trace(arrays.pl_groupArray[groupNum] + "\n\n");
						arrays.count++;
						createArrays (2);
					}
				}
			}
			break;
		}
	}
	//
	//
	function createObjects ()
	{
		//for all group numbers
		//	//	 group order array = 0
		//	//	 group object = new groups
		//	//	 menu object = new menu
		//	//	 group number = number
		//for all group and plugin numbers
		//	//	 pluginobject = new plugin
		//create plugin index according to alpha order
		//find the plugin with group and plugin num 0. set as initial index
		//create mouse object
		//create funcbar obejcts and push into window array
		//setdepths function
	}
	//
	//
	public function order (a:String, b:String):Number
	{
		var name1:String = a;
		var name2:String = b;
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
	//
	//
}
