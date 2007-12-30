import objects.*;
import mx.utils.Delegate;
class objects.shapes extends base
{
	static var topLeftx:Number;
	static var topLefty:Number;
	static var topRightx:Number;
	static var topRighty:Number;
	static var bottomRightx:Number;
	static var bottomRighty:Number;
	static var bottomLeftx:Number;
	static var bottomLefty:Number;
	static var Int:Number;
	static var clipLoader:MovieClipLoader = new MovieClipLoader ();
	//
	//images
	//
	public static function createRectangle (mc:MovieClip, left:Number, top:Number, recWidth:Number, recHeight:Number, lineWidth:Number, cornerradius:Number, lineColour:Number, fillColour:Number, fillAlpha:Number)
	{
		topLeftx = left;
		topLefty = top;
		topRightx = left + recWidth;
		topRighty = top;
		bottomRightx = left + recWidth;
		bottomRighty = top + recHeight;
		bottomLeftx = left;
		bottomLefty = top + recHeight;
		mc.clear ();
		mc.beginFill (fillColour, fillAlpha);
		mc.moveTo (topLeftx + cornerradius, topLefty);
		//line style
		mc.lineStyle (lineWidth, lineColour);
		//start drawing
		mc.lineTo (topRightx - cornerradius, topRighty);
		mc.curveTo (topRightx, top, topRightx, topRighty + cornerradius);
		mc.lineTo (topRightx, topRighty + cornerradius);
		mc.lineTo (bottomRightx, bottomRighty - cornerradius);
		mc.curveTo (bottomRightx, bottomRighty, bottomRightx - cornerradius, bottomRighty);
		mc.lineTo (bottomRightx - cornerradius, bottomRighty);
		mc.lineTo (bottomLeftx + cornerradius, bottomLefty);
		mc.curveTo (bottomLeftx, bottomLefty, bottomLeftx, bottomLefty - cornerradius);
		mc.lineTo (bottomLeftx, bottomLefty - cornerradius);
		mc.lineTo (topLeftx, topLefty + cornerradius);
		mc.curveTo (topLeftx, topLefty, topLeftx + cornerradius, topLefty);
		mc.lineTo (topLeftx + cornerradius, topLefty);
		mc.endFill ();
	}
	public static function createStaticRectangle (mc:MovieClip, left:Number, top:Number, recWidth:Number, recHeight:Number, lineWidth:Number, cornerradius:Number, lineColour:Number, fillColour:Number, fillAlpha:Number)
	{
		//
		//This function is the same as above except doesn't have mc.clear()
		//
		topLeftx = left;
		topLefty = top;
		topRightx = left + recWidth;
		topRighty = top;
		bottomRightx = left + recWidth;
		bottomRighty = top + recHeight;
		bottomLeftx = left;
		bottomLefty = top + recHeight;
		mc.beginFill (fillColour, fillAlpha);
		mc.moveTo (topLeftx + cornerradius, topLefty);
		//line style
		mc.lineStyle (lineWidth, lineColour);
		//start drawing
		mc.lineTo (topRightx - cornerradius, topRighty);
		mc.curveTo (topRightx, top, topRightx, topRighty + cornerradius);
		mc.lineTo (topRightx, topRighty + cornerradius);
		mc.lineTo (bottomRightx, bottomRighty - cornerradius);
		mc.curveTo (bottomRightx, bottomRighty, bottomRightx - cornerradius, bottomRighty);
		mc.lineTo (bottomRightx - cornerradius, bottomRighty);
		mc.lineTo (bottomLeftx + cornerradius, bottomLefty);
		mc.curveTo (bottomLeftx, bottomLefty, bottomLeftx, bottomLefty - cornerradius);
		mc.lineTo (bottomLeftx, bottomLefty - cornerradius);
		mc.lineTo (topLeftx, topLefty + cornerradius);
		mc.curveTo (topLeftx, topLefty, topLeftx + cornerradius, topLefty);
		mc.lineTo (topLeftx + cornerradius, topLefty);
		mc.endFill ();
	}
	public static function createNoLineRectangle (mc:MovieClip, left:Number, top:Number, recWidth:Number, recHeight:Number, lineWidth:Number, cornerradius:Number, lineColour:Number, fillColour:Number, fillAlpha:Number)
	{
		//
		//This function is the same as above except doesn't have mc.clear()
		//
		topLeftx = left;
		topLefty = top;
		topRightx = left + recWidth;
		topRighty = top;
		bottomRightx = left + recWidth;
		bottomRighty = top + recHeight;
		bottomLeftx = left;
		bottomLefty = top + recHeight;
		mc.beginFill (fillColour, fillAlpha);
		mc.moveTo (topLeftx + cornerradius, topLefty);
		//line style
		//mc.lineStyle(lineWidth, lineColour);
		//start drawing
		mc.lineTo (topRightx - cornerradius, topRighty);
		mc.curveTo (topRightx, top, topRightx, topRighty + cornerradius);
		mc.lineTo (topRightx, topRighty + cornerradius);
		mc.lineTo (bottomRightx, bottomRighty - cornerradius);
		mc.curveTo (bottomRightx, bottomRighty, bottomRightx - cornerradius, bottomRighty);
		mc.lineTo (bottomRightx - cornerradius, bottomRighty);
		mc.lineTo (bottomLeftx + cornerradius, bottomLefty);
		mc.curveTo (bottomLeftx, bottomLefty, bottomLeftx, bottomLefty - cornerradius);
		mc.lineTo (bottomLeftx, bottomLefty - cornerradius);
		mc.lineTo (topLeftx, topLefty + cornerradius);
		mc.curveTo (topLeftx, topLefty, topLeftx + cornerradius, topLefty);
		mc.lineTo (topLeftx + cornerradius, topLefty);
		mc.endFill ();
	}
	public static function createCircle (mc:MovieClip, radius:Number, lineWidth:Number, lineColour:Number, fillColor:Number, fillAlpha:Number, x1:Number, y1:Number, doLine:Boolean)
	{
		var x:Number = x1;
		var y:Number = y1;
		mc.beginFill (fillColor, fillAlpha);
		mc.moveTo (x + radius, y);
		if (doLine == true)
		{
			mc.lineStyle (lineWidth, lineColour);
		}
		mc.curveTo (radius + x, Math.tan (Math.PI / 8) * radius + y, Math.sin (Math.PI / 4) * radius + x, Math.sin (Math.PI / 4) * radius + y);
		mc.curveTo (Math.tan (Math.PI / 8) * radius + x, radius + y, x, radius + y);
		mc.curveTo (-Math.tan (Math.PI / 8) * radius + x, radius + y, -Math.sin (Math.PI / 4) * radius + x, Math.sin (Math.PI / 4) * radius + y);
		mc.curveTo (-radius + x, Math.tan (Math.PI / 8) * radius + y, -radius + x, y);
		mc.curveTo (-radius + x, -Math.tan (Math.PI / 8) * radius + y, -Math.sin (Math.PI / 4) * radius + x, -Math.sin (Math.PI / 4) * radius + y);
		mc.curveTo (-Math.tan (Math.PI / 8) * radius + x, -radius + y, x, -radius + y);
		mc.curveTo (Math.tan (Math.PI / 8) * radius + x, -radius + y, Math.sin (Math.PI / 4) * radius + x, -Math.sin (Math.PI / 4) * radius + y);
		mc.curveTo (radius + x, -Math.tan (Math.PI / 8) * radius + y, radius + x, y);
		mc.endFill ();
	}
	public static function createRadioBtn (mc:MovieClip, diameter:Number, type:String)
	{
		if (mc.pic == undefined)
		{
			mc.createEmptyMovieClip ("pic", 200);
		}
		mc.clear ();
		switch (type)
		{
		case "on" :
			//mc.pic.loadMovie("images/radio/on.png");
			createCircle (mc, diameter / 2, 1, black, white, 0, diameter / 2, diameter / 2, true);
			createCircle (mc, diameter / 4, 1, black, green, 100, diameter / 2, diameter / 2, true);
			break;
		case "off" :
			//mc.pic.loadMovie("images/radio/off.png");
			createCircle (mc, diameter / 2, 1, black, white, 0, diameter / 2, diameter / 2, true);
			break;
		case "inactive" :
			//mc.pic.loadMovie("images/radio/inactive.png");
			createCircle (mc, diameter / 2, 1, black, grey, 50, diameter / 2, diameter / 2, true);
			break;
		}
	}
	public function createLine (mc:MovieClip, x1:Number, y1:Number, x2:Number, y2:Number, lineWidth:Number, lineColour:Number)
	{
		mc.moveTo (x1, y1);
		mc.lineStyle (lineWidth, lineColour);
		mc.lineTo (x2, y2);
	}
	public static function createCheckBox (mc:MovieClip, sideLength:Number, type:String)
	{
		if (mc.pic == undefined)
		{
			mc.createEmptyMovieClip ("pic", 200);
		}
		mc.clear ();
		switch (type)
		{
		case "on" :
			createStaticRectangle (mc, 0, 0, sideLength, sideLength, 1, 0, black, white, 0);
			createCircle (mc, sideLength / 2.5, 1, white, green, 50, sideLength / 2., sideLength / 2, false);
			break;
		case "off" :
			createStaticRectangle (mc, 0, 0, sideLength, sideLength, 1, 0, black, white, 0);
			break;
		case "inactive" :
			createStaticRectangle (mc, 0, 0, sideLength, sideLength, 1, 0, black, grey, 0);
			break;
		}
	}
	public static function switchImage (mc:MovieClip, type:String)
	{
		switch (type)
		{
		case "on" :
			mc.onState._visible = true;
			mc.offState._visible = false;
			mc.inactiveState._visible = false;
			break;
		case "off" :
			mc.onState._visible = false;
			mc.offState._visible = true;
			mc.inactiveState._visible = false;
			break;
		case "inactive" :
			mc.onState._visible = false;
			mc.offState._visible = false;
			mc.inactiveState._visible = true;
			break;
		}
	}
	public static function createScroller (scroller:MovieClip, beingMoved:MovieClip, top:Number, right:Number, scrollerHeight:Number, gripHeight:Number, scrollerWidth:Number, settingsHeight:Number, settingsAreaHeight:Number, tracer:Boolean)
	{
		scroller.base.clear ();
		scroller.grip.clear ();
		scroller.grip._y = 0;
		createNoLineRectangle (scroller.base, right - scrollerWidth, top, scrollerWidth, scrollerHeight, 1, scrollerWidth / 2, black, black, 20);
		createNoLineRectangle (scroller.grip, right - scrollerWidth, top, scrollerWidth, gripHeight, 1, scrollerWidth / 2, black, blue, 30);
		scroller.grip.onMouseDown = function ()
		{
			if (this.hitTest (_root._xmouse, _root._ymouse))
			{
				this.startDrag (false, 0, 0, 0, scrollerHeight - gripHeight);
				if (tracer)
				{
					shapes.Int = setInterval (shapes.scrollerMoveTrace, 10, this, beingMoved, scrollerHeight, gripHeight, settingsAreaHeight, settingsHeight);
				}
				else
				{
					shapes.Int = setInterval (shapes.scrollerMove, 10, this, beingMoved, scrollerHeight, gripHeight);
				}
			}
		};
		scroller.grip.onMouseUp = function ()
		{
			clearInterval (shapes.Int);
			this.stopDrag ();
		};
	}
	static function scrollerMove (scroller:MovieClip, beingMoved:MovieClip, scrollerHeight:Number, gripHeight:Number)
	{
		beingMoved._y = base.settingsAreaY - (base.settingsAreaHeight - base.settingsHeight) * (scroller._y / (scrollerHeight - gripHeight));
	}
	static function scrollerMoveTrace (scroller:MovieClip, beingMoved:MovieClip, scrollerHeight:Number, gripHeight:Number, settingsAreaHeight:Number, settingsHeight:Number)
	{
		beingMoved._y = 5 + (settingsAreaHeight - settingsHeight) * (scroller._y / (scrollerHeight - gripHeight));
	}
	function createImageHolder (x1:Number, y1:Number, depth:Number, mc:MovieClip, __name:String, type:String, initialState:String)
	{
		mc.createEmptyMovieClip (__name, depth);
		mc[__name]._x = x1;
		mc[__name]._y = y1;
		mc[__name].createEmptyMovieClip ("inactiveState", depth + 1);
		mc[__name].inactiveState.createEmptyMovieClip ("pic", depth + 2);
		mc[__name].createEmptyMovieClip ("offState", depth + 3);
		mc[__name].offState.createEmptyMovieClip ("pic", depth + 4);
		mc[__name].createEmptyMovieClip ("onState", depth + 5);
		mc[__name].onState.createEmptyMovieClip ("pic", depth + 6);
		switch (type)
		{
		case "checkbox" :
			mc[__name].inactiveState.pic.loadMovie ("images/checkbox/inactive.png");
			mc[__name].onState.pic.loadMovie ("images/checkbox/on.png");
			mc[__name].offState.pic.loadMovie ("images/checkbox/off.png");
			break;
		case "radio" :
			mc[__name].inactiveState.pic.loadMovie ("images/radio/inactive.png");
			mc[__name].onState.pic.loadMovie ("images/radio/on.png");
			mc[__name].offState.pic.loadMovie ("images/radio/off.png");
			break;
		}
		switchImage (mc[__name], initialState);
	}
}
