import objects.*;
import ui.*;
import base.*;
import mx.utils.Delegate;
class ui.windows extends base.base
{
	//common variables to all classes
	static var baseDepth:Number = 4500;
	private var canvasDepth:Number = 10;
	static var neededDepths:Number = 200;
	private var container:MovieClip;
	private var interval:Number
	//variable dimensions/co-ords
	public var finalboxHeight:Number;
	public var finalboxWidth:Number;
	private var boxHeight:Number;
	private var boxWidth:Number;
	private var boxX:Number;
	private var boxY:Number;
	private var finalX:Number;
	private var finalY:Number;
	//fixed dimensions/co-ords
	public var fixedX:Number = 0;
	public var fixedY:Number = 0;
	public var fixedWidth:Number = 0;
	public var fixedHeight:Number = 0;
	//properties
	private var isDone:Boolean = true;
	private var isThere:Boolean = true;
	private var speed:Number = 0.2;
	public var radius:Number = 10;
	static var count:Number = 0;
	//random
	public var logger:Object = ""
	static var initialTrace:Boolean = true
	//
	////////////////WINDOW BASE
	//
	public function windows (theWidth:Number, theHeight:Number)
	{
		count++;
		createClips ();
		theWidth == undefined? finalboxWidth = 300 : finalboxWidth = theWidth;
		theHeight == undefined? finalboxHeight = 0 : finalboxHeight = theHeight;
	}
	public function createClips ()
	{
		fixedWidth == 0 ? boxWidth = 0 : boxWidth = fixedWidth;
		fixedHeight == 0 ? boxHeight = 0 : boxHeight = fixedHeight;
		boxX = (stageWidth / 2);
		boxY = (stageHeight / 2);
		_root.createEmptyMovieClip ("window_" + baseDepth + count, baseDepth + count);
		container = _root["window_" + baseDepth + count];
		createContainer ();
	}
	public function createContainer ()
	{
		container.createEmptyMovieClip ("canvas", 3);
		container.createEmptyMovieClip ("base", 2);
		container.createEmptyMovieClip ("mask", 4);
		container.createEmptyMovieClip ("theShadow", 1);
		container.theShadow.useHandCursor = false;
		container.theShadow.onRollOver = function ()
		{
		};
		container.theShadow.onRollOut = function ()
		{
		};
		container.theShadow.onRelease = function ()
		{
		};
		container.canvas.setMask (container.mask);
		container._x = boxX;
		container._y = boxY;
	}
	//
	//////////////// DO STUFF WITH WINDOW
	//
	public function openWindow(doNow:Boolean)
	{
		clearInterval (interval);
		isDone = false;
		isThere = false;
		container.theShadow.clear ();
		if (fixedWidth != 0)
		{
			finalboxWidth = fixedWidth;
		}
		if (fixedHeight != 0)
		{
			finalboxHeight = fixedHeight;
		}
		container.canvas._x = -(finalboxWidth / 2);
		container.canvas._y = -(finalboxHeight / 2);
		shapes.createShape ("rectangle", container.theShadow, -(Stage.width / 2), -(Stage.height / 2), Stage.width + 20, Stage.height + 20,  0, black, 20, false, false);
		interval = setInterval (EventDelegate.create (this, resizeBox), 10, finalboxWidth, finalboxHeight, doNow);
	}
	public function closeWindow(doNow:Boolean)
	{
		clearInterval (interval);
		isDone = false;
		isThere = false;
		interval = setInterval (EventDelegate.create (this, resizeBox), 10, 0, 0, doNow);
	}
	public function resizeBox(finalWidth:Number, finalHeight:Number, doNow:Boolean)
	{
		if (isThere == false)
		{
			fixedX == 0 ? finalX = (stageWidth / 2) : finalX = fixedX;
			fixedY == 0 ? finalY = (stageHeight / 2) : finalY = fixedY;
			if (animated == true && doNow == false)
			{
				if (Math.abs (container._x - finalX) > 1 || Math.abs (container._y - finalY) > 1)
				{
					//Move towards target
					container._x += (finalX - container._x) * speed;
					container._y += (finalY - container._y) * speed;
				}
				else
				{
					container._x = finalX;
					container._y = finalY;
					isThere = true;
				}
			}
			else
			{
				container._x = finalX;
				container._y = finalY;
				isThere = true;
			}
		}
		if (isDone == false)
		{
			if (animated == true && doNow == false)
			{
				if (Math.abs (boxWidth - finalWidth) > 1 || Math.abs (boxHeight - finalHeight) > 1)
				{
					//Move towards target
					boxWidth += (finalWidth - boxWidth) * speed;
					boxHeight += (finalHeight - boxHeight) * speed;
				}
				else
				{
					boxWidth = finalWidth;
					boxHeight = finalHeight;
					isDone = true;
				}
				shapes.createShape ("rectangle", container.base, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, boxHeight > radius ? radius : boxHeight, white, 100, false, true, 1, black);
				shapes.createShape ("rectangle", container.mask, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, boxHeight > radius ? radius : boxHeight, white, 100, false, true, 1, black);
			}
			else
			{
				boxWidth = finalWidth;
				boxHeight = finalHeight;
				isDone = true;
				shapes.createShape ("rectangle", container.base, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, boxHeight > radius ? radius : boxHeight, white, 100, false, true, 1, black);
				shapes.createShape ("rectangle", container.mask, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, boxHeight > radius ? radius : boxHeight, white, 100, false, true, 1, black);
			}
		}
		if (isDone == true)
		{
			if (isThere == true)
			{
				if (boxHeight == 0)
				{
					container.base.clear ();
					container.mask.clear ();
					container.theShadow.clear ();
				}
				clearInterval (interval);
			}
		}
	}
	//
	//////////////// ADD TO WINDOW
	//
	public function addItem(theType:String)
	{
		var theParams:Array = arguments.splice(1, arguments.length-1);
		switch (theType) {
			//
			//	// Button
			//
			case "button" :
				//theName
				var theName:String = theParams[0];
				var ButtonWidth:Number = 100;
				var ButtonHeight:Number = 30;
				container.canvas.createEmptyMovieClip (theName, canvasDepth);
				container.canvas.createTextField (theName + "_txt", canvasDepth + 1, (finalboxWidth - ButtonWidth) / 2, finalboxHeight + gap + 5, ButtonWidth, 20);
				container.canvas[theName + "_txt"].setNewTextFormat (windowFormat);
				container.canvas[theName + "_txt"].selectable = false;
				container.canvas[theName + "_txt"].text = theName;
				canvasDepth += 2;
				shapes.createShape ("rectangle", container.canvas[theName], (finalboxWidth - ButtonWidth) / 2, finalboxHeight + gap, ButtonWidth, ButtonHeight, 5, white, 100, false, true, 1, black);
				setEvents (container.canvas[theName], ButtonWidth, ButtonHeight, finalboxWidth, finalboxHeight);
				finalboxHeight += ButtonHeight + 2 * gap;
				break;
			//
			//	// Text
			//
			case "text" :
				//theName, theString
				var theName:String = theParams[0];
				var theString:String = theParams[1]
				container.canvas.createEmptyMovieClip (theName, canvasDepth);
				container.canvas.createTextField (theName + "_txt", canvasDepth + 1, 5, finalboxHeight + gap + 5, finalboxWidth - 10, 10);
				container.canvas[theName + "_txt"].setNewTextFormat (windowFormat);
				container.canvas[theName + "_txt"].selectable = false;
				container.canvas[theName + "_txt"].wordWrap = true;
				container.canvas[theName + "_txt"].autoSize = true;
				container.canvas[theName + "_txt"].text = theString;
				canvasDepth += 2;
				finalboxHeight += container.canvas[theName + "_txt"]._height + gap + 5;
				break;
			//
			//	// trace
			//
			case "trace" :
				//text, colour | applyFormatting [isCentered, fontSize, colour]
				var text:Object = theParams[0];
				var params:Array = theParams[1];
				var applyFormatting:Boolean;
				var colour:Number;
				var isCentered:Boolean;
				var fontSize:Number;
				if (typeof params[0] == "number")
				{
					colour = params[0];
				}
				else
				{
					applyFormatting = params[0];
					isCentered = params[1];
					fontSize = params[2];
					colour = params[3];
				}
				if (windows.initialTrace)
				{
					windows.initialTrace = false
					container.canvas.createEmptyMovieClip ("tracer", canvasDepth);
					container.canvas.tracer._x = 0;
					container.canvas.tracer._y = 0;
					container.canvas.tracer.createTextField ("tracer_txt", canvasDepth + 1, 5, 5, fixedWidth - 50, fixedHeight - 2 * gap);
					container.canvas.tracer.tracer_txt.setNewTextFormat (traceFormat);
					container.canvas.tracer.tracer_txt.autoSize = true;
					container.canvas.tracer.tracer_txt.wordWrap = true;
					container.canvas.tracer.tracer_txt.html = true;
					container.createEmptyMovieClip ("scroller", canvasDepth + 2);
					container.scroller.createEmptyMovieClip ("base", canvasDepth + 3);
					container.scroller.createEmptyMovieClip ("grip", canvasDepth + 4);
					container.canvas.tracer.tracer_txt.htmlText = logger;
					addItem ("scroller");
				}
				else
				{
					if (applyFormatting == undefined && colour == undefined)
					{
						logger += "<font color='#000000'>" + text + "</font>\n";
					}
					else if (applyFormatting == undefined && colour != undefined)
					{
						logger += "<font color='#" + colour.toString(16) + "'>" + text + "</font>\n";
					}
					else if (applyFormatting == true)
					{
						var style:String = "";
						var ender:String = "";
						if (isCentered) { style += "<p align=\"center\">"; ender = "</p>" + ender};
						if (fontSize != undefined)
						{
							style += "<font size='" + fontSize + "' ";
							if (colour != undefined)
							{
								style += "color='" + "#" + colour.toString(16) + "'>";
							}
							else
							{
								style += ">";
							}
							ender = "</font>" + ender;
						}
						logger += style + text + ender + "\n";
					}
					container.canvas.tracer.tracer_txt.htmlText = logger;
					addItem ("scroller");
				}
				break;
			//
			//	// Scroller
			//
			case "scroller" :
				//no params
				if (container.canvas.tracer._height > (fixedHeight - 10))
				{
					gripHeight = ((fixedHeight - 10) / container.canvas.tracer._height) * ((fixedHeight - 10) - (2 * gap));
				}
				else
				{
					gripHeight = fixedHeight - 10;
				}
				shapes.createControl ("scroller", container.scroller, container.canvas.tracer, -fixedHeight / 2 + 5, fixedWidth / 2 - 5, fixedHeight - 10, gripHeight, 30, container.canvas.tracer._height + radius + gap, fixedHeight, true);
				container.scroller.grip._y = (fixedHeight - 10) - gripHeight;
				container.canvas.tracer._y = 5 + (fixedHeight - container.canvas.tracer._height - radius - gap) * (container.scroller.grip._y / ((fixedHeight - 10) - gripHeight));
				break;
			//
			//	// CheckBox
			//
			case "checkbox" :
				//theName:String, initialState:String
				var theName:String = theParams[0];
				var initialState:String = theParams[1];
				shapes.createImageHolder (10, finalboxHeight + gap, canvasDepth, container.canvas, theName, "checkbox", initialState);
				container.canvas.createTextField (theName + "_txt", canvasDepth + 1, 30, finalboxHeight + gap, finalboxWidth - 16 - 2 * gap, 20);
				container.canvas[theName + "_txt"].setNewTextFormat (settingsFormat);
				container.canvas[theName + "_txt"].selectable = false;
				container.canvas[theName + "_txt"].text = theName;
				canvasDepth += 2;
				finalboxHeight += 16 + 2 * gap;
				break;
			}
	}
	//
	//////////////// EDIT WINDOW
	//
	public function editItem(theType:String)
	{
		var theParams:Array = arguments.splice(1, arguments.length-1);
		switch (theType) {
			//
			//	// takeScroller
			//
			case "takeSCroller" :
				container.canvas.tracer.tracer_txt.text = "";
				delete container.canvas.tracer.tracer_txt;
				container.scroller.grip.clear ();
				container.scroller.base.clear ();
				delete container.scroller;
				break;
			case "text" :
				var theName:String = theParams[0];
				var theString:String = theParams[1];
				container.canvas[theName + "_txt"].text = theString;
				break;
		}
	}
	//
	//////////////// RANDOM
	//
	public function setEvents (mc:MovieClip, ButtonWidth:Number, ButtonHeight:Number, finalboxWidth:Number, finalboxHeight:Number)
	{
		var theBlue:Number = blue;
		var theGap:Number = gap;
		var theBlack:Number = black;
		var theWhite:Number = white;
		mc.onRollOver = function ()
		{
			shapes.createShape ("rectangle", this, (finalboxWidth - ButtonWidth) / 2, finalboxHeight + theGap, ButtonWidth, ButtonHeight, 5, theBlue, 20, false, true, 1, theBlack);
		};
		mc.onRollOut = function ()
		{
			shapes.createShape ("rectangle", this, (finalboxWidth - ButtonWidth) / 2, finalboxHeight + theGap, ButtonWidth, ButtonHeight, 5, theWhite, 100, false, true, 1, theBlack);
		};
	}
	static function setbaseDepth (__depth:Number):Number
	{
		base.trace(baseDepth, orange);
		baseDepth = __depth;
		return neededDepths;
	}
}
