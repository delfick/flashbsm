import objects.*;
import base.*;
import ui.*;
import mx.utils.Delegate;
class ui.shapes extends base.base
{
	static var topLeftx:Number;
	static var topLefty:Number;
	static var topRightx:Number;
	static var topRighty:Number;
	static var bottomRightx:Number;
	static var bottomRighty:Number;
	static var bottomLeftx:Number;
	static var bottomLefty:Number;
	static var interval:Number;
	static var clipLoader:MovieClipLoader = new MovieClipLoader ();
	//
	//
	//////////////////////// SHAPES
	//
	//
	public static function createShape (theType:String)
	{
		var theParams:Array = arguments.splice (1, arguments.length - 1);
		switch (theType)
		{
			//
			//	// Rectangle
			//
		case "rectangle" :
			//mc, left, top, recWidth, recHeight, cornerRadius, fillColour, fillAlpha, haveLine, isStatic, lineWidth, lineColour, doTrace
			var mc:MovieClip = theParams[0];
			var left:Number = theParams[1];
			var top:Number = theParams[2];
			var recWidth:Number = theParams[3];
			var recHeight:Number = theParams[4];
			var cornerRadius:Number = theParams[5];
			var fillColour:Number = theParams[6];
			var fillAlpha:Number = theParams[7];
			var isStatic:Boolean = theParams[8];
			var haveLine:Boolean = theParams[9];
			var lineWidth:Number
			var lineColour:Number
			var doTrace:Boolean
			if (haveLine == true)
			{
				lineWidth = theParams[10];
				lineColour = theParams[11];
				doTrace = theParams[12];
			}
			else
			{
				doTrace = theParams[10];
			}
			//
			//set some stuff
			//
			topLeftx = left;
			topLefty = top;
			topRightx = left + recWidth;
			topRighty = top;
			bottomRightx = left + recWidth;
			bottomRighty = top + recHeight;
			bottomLeftx = left;
			bottomLefty = top + recHeight;
			//
			//begin the drawing
			//
			if (isStatic == false)
			{
				mc.clear ();
			}
			mc.beginFill (fillColour, fillAlpha);
			mc.moveTo (topLeftx + cornerRadius, topLefty);
			//line style
			if (haveLine == true)
			{
				mc.lineStyle (lineWidth, lineColour);
			}
			//start drawing
			mc.lineTo (topRightx - cornerRadius, topRighty);
			mc.curveTo (topRightx, top, topRightx, topRighty + cornerRadius);
			mc.lineTo (topRightx, topRighty + cornerRadius);
			mc.lineTo (bottomRightx, bottomRighty - cornerRadius);
			mc.curveTo (bottomRightx, bottomRighty, bottomRightx - cornerRadius, bottomRighty);
			mc.lineTo (bottomRightx - cornerRadius, bottomRighty);
			mc.lineTo (bottomLeftx + cornerRadius, bottomLefty);
			mc.curveTo (bottomLeftx, bottomLefty, bottomLeftx, bottomLefty - cornerRadius);
			mc.lineTo (bottomLeftx, bottomLefty - cornerRadius);
			mc.lineTo (topLeftx, topLefty + cornerRadius);
			mc.curveTo (topLeftx, topLefty, topLeftx + cornerRadius, topLefty);
			mc.lineTo (topLeftx + cornerRadius, topLefty);
			mc.endFill ();
			if (doTrace)
			{
				base.trace("\t" + mc, orange);
			//	base.trace("\t(" + topLeftx + "," + topLefty + ")", orange);
			//	base.trace("\t(" + topRightx + "," + topRighty + ")", orange);
			//	base.trace("\t(" + bottomLeftx + "," + bottomLefty + ")", orange);
			//	base.trace("\t(" + bottomRightx + "," + bottomRighty + ")", orange);
			}
			break;
			//
			//	// CIRCLE
			//
		case "circle" :
			//mc, radius, fillColourfillAlpha, x1, y1, doLine, lineWidth, lineColour
			var mc:MovieClip = theParams[0];
			var radius:Number = theParams[1];
			var fillColour:Number = theParams[2];
			var fillAlpha:Number = theParams[3];
			var x1:Number = theParams[4];
			var y1:Number = theParams[5];
			var doLine:Boolean = theParams[6];
			var lineWidth:Number
			var lineColour:Number
			if (doLine == true)
			{
				lineWidth = theParams[7];
				lineColour = theParams[8];
			}
			//
			//set some stuff
			//
			var x:Number = x1;
			var y:Number = y1;
			//
			//begin Drawing
			//
			mc.beginFill (fillColour, fillAlpha);
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
			break;
			//
			//	// LINE
			//
		case "line" :
			//mc
			var mc:MovieClip = theParams[0];
			var x1:Number = theParams[1];
			var y1:Number = theParams[2];
			var x2:Number = theParams[3];
			var y2:Number = theParams[4];
			var lineWidth:Number = theParams[5];
			var lineColour:Number = theParams[6];
			//
			//begin Drawing
			//
			mc.moveTo (x1, y1);
			mc.lineStyle (lineWidth, lineColour);
			mc.lineTo (x2, y2);
			break;
		}
	}
	//
	//
	//////////////////////// CONTROLS
	//
	//
	public static function createControl (theType:String)
	{
		var theParams:Array = arguments.splice (1, arguments.length - 1);
		switch (theType)
		{
			//
			//	// RadioBtn
			//
		case "radioBtn" :
			//mc, diameter, type
			var mc:MovieClip = theParams[0];
			var diameter:Number = theParams[1];
			var theRadioType:String = theParams[2];
			//
			//begin the drawing
			//
			if (mc.pic == undefined)
			{
				mc.createEmptyMovieClip ("pic", 200);
			}
			mc.clear ();
			switch (theRadioType)
			{
			case "on" :
				//mc.pic.loadMovie("images/radio/on.png");
				createShape ("circle", mc, diameter / 2, white, 0, diameter / 2, diameter / 2, true, 1, black);
				createShape ("circle", mc, diameter / 4, green, 100, diameter / 2, diameter / 2, true, 1, black);
				break;
			case "off" :
				//mc.pic.loadMovie("images/radio/off.png");
				createShape ("circle", mc, diameter / 2, white, 0, diameter / 2, diameter / 2, true, 1, black);
				break;
			case "inactive" :
				//mc.pic.loadMovie("images/radio/inactive.png");
				createShape ("circle", mc, diameter / 2, grey, 50, diameter / 2, diameter / 2, true, 1, black);
				break;
			}
			break;
			//
			//	// CheckBox
			//
		case "checkBox" :
			//mc, sideLegnth, theType
			var mc:MovieClip = theParams[0];
			var sideLength:Number = theParams[1];
			var theCheckBoxType:String = theParams[2];
			//
			//begin the drawing
			//
			if (mc.pic == undefined)
			{
				mc.createEmptyMovieClip ("pic", 200);
			}
			mc.clear ();
			switch (theCheckBoxType)
			{
				//mc, left, top, recWidth, recHeight, cornerRadius, fillColour, fillAlpha, haveLine, isStatic, lineWidth, lineColour
				//mc, left, top, recWidth, recHeight, lineWidth, cornerRadius, lineColour, fillColour, fillAlpha
			case "on" :
				createShape ("rectangle", mc, 0, 0, sideLength, sideLength, 0, white, 0, true, true, 1, black);
				createShape ("circle", mc, sideLength / 2.5, green, 50, sideLength / 2., sideLength / 2, false);
				break;
			case "off" :
				createShape ("rectangle", mc, 0, 0, sideLength, sideLength, 0, white, 0, true, true, 1, black);
				break;
			case "inactive" :
				createShape ("rectangle", mc, 0, 0, sideLength, sideLength, 0, grey, 0, true, true, 1, black);
				break;
			}
			break;
			//
			//	// Scroller
			//
		case "scroller" :
			//scroller, beingMoved, top, right, scrollerHeight, gripHeight, scollerWidth, settingsHeight, settingsAreaHeight, tracer
			var scroller:MovieClip = theParams[0];
			var beingMoved:MovieClip = theParams[1];
			var top:Number = theParams[2];
			var right:Number = theParams[3];
			var scrollerHeight:Number = theParams[4];
			var gripHeight:Number = theParams[5];
			var scrollerWidth:Number = theParams[6];
			var settingsHeight:Number = theParams[7];
			var settingsAreaHeight:Number = theParams[8];
			var tracer:Boolean = theParams[9];
			//
			//begin the drawing
			//
			scroller.base.clear ();
			scroller.grip.clear ();
			scroller.grip._y = 0;
			createShape ("rectangle", scroller.base, right - scrollerWidth, top, scrollerWidth, scrollerHeight, scrollerWidth / 2, black, 20, true, false);
			createShape ("rectangle", scroller.grip, right - scrollerWidth, top, scrollerWidth, gripHeight, scrollerWidth / 2, blue, 30, true, false);
			scroller.grip.onMouseDown = function ()
			{
				if (this.hitTest (_root._xmouse, _root._ymouse))
				{
					this.startDrag (false, 0, 0, 0, scrollerHeight - gripHeight);
					if (tracer)
					{
						shapes.interval = setInterval (shapes.scrollerMoveTrace, 10, this, beingMoved, scrollerHeight, gripHeight, settingsAreaHeight, settingsHeight);
					}
					else
					{
						shapes.interval = setInterval (shapes.scrollerMove, 10, this, beingMoved, scrollerHeight, gripHeight);
					}
				}
			};
			scroller.grip.onMouseUp = function ()
			{
				clearInterval (shapes.interval);
				this.stopDrag ();
			};
			break;
		}
	}
	//
	//
	//////////////////////// SCROLLER
	//
	//
	static function scrollerMove (scroller:MovieClip, beingMoved:MovieClip, scrollerHeight:Number, gripHeight:Number)
	{
		beingMoved._y = -(settingsAreaHeight - settingsHeight) * (scroller._y / (scrollerHeight - gripHeight));
	}
	static function scrollerMoveTrace (scroller:MovieClip, beingMoved:MovieClip, scrollerHeight:Number, gripHeight:Number, settingsAreaHeight:Number, settingsHeight:Number)
	{
		beingMoved._y = 5 + (settingsAreaHeight - settingsHeight) * (scroller._y / (scrollerHeight - gripHeight));
	}
	//
	//
	//////////////////////// IMAGES
	//
	//
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
	static function createImageHolder (x1:Number, y1:Number, depth:Number, mc:MovieClip, __name:String, type:String, initialState:String)
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
