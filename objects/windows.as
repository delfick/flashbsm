import objects.*;
class objects.windows extends objects.shapes
{
	public var finalboxHeight:Number = 0;
	public var finalboxWidth:Number = 300;
	public var fixedX:Number = 0;
	public var fixedY:Number = 0;
	public var fixedWidth:Number = 0;
	public var fixedHeight:Number = 0;
	private var boxHeight:Number;
	private var boxWidth:Number;
	private var boxX:Number;
	private var boxY:Number;
	private var isDone:Boolean = true;
	private var isThere:Boolean = true;
	private var Int:Number;
	public var container:MovieClip;
	private var speed:Number = 0.2;
	public var radius:Number = 10;
	private var canvasDepth:Number = 10;
	static var baseDepth:Number = 4500;
	static var neededDepths:Number = 200;
	static var count:Number = 0;
	static var stageHeight:Number = Stage.height;
	static var stageWidth:Number = Stage.width;
	private var finalX:Number;
	private var finalY:Number;
	public var logger:Object = "";
	public function windows ()
	{
		count++;
		stageHeight = base.stageHeight;
		stageWidth = base.stageWidth;
		createClips ();
	}
	public function resizeBox (finalWidth:Number, finalHeight:Number, doNow:Boolean)
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
				createRectangle (container.base, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, 1, boxHeight > radius ? radius : boxHeight, black, white, 100);
				createRectangle (container.mask, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, 1, boxHeight > radius ? radius : boxHeight, black, white, 100);
			}
			else
			{
				boxWidth = finalWidth;
				boxHeight = finalHeight;
				isDone = true;
				createRectangle (container.base, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, 1, boxHeight > radius ? radius : boxHeight, black, white, 100);
				createRectangle (container.mask, -(boxWidth / 2), -(boxHeight / 2), boxWidth, boxHeight, 1, boxHeight > radius ? radius : boxHeight, black, white, 100);
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
				clearInterval (Int);
			}
		}
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
	public function openWindow (doNow:Boolean)
	{
		clearInterval (Int);
		isDone = false;
		isThere = false;
		container.theShadow.clear ();
		if (fixedHeight != 0)
		{
			finalboxWidth = fixedWidth;
		}
		if (fixedWidth != 0)
		{
			finalboxHeight = fixedHeight;
		}
		container.canvas._x = -(finalboxWidth / 2);
		container.canvas._y = -(finalboxHeight / 2);
		createNoLineRectangle (container.theShadow, -(Stage.width / 2), -(Stage.height / 2), Stage.width + 20, Stage.height + 20, 1, 0, black, black, 20);
		Int = setInterval (EventDelegate.create (this, resizeBox), 10, finalboxWidth, finalboxHeight, doNow);
	}
	public function destroyWindow ()
	{
		clearInterval (Int);
		isDone = false;
		isThere = false;
		Int = setInterval (EventDelegate.create (this, resizeBox), 10, 0, 0, true);
	}
	public function destroyScroller ()
	{
		container.canvas.tracer.tracer_txt.text = "";
		delete container.canvas.tracer.tracer_txt;
		container.scroller.grip.clear ();
		container.scroller.base.clear ();
		delete container.scroller;
	}
	public function closeWindow ()
	{
		clearInterval (Int);
		isDone = false;
		isThere = false;
		Int = setInterval (EventDelegate.create (this, resizeBox), 10, 0, 0, false);
	}
	static function setbaseDepth (__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	public function addButton (theName:String)
	{
		var ButtonWidth:Number = 100;
		var ButtonHeight:Number = 30;
		container.canvas.createEmptyMovieClip (theName, canvasDepth);
		container.canvas.createTextField (theName + "_txt", canvasDepth + 1, (finalboxWidth - ButtonWidth) / 2, finalboxHeight + gap + 5, ButtonWidth, 20);
		container.canvas[theName + "_txt"].setNewTextFormat (textFormat);
		container.canvas[theName + "_txt"].selectable = false;
		container.canvas[theName + "_txt"].text = theName;
		canvasDepth += 2;
		createRectangle (container.canvas[theName], (finalboxWidth - ButtonWidth) / 2, finalboxHeight + gap, ButtonWidth, ButtonHeight, 1, 5, black, white, 100);
		setEvents (container.canvas[theName], ButtonWidth, ButtonHeight, finalboxWidth, finalboxHeight);
		finalboxHeight += ButtonHeight + 2 * gap;
	}
	public function addText (theName:String, theString:String)
	{
		container.canvas.createEmptyMovieClip (theName, canvasDepth);
		container.canvas.createTextField (theName + "_txt", canvasDepth + 1, 5, finalboxHeight + gap + 5, finalboxWidth - 10, 10);
		container.canvas[theName + "_txt"].setNewTextFormat (settingsFormat);
		container.canvas[theName + "_txt"].selectable = false;
		container.canvas[theName + "_txt"].wordWrap = true;
		container.canvas[theName + "_txt"].autoSize = true;
		container.canvas[theName + "_txt"].text = theString;
		canvasDepth += 2;
		finalboxHeight += container.canvas[theName + "_txt"]._height + gap + 5;
	}
	public function addTrace (text:Object, initial:Boolean)
	{
		if (initial)
		{
			container.canvas.createEmptyMovieClip ("tracer", canvasDepth);
			container.canvas.tracer._x = 0;
			container.canvas.tracer._y = 0;
			container.canvas.tracer.createTextField ("tracer_txt", canvasDepth + 1, 5, 5, fixedWidth - 50, fixedHeight - 2 * gap);
			var traceFormat:TextFormat;
			traceFormat = new TextFormat ();
			traceFormat.font = "Verdana";
			traceFormat.size = 12;
			traceFormat.align = "left";
			traceFormat.bold = true;
			container.canvas.tracer.tracer_txt.setNewTextFormat (traceFormat);
			container.canvas.tracer.tracer_txt.autoSize = true;
			container.canvas.tracer.tracer_txt.wordWrap = true;
			container.createEmptyMovieClip ("scroller", canvasDepth + 2);
			container.scroller.createEmptyMovieClip ("base", canvasDepth + 3);
			container.scroller.createEmptyMovieClip ("grip", canvasDepth + 4);
			container.canvas.tracer.tracer_txt.text = logger;
			updateScroller ();
		}
		else
		{
			logger += text + "\n";
			container.canvas.tracer.tracer_txt.text = logger;
			updateScroller ();
		}
	}
	public function updateScroller ()
	{
		container.canvas.tracer.tracer_txt._width = fixedWidth - 50;
		if (container.canvas.tracer._height > (fixedHeight - 10))
		{
			gripHeight = ((fixedHeight - 10) / container.canvas.tracer._height) * ((fixedHeight - 10) - (2 * gap));
		}
		else
		{
			gripHeight = fixedHeight - 10;
		}
		shapes.createScroller (container.scroller, container.canvas.tracer, -fixedHeight / 2 + 5, fixedWidth / 2 - 5, fixedHeight - 10, gripHeight, 30, container.canvas.tracer._height + radius + gap, fixedHeight, true);
		container.scroller.grip._y = (fixedHeight - 10) - gripHeight;
		container.canvas.tracer._y = 5 + (fixedHeight - container.canvas.tracer._height - radius - gap) * (container.scroller.grip._y / ((fixedHeight - 10) - gripHeight));
	}
	public function setEvents (mc:MovieClip, ButtonWidth:Number, ButtonHeight:Number, finalboxWidth:Number, finalboxHeight:Number)
	{
		var gap:Number = base.gap;
		var black:Number = base.black;
		var blue:Number = base.blue;
		var white:Number = base.white;
		mc.onRollOver = function ()
		{
			shapes.createRectangle (this, (finalboxWidth - ButtonWidth) / 2, finalboxHeight + gap, ButtonWidth, ButtonHeight, 1, 5, black, blue, 20);
		};
		mc.onRollOut = function ()
		{
			shapes.createRectangle (this, (finalboxWidth - ButtonWidth) / 2, finalboxHeight + gap, ButtonWidth, ButtonHeight, 1, 5, black, white, 100);
		};
	}
	public function addCheckBox (theName:String, initialState:String)
	{
		createImageHolder (10, finalboxHeight + gap, canvasDepth, container.canvas, theName, "checkbox", initialState);
		container.canvas.createTextField (theName + "_txt", canvasDepth + 1, 30, finalboxHeight + gap, finalboxWidth - 16 - 2 * gap, 20);
		container.canvas[theName + "_txt"].setNewTextFormat (settingsFormat);
		container.canvas[theName + "_txt"].selectable = false;
		container.canvas[theName + "_txt"].text = theName;
		canvasDepth += 2;
		finalboxHeight += 16 + 2 * gap;
	}
}
