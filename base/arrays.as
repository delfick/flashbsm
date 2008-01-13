import base.*;
import objects.*;
import ui.*;
import ui.funcbar.*
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
	static var listener:Object = {};
	static var broadCaster:Object = {};
	static var tempObject:Object = {};
	static var iconToPluginName:Object = new Object();
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
    	AsBroadcaster.initialize(broadCaster);
    	broadCaster.addListener(listener);
	}
	function createArrays (theStage:Number)
	{
		switch (theStage)
		{
		case 0 :
			base.trace ("Opening the start window and creating arrays", true, true, 14)
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
			//
			//
			base.trace ("Finding Categories", true, true, 14);
			arrays.theWindow.editItem ("text", "Loading", "Finding Categories");
			//
			communicate.createService ("getInfo");
			communicate.activateService ("getCategories", 0);
			listener.gotData = function()
			{
				for (var i:Number = 0;i<arrays.tempObject.length;i++)
				{
					if (arrays.tempObject[i] == "")
					{
						arrays.groupArray[i] = "Undefined";
					}
					else
					{
						arrays.groupArray[i] = arrays.tempObject[i];
					}
					arrays.groupObject[arrays.groupArray[i]] = i;
				}
				arrays.count = 0;
				base.trace("getting plugins for the following categories :");
				_root.theArrays.createArrays (1);
			}
			break;
		case 1 :
			if (arrays.count != arrays.groupArray.length)
			{
				arrays.tempObject = null;
				communicate.activateService ("getCategoryList", 1, arrays.count);
				listener.gotData = function()
				{
					base.trace("\t"+arrays.groupArray[arrays.count], true, false, 8);
					arrays.theWindow.editItem ("text", "Loading", "Finding Plugins for the " + arrays.groupArray[arrays.count] + " category");
				//	base.trace("\n" + arrays.tempObject + "\n", base.grey);
					arrays.pl_groupArray.push(arrays.tempObject);
					arrays.count ++;
					_root.theArrays.createArrays(1);
				}
			}
			else
			{
				_root.theArrays.createArrays(2);
			}
			break;
		case 20 :
			base.trace("\n\n######################################################");
			for (var i:Number = 0; i < groupArray.length; i++)
			{
				//arrays.groupArray[i] == "" ?	base.trace("\nUnCategorised", true, false, 14, base.red):
				base.trace ("\n" + arrays.groupArray[i], true, false, 14, base.red);
				for (var j:Number = 0; j < pl_groupArray[i].length; j++)
				{
					base.trace ("\t" + pl_groupArray[i][j], base.blue);
				}
			}
			createArrays(2);
			break;
		case 2 :
			base.trace ("Creating PluginArray and PluginArrayAlpha", true, true, 14);
			arrays.theWindow.editItem ("text", "Loading", "Creating PluginArray and PluginArrayAlpha");
			var z:Number = 0;
			for (var i:Number = 0; i < pl_groupArray.length; i++)
			{
				for (var j:Number = 0; j < pl_groupArray[i].length; j++)
				{
					arrays.pluginArray[z] = arrays.pl_groupArray[i][j];
					z++
				}
			}
			arrays.pluginArrayAlpha = pluginArray.concat ().sort (order);
			createArrays(3);
			break;
		case 3 :
			base.trace ("Filling out arrays with objects", true, true, 14);
			arrays.theWindow.editItem ("text", "Loading", "Filling out arrays with objects");
			pluginArrayAlpha = pluginArray.concat ().sort (order);
			for (var i:Number = 0; i < arrays.groupArray.length; i++)
			{
				arrays.groupOrderArray[i] = 0;
				arrays.theWindow.editItem ("text", "Loading", "Adding group objects");
				arrays.groupObject[arrays.groupArray[i]] = new groups (groupArray[i], i);
				arrays.theWindow.editItem ("text", "Loading", "Adding menu objects");
				arrays.menuObject[arrays.groupArray[i]] = new menus (groupArray[i], i);
				groupNumbers[arrays.groupArray[i]] = i;
			}
			for (var i:Number = 0; i < arrays.groupArray.length; i++)
			{
				for (var j:Number = 0; j < arrays.pl_groupArray[i].length; j++)
				{
					arrays.theWindow.editItem ("text", "Loading", "Adding plugin objects");
					arrays.pluginObject[arrays.pl_groupArray[i][j]] = new plugins (pl_groupArray[i][j], i, j);
				}
			}
			for (var i:Number = 0; i < arrays.pluginArrayAlpha.length; i++)
			{
				arrays.pluginObject[arrays.pluginArrayAlpha[i]].pluginIndex = i;
				if (arrays.pluginObject[arrays.pluginArrayAlpha[i]].groupNum == 0)
				{
					if (arrays.pluginObject[arrays.pluginArrayAlpha[i]].pluginNum == 0)
					{
						base.initialIndex = i;
					}
				}
			}
			arrays.stageObject.theStage = new stage(arrays.container);
			arrays.theWindow.editItem ("text", "Loading", "Adding other random objects");
			arrays.mouseObject.mouse = new theMouse ();
			arrays.funcBarObject.Preferences = new preferencesBtn ("Preferences", 0);
			arrays.windowArray.push ("Preferences");
			arrays.funcBarObject.Profiles = new profilesBtn ("Profiles", 1);
			arrays.windowArray.push ("Profiles");
			arrays.funcBarObject.ShowAll = new showAllBtn ("ShowAll", 2);
			arrays.funcBarObject.Quit = new quitBtn ("Quit", 3);
			for (var i:Number= 0; i < windowArray.length; i++)
			{
				windowObject[windowArray[i]] = new windows ();
			}
			createArrays(4);
			break;
		case 4 :
			base.trace ("Determining active plugins", true, true, 14);
			arrays.theWindow.editItem ("text", "Loading", "Determining active plugins");
			communicate.activateService ("getActivePluginList", 0);
			listener.gotData = function()
			{
				for (var i:Number = 0; i<arrays.tempObject.length;i++)
				{
					arrays.activePlugins.push (arrays.tempObject[i]);
				}
			//	base.trace("\n The active plugins are", true, false, 13);
			//	base.trace(arrays.activePlugins + "\n");
				arrays.count = 0;
				base.trace("Gettings data for the following plugins :");
				_root.theArrays.createArrays (5);
			}
			break;
		case 5 :
			if (arrays.count != arrays.pluginArray.length)
			{
				arrays.tempObject = null;
				communicate.activateService ("getPluginData", 1, arrays.count);
				listener.gotData = function()
				{
				//	base.trace ("\t"+arrays.pluginArray[arrays.count], true, false, 8);
					arrays.theWindow.editItem ("text", "Loading", "Getting data for the " + arrays.pluginArray[arrays.count] + " plugin");
					var thePlugin:Object = arrays.pluginObject[arrays.pluginArray[arrays.count]];
					var theData:Object = arrays.tempObject;
					thePlugin.iconName = theData[0];
					base.trace(thePlugin.iconName, true, false, 8);
					thePlugin.pluginName = theData[1];
					thePlugin.descriptionText = theData[2];
					arrays.iconToPluginName[thePlugin.iconName] = thePlugin.pluginName;
					arrays.count ++;
					_root.theArrays.createArrays(5);
				}
			}
			else
			{
				_root.theArrays.createArrays(6);
			}
			break;
		case 6:
			base.trace("arrays are made, time for creation class\n\n", true, true, 14);
			creation.setDepths (depth);
			break;
		}
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
