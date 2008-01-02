import objects.*;
import mx.utils.Delegate;
class theMouse extends base.base
{
	//common variables to all classes
	public var baseDepth:Number;
	public var neededDepths:Number = 2;
	private var container:MovieClip;
	private var interval:Number;
	//
	//
	function createClips ()
	{
		_root.createEmptyMovieClip ("mouse", baseDepth);
		container = _root.mouse;
	}
	//
	//
	function considerNewArea (type:String, left:Number, right:Number, top:Number, bottom:Number, num:Number)
	{
		stopChecking ();
		interval = setInterval (EventDelegate.create (this, checkLocation), 10, type, left, right, top, bottom, num);
	}
	//
	//
	function checkLocation (type:String, left:Number, right:Number, top:Number, bottom:Number, num:Number)
	{
		//createRectangle(container, left, top, right-left, bottom-top, 2, 0,  blue,  blue, 26);
		if (_root._ymouse < top)
		{
			stopChecking ();
			tooFarUp (type, num);
		}
		if (_root._ymouse > bottom)
		{
			stopChecking ();
			tooFarDown (type, num);
		}
		if (_root._xmouse < left)
		{
			stopChecking ();
			tooFarLeft (type, num);
		}
		if (_root._xmouse > right)
		{
			stopChecking ();
			tooFarRight (type, num);
		}
	}
	//
	//
	function tooFarRight (type:String, num:Number)
	{
		switch (type)
		{
		case "overGroup" :
		case "overMenu" :
			if (groupObject[groupArray[num]].action != "pressed")
			{
				menuObject[groupArray[num]].changeAction ("up");
				groupObject[groupArray[num]].reColour ("rollOut");
				plugins.groupRollOutSort (num);
			}
			else
			{
				stopChecking ();
			}
			break;
		}
	}
	//
	//
	function tooFarLeft (type:String, num:Number)
	{
		switch (type)
		{
		case "overGroup" :
		case "overMenu" :
			if (groupObject[groupArray[num]].action != "pressed")
			{
				menuObject[groupArray[num]].changeAction ("up");
				groupObject[groupArray[num]].reColour ("rollOut");
				plugins.groupRollOutSort (num);
			}
			else
			{
				stopChecking ();
			}
			break;
		}
	}
	//
	//
	function tooFarUp (type:String, num:Number)
	{
		switch (type)
		{
		case "overGroup" :
			if (groupObject[groupArray[num]].action != "pressed")
			{
				groupObject[groupArray[num]].reColour ("rollOut");
				menuObject[groupArray[num]].changeAction ("up");
				plugins.groupRollOutSort (num);
			}
			else
			{
				stopChecking ();
			}
			break;
		case "overMenu" :
			menuObject[groupArray[num]].changeAction ("up");
			plugins.groupRollOutSort (num);
			break;
		}
	}
	//
	//
	function tooFarDown (type:String, num:Number)
	{
		switch (type)
		{
		case "overGroup" :
			if (groupObject[groupArray[num]].action != "pressed")
			{
				var left:Number = menuObject[groupArray[num]].menux;
				var right:Number = left + menus.menuwidth;
				var top:Number = topY + topHeight - 4;
				var bottom:Number = menus.menuy + pl_groupArray[num].length * plugins.pluginHeight;
				considerNewArea ("overMenu", left, right, top, bottom, num);
				groupObject[groupArray[num]].reColour ("rollOut");
			}
			else
			{
				stopChecking ();
			}
			break;
		case "overMenu" :
			menuObject[groupArray[num]].changeAction ("up");
			plugins.groupRollOutSort (num);
			break;
		}
	}
	//
	//
	function stopChecking ()
	{
		clearInterval (interval);
		//container.clear();
	}
	//
	//
	//
	function setbaseDepth (__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	function get Depth ():Number
	{
		return baseDepth;
	}
	function set theContainer (mc:MovieClip)
	{
		container = mc;
	}
}
