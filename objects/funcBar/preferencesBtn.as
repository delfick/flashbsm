﻿import mx.utils.Delegate;
import objects.*;
class objects.funcBar.preferencesBtn extends objects.functionBar
{
	function preferencesBtn (__name:String, __num:Number)
	{
		theName = __name;
		number = __num;
		arrays.funcBarArray.push (theName);
	}
	function activePress ()
	{
		active = true;
		windowObject.Preferences.openWindow (false);
		reColour (base.red, 20, base.black);
	}
	function inactivePress ()
	{
		active = false;
		windowObject.Preferences.closeWindow ();
		reColour (base.white, 20, base.black);
	}
	function createWindow ()
	{
		var theWindow:Object = windowObject[theName];
		theWindow.addCheckBox ("Animated", animated == true ? "on" : "off");
		theWindow.container.canvas.Animated.onRelease = function ()
		{
			if (base.animated == true)
			{
				base.animated = false;
				shapes.switchImage (this, "off");
			}
			else
			{
				base.animated = true;
				shapes.switchImage (this, "on");
			}
		};
		theWindow.addButton ("done");
		theWindow.container.canvas.done.onRelease = function ()
		{
			arrays.windowObject.Preferences.closeWindow (false);
			arrays.funcBarObject.Preferences.inactivePress ();
		};
	}
}