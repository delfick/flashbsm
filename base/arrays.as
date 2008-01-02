import base.*
import objects.*
import ui.*
class base.arrays extends MovieClip
{
	//
	// Arrays
	//
	static var groupArray:Array = new Array ();
	static var pluginArray:Array = new Array ();
	static var pl_groupArray:Array = new Array ();
	static var funcBarArray:Array = new Array ();
	static var activePlugins:Array = new Array();
	static var tabNameArray:Array = new Array ();
	static var groupOrderArray:Array = new Array ();
	static var windowArray:Array = new Array ();
	static var groupArrayAlpha:Array = new Array ();
	static var pluginArrayAlpha:Array = new Array ();
	static var pluginArrayAlphaEnabled:Array = new Array ();
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
	static var Int:Number;
	//
	//
	function createArrays (container:MovieClip)
	{
		base.trace("still a work in progress");
		arrays.theWindow = new ui.windows ();
		arrays.theWindow.addItem ("text", "testing0", "This has been compiled with kagswf");
		arrays.theWindow.addItem ("text", "testing", "WOOT IT WORKS!");
		arrays.theWindow.addItem ("button", "done");
		arrays.theWindow.container.canvas.done.onRelease = function ()
		{
			arrays.theWindow.closeWindow (false);
			arrays.theWindow.inactivePress ();
		};
		arrays.theWindow.openWindow (false);
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
	//
	//
	function createObjects()
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
