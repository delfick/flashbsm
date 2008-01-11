import mx.utils.Delegate;
import objects.*;
import base.*;
import ui.*;
class ui.funcbar.preferencesBtn extends objects.functionBar
{
	function preferencesBtn (__name:String, __num:Number)
	{
		theName = __name;
		theIndex = __num;
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
		theWindow.addItem ("checkbox", "Animated", animated == true ? "on" : "off");
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
		theWindow.addItem ("button", "done");
		theWindow.container.canvas.done.onRelease = function ()
		{
			arrays.windowObject.Preferences.closeWindow (false);
			arrays.funcBarObject.Preferences.inactivePress ();
		};
	}
}
