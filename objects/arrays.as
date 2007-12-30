import objects.*;
import objects.funcBar.*;
class objects.arrays extends MovieClip
{
	static var groupArray:Array = new Array ();
	static var activePlugins:Array;
	static var activePluginsObject:Object = new Object ();
	static var activePluginsString:String = new String ();
	static var groupArrayAlpha:Array = new Array ();
	static var pl_groupArray:Array = new Array ();
	static var funcBarArray:Array = new Array ();
	static var pluginArray:Array = new Array ();
	static var pluginArrayAlpha:Array = new Array ();
	static var pluginArrayAlphaEnabled:Array = new Array ();
	static var groupOrderArray:Array = new Array ();
	static var tabNameArray:Array = new Array ();
	static var pluginNormalArray:Array = new Array ();
	static var windowArray:Array = new Array ();
	static var pluginObject:Object = new Object ();
	static var groupObject:Object = new Object ();
	static var menuObject:Object = new Object ();
	static var groupNumbers:Object = new Object ();
	static var stageObject:Object = new Object ();
	static var funcBarObject:Object = new Object ();
	static var mouseObject:Object = new Object ();
	static var descriptionObject:Object = new Object ();
	static var windowObject:Object = new Object ();
	static var depth:Number = 0;
	static var ArraysXmlData:XML;
	static var stageDimensionsData:XML;
	static var activePluginVars:LoadVars;
	static var theWindow:Object;
	static var Int:Number;
	function createArrays (container:MovieClip)
	{
		arrays.theWindow.openWindow (false);
		base.createTextFormats ();
		ArraysXmlData = new XML ();
		ArraysXmlData.ignoreWhite = true;
		ArraysXmlData.onLoad = function (loaded:Boolean)
		{
			if (loaded)
			{
				for (var i:Number = 0; i < arrays.ArraysXmlData.firstChild.childNodes[0].childNodes.length; i++)
				{
					arrays.groupArray[i] = arrays.ArraysXmlData.firstChild.childNodes[0].childNodes[i].firstChild.nodeValue;
					arrays.groupObject[arrays.groupArray[i]] = i;
					arrays.pl_groupArray[i] = new Array ();
				}
				for (var i:Number = 0; i < arrays.ArraysXmlData.firstChild.childNodes[1].childNodes.length; i++)
				{
					var pluginName:XMLNode = arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[i].childNodes[0].firstChild.nodeValue;
					var groupNum:XMLNode = arrays.groupObject[arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[i].childNodes[1].firstChild.nodeValue];
					arrays.pl_groupArray[groupNum].push (pluginName);
					arrays.pl_groupArray[groupNum] = arrays.pl_groupArray[groupNum].concat ().sort (_root.theArrays.order);
					base.trace (arrays.pl_groupArray[groupNum]);
					base.trace ("\n\n");
				}
				container.theArrays.createObjects ();
			}
			else
			{
				trace ("the file didn't load");
			}
		};
		activePluginVars = new LoadVars ();
		stageDimensionsData = new XML ();
		stageDimensionsData.ignoreWhite = true;
		stageDimensionsData.load ("xml/stageDimensions.xml");
		stageDimensionsData.onLoad = function (success:Boolean)
		{
			if (success)
			{
				arrays.stageObject.theStage = new stage ();
				arrays.stageObject.theStage.setStageDimensions ();
				arrays.activePluginVars.load ("http://localhost:8899/?method=getActivePlugins");
			}
		};
		activePluginVars.onLoad = function (success:Boolean)
		{
			arrays.theWindow = new windows ();
			arrays.theWindow.addText ("testing0", "This has been compiled with kagswf");
			arrays.theWindow.addText ("testing", "Attempting to load the plugins list.....");
			if (success)
			{
				arrays.activePlugins = new Array ();
				arrays.activePluginsString = new String ("core," + this.toString ().split ("%2C").join (",").split ("%22").join ("").split ("%20").join ("").split ("%5B").join ("").split ("%5D").join ("").split ("=&onLoad=typeFunction").join (""));
				//trace ("core," + this.toString ().split ("%2C").join (",").split ("%22").join ("").split ("%20").join ("").split ("%5B").join ("").split ("%5D").join (""))
				arrays.activePlugins = arrays.activePluginsString.split (",");
				arrays.theWindow.addText ("PluginsString", "Loading the list was successful, the Active plugins are : \n" + arrays.activePlugins.toString ());
				arrays.ArraysXmlData.load ("xml/plugins.xml");
			}
			else
			{
				arrays.theWindow.addText ("PluginsString", "Couldn't load the activePlugins list, all plugins are randomly chosen as enabled or not");
				arrays.ArraysXmlData.load ("xml/plugins.xml");
			}
			arrays.theWindow.addButton ("done");
			arrays.theWindow.container.canvas.done.onRelease = function ()
			{
				arrays.theWindow.closeWindow ();
				arrays.theWindow.inactivePress ();
			};
			arrays.theWindow.openWindow (false);
		};
	}
	public function createObjects ()
	{
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			for (var j:Number = 0; j < pl_groupArray[i].length; j++)
			{
				pluginArray.push (pl_groupArray[i][j]);
			}
		}
		pluginArrayAlpha = pluginArray.concat ().sort (order);
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			groupOrderArray[i] = 0;
			groupObject[groupArray[i]] = new groups (groupArray[i], i);
			menuObject[groupArray[i]] = new menus (groupArray[i], i);
			groupNumbers[groupArray[i]] = i;
		}
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			for (var j:Number = 0; j < pl_groupArray[i].length; j++)
			{
				pluginObject[pl_groupArray[i][j]] = new plugins (pl_groupArray[i][j], i, j);
			}
		}
		for (var i:Number = 0; i < pluginArrayAlpha.length; i++)
		{
			pluginObject[pluginArrayAlpha[i]].pluginIndex = i;
			if (pluginObject[pluginArrayAlpha[i]].groupNum == 0)
			{
				if (pluginObject[pluginArrayAlpha[i]].pluginNum == 0)
				{
					base.initialIndex = i;
				}
			}
			pluginObject[pluginArrayAlpha[i]].setAttributes ();
		}
		mouseObject.mouse = new theMouse ();
		funcBarObject.Preferences = new preferencesBtn ("Preferences", 0);
		windowArray.push ("Preferences");
		funcBarObject.Profiles = new profilesBtn ("Profiles", 1);
		windowArray.push ("Profiles");
		funcBarObject.ShowAll = new showAllBtn ("ShowAll", 2);
		funcBarObject.Quit = new quitBtn ("Quit", 3);
		creation.setDepths (depth);
	}
	static function createEnabledSort ()
	{
		pluginArrayAlphaEnabled = new Array ();
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			for (var j:Number = 0; j < pl_groupArray[i].length; j++)
			{
				pluginArrayAlphaEnabled.push (pl_groupArray[i][j]);
			}
		}
		var array:Array = pluginArrayAlphaEnabled;
		var enabledIndex:Number = 0;
		var disabledIndex:Number = 0;
		for (var i:Number = 0; i < array.length; i++)
		{
			var thePlugin:Object = arrays.pluginObject[array[i]];
			var pluginName:String = array[i];
			var pluginState:Boolean = arrays.pluginObject[array.splice (i, 1)].isEnabled;
			if (pluginState == true)
			{
				array.splice (enabledIndex, 0, pluginName);
				enabledIndex++;
			}
			else
			{
				array.splice (enabledIndex + disabledIndex, 0, pluginName);
				disabledIndex++;
			}
		}
	}
	static function createGroupEnabledSort ()
	{
		pluginNormalArray = new Array ();
		for (var j:Number = 0; j < groupArray.length; j++)
		{
			var pluginGroupArray:Array = new Array ();
			for (var i:Number = 0; i < pl_groupArray[j].length; i++)
			{
				pluginGroupArray.push (pl_groupArray[j][i]);
			}
			var array:Array = pluginGroupArray;
			var enabledIndex:Number = 0;
			var disabledIndex:Number = 0;
			for (var i:Number = 0; i < array.length; i++)
			{
				var thePlugin:Object = arrays.pluginObject[array[i]];
				var pluginName:String = array[i];
				var pluginState:Boolean = arrays.pluginObject[array.splice (i, 1)].isEnabled;
				if (pluginState == true)
				{
					array.splice (enabledIndex, 0, pluginName);
					enabledIndex++;
				}
				else
				{
					array.splice (enabledIndex + disabledIndex, 0, pluginName);
					disabledIndex++;
				}
			}
			for (var z:Number = 0; z < array.length; z++)
			{
				pluginNormalArray.push (array[z]);
			}
		}
	}
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
	static function editWindow (string:String)
	{
		clearInterval (Int);
		arrays.theWindow.destroyWindow ();
		Int = setInterval (EventDelegate.create (_root.theArrays, editTheWindow), 10, string);
	}
	static function editTheWindow (string:String)
	{
		if (arrays.theWindow.isDone == true)
		{
			arrays.theWindow = new windows ();
			arrays.theWindow.addText ("PluginsString", string);
			arrays.theWindow.addButton ("done");
			arrays.theWindow.container.canvas.done.onRelease = function ()
			{
				arrays.theWindow.closeWindow (false);
				arrays.theWindow.inactivePress ();
			};
			arrays.theWindow.openWindow (false);
			clearInterval (Int);
		}
	}
}
