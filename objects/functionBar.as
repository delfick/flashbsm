﻿import mx.utils.Delegate;
import objects.*;
class objects.functionBar extends objects.shapes
{
	private var boxX:Number = 200;
	private var active:Boolean = false;
	private static var boxY:Number;
	private static var startX:Number;
	private static var gap:Number;
	private var container:MovieClip;
	private var baseDepth:Number = 1;
	private var neededDepths:Number = 1;
	private var theName:String;
	private var radius:Number = 10;
	private var number:Number;
	private var Int:Number;
	private var colourInt:Number;
	static var boxWidth:Number = 100;
	static var boxHeight:Number = 40;
	static var count:Number = 0;
	public static var searchType:String = "normal";
	public static var searchIn:String = "plugins";
	public static var isAlphabetical:Boolean = true;
	public static var tempType:String;
	function functionBar (__name:String, __num:Number)
	{
		count++;
	}
	function setbaseDepth (__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	static function createClips ()
	{
		gap = (funcBarHeight - boxHeight) / 2;
		boxY = funcBarY + gap;
		startX = funcBarX + gap;
		for (var i:Number = 0; i < funcBarArray.length; i++)
		{
			var fbName:String = funcBarObject[funcBarArray[i]].Name;
			var fbDepth:Number = funcBarObject[funcBarArray[i]].Depth;
			_root.createEmptyMovieClip ("funcBar_" + fbName, fbDepth);
			funcBarObject[funcBarArray[i]].createShape ();
		}
	}
	function reColour (fillColour:Number, fillAlpha:Number, textColour:Number)
	{
		createRectangle (container.base, 0, 0, boxWidth, boxHeight, 1, radius, black, fillColour, fillAlpha);
		container.label_txt.textColor = textColour;
	}
	private function setEvents (num:Number)
	{
		container.onRollOver = function ()
		{
			functionBar.funcBarRoll (num);
		};
		container.onRelease = function ()
		{
			functionBar.funcBarPress (num);
		};
		container.onRollOut = function ()
		{
			functionBar.funcBarRollOut (num);
		};
	}
	static function funcBarRoll (num:Number)
	{
		for (var i:Number = 0; i < funcBarArray.length; i++)
		{
			if (i == num)
			{
				if (funcBarObject[funcBarArray[i]].active == true)
				{
					funcBarObject[funcBarArray[i]].reColour (orange, 20, black);
				}
				else
				{
					funcBarObject[funcBarArray[i]].reColour (blue, 20, black);
				}
			}
			else if (funcBarObject[funcBarArray[i]].active == true)
			{
				funcBarObject[funcBarArray[i]].reColour (red, 20, black);
			}
			else
			{
				funcBarObject[funcBarArray[i]].reColour (white, 20, black);
			}
		}
	}
	static function funcBarPress (num:Number)
	{
		for (var i:Number = 0; i < funcBarArray.length; i++)
		{
			if (i == num)
			{
				if (funcBarObject[funcBarArray[i]].active == false)
				{
					funcBarObject[funcBarArray[i]].activePress ();
				}
				else
				{
					funcBarObject[funcBarArray[i]].inactivePress ();
				}
			}
			else if (funcBarObject[funcBarArray[i]].active == true)
			{
				funcBarObject[funcBarArray[i]].reColour (red, 20, black);
			}
			else
			{
				funcBarObject[funcBarArray[i]].reColour (white, 20, black);
			}
		}
	}
	static function funcBarRollOut (num:Number)
	{
		for (var i:Number = 0; i < funcBarArray.length; i++)
		{
			if (funcBarObject[funcBarArray[i]].active == true)
			{
				funcBarObject[funcBarArray[i]].reColour (red, 20, black);
			}
			else
			{
				funcBarObject[funcBarArray[i]].reColour (white, 20, black);
			}
		}
	}
	function activePress ()
	{
		trace (theName);
	}
	function inactivePress ()
	{
		trace (theName);
	}
	function createShape ()
	{
		container = _root["funcBar_" + theName];
		container.createEmptyMovieClip ("base", 2);
		createRectangle (container.base, 0, 0, boxWidth, boxHeight, 1, radius, black, white, 20);
		container.createTextField ("label_txt", 0, 0, 10, boxWidth, 36);
		container.label_txt.setNewTextFormat (textFormat);
		container.label_txt.text = theName;
		container.label_txt.multiline = true;
		container.label_txt.autoSize = false;
		setPosition ();
		setEvents (number);
	}
	function setPosition ()
	{
		container._x = startX + boxWidth * number + gap * number;
		container._y = boxY;
	}
	function get Name ():String
	{
		return theName;
	}
	function get Depth ():Number
	{
		return baseDepth;
	}
	function set theContainer (mc:MovieClip)
	{
		container = mc;
	}
	function get theContainer ():MovieClip
	{
		return container;
	}
	function set xCoord (num:Number)
	{
		boxX = num;
	}
}
