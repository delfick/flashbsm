import mx.utils.Delegate;
import objects.*;
class objects.funcBar.profilesBtn extends objects.functionBar
{
	function profilesBtn (__name:String, __num:Number)
	{
		theName = __name;
		number = __num;
		arrays.funcBarArray.push (theName);
	}
	function activePress ()
	{
		active = true;
		windowObject.Profiles.openWindow (false);
		reColour (base.red, 20, base.black);
	}
	function inactivePress ()
	{
		active = false;
		windowObject.Profiles.closeWindow ();
		reColour (base.white, 20, base.black);
	}
	function createWindow ()
	{
		var theWindow:Object = windowObject[theName];
		theWindow.addButton ("done");
		theWindow.container.canvas.done.onRelease = function ()
		{
			arrays.windowObject.Profiles.closeWindow (false);
			arrays.funcBarObject.Profiles.inactivePress ();
		};
	}
}
