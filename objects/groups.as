import objects.*;
import mx.utils.Delegate;
class iobjects.groups extends base.arrays
{
	//common variables to all classes
	public var baseDepth:Number;
	public var neededDepths:Number = 2;
	private var container:MovieClip;
	private var interval:Number;
	//properties
	public var action:String;
	public var theName:String;
	public var groupNum:Number;
	//common to all groups
	static var selectedGroup:Number;
	static var groupSections:Number;
	static var groupWidth:Number;
	static var groupHeight:Number;
	static var groupGap:Number;
	//
	//
	public function groups (__name:String, __groupNum:Number)
	{
		groupNum = __groupNum;
		theName = __name;
		selectedGroup = 0;
		groupSections = (stageWidth - 15) / (groupArray.length);
		groupWidth = (0.9 * groupSections);
		groupHeight = topHeight - gap;
		groupGap = (groupSections - groupWidth) / 2;
	}
	//
	//
	static function createClips ()
	{
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			var grName:String = groupObject[groupArray[i]].Name;
			var grDepth:Number = groupObject[groupArray[i]].Depth;
			_root.createEmptyMovieClip ("group_" + grName, grDepth);
			groupObject[groupArray[i]].createContainer (_root["group_" + grName]);
		}
	}
	//
	//
	function createContainer (__container:MovieClip)
	{
		container = __container;
		container._x = 7.5 + groupGap + groupSections * groupNum;
		container._y = 8;
		//create text :: "instance name", depth, x position, y position, width, height
		container.createTextField ("label_txt", baseDepth + 1, 0, (groupHeight / 2) - (22 / 2), groupWidth, 36);
		container.label_txt.setNewTextFormat (textFormat);
		container.label_txt.selectable = false;
		container.label_txt.multiline = true;
		container.label_txt.wordWrap = true;
		container.label_txt.text = theName;
		setEvents (groupNum);
		if (container.label_txt.textHeight > 20)
		{
			container.label_txt._y -= 4;
		}
		if (groupNum == selectedGroup)
		{
			createShape (blue, 26, black);
		}
		else
		{
			createShape (white, 26, blue);
		}
	}
	//
	//
	private function setEvents (num:Number)
	{
		container.onRollOver = function ()
		{
			groups.groupRoll (num);
		};
		container.onRelease = function ()
		{
			groups.groupPress (num);
		};
		container.onRollOut = function ()
		{
			//this is handled by the mouse class because the groups are special (they have the menus)
		};
	}
	//
	//
	function setbaseDepth (__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	function reColour (__action:String)
	{
		action = __action;
		if (__action == "roll")
		{
			createShape (white, 26, black);
		}
		else if (__action == "pressed")
		{
			createShape (blue, 26, black);
		}
		else if (__action == "rollOut")
		{
			createShape (white, 26, blue);
		}
	}
	function createShape (fillColour:Number, fillAlpha:Number, textColour:Number, type:String)
	{
		createRectangle (container, 0, 0, groupWidth, groupHeight, 1, 10, black, fillColour, fillAlpha);
		container.label_txt.textColor = textColour;
	}
	//
	//
	static function groupRoll (num:Number)
	{
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			if (i == selectedGroup)
			{
				groupObject[groupArray[i]].reColour ("pressed");
			}
			else if (i == num)
			{
				groupObject[groupArray[i]].reColour ("roll");
				menuObject[groupArray[i]].changeAction ("down");
				plugins.groupRollSort (i);
				var left:Number = 7.5 + groups.groupGap + groups.groupSections * i;
				var right:Number = left + groups.groupWidth;
				var top:Number = topY;
				var bottom:Number = topY + topHeight;
				mouseObject.mouse.considerNewArea ("overGroup", left, right, top, bottom, i);
			}
			else
			{
				menuObject[groupArray[i]].changeAction ("up");
				groupObject[groupArray[i]].reColour ("rollOut");
			}
		}
	}
	//
	//
	static function groupPress (num:Number)
	{
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			if (i == num)
			{
				plugins.pluginPress (i, 0, pluginObject[pl_groupArray[i][0]].pluginIndex);
			}
		}
	}
	//
	//
	static function hideGroups ()
	{
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			groupObject[groupArray[i]].container._visible = false;
		}
	}
	//
	//
	static function showGroups ()
	{
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			groupObject[groupArray[i]].container._visible = true;
		}
	}
}

