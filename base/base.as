import base.*;
import ui.*;
class base.base extends arrays
{
	//
	//text
	//
	static var descriptionFormat:TextFormat;
	static var tabFormat:TextFormat;
	static var settingsFormat:TextFormat;
	static var pluginFormat:TextFormat;
	static var groupFormat:TextFormat;
	static var buttonFormat:TextFormat;
	static var sortHeaderFormat:TextFormat;
	static var sortOptionsFormat:TextFormat;
	static var windowFormat:TextFormat;
	static var traceFormat:TextFormat;
	//
	//colour
	//
	static var blue:Number = 1287332;
	static var white:Number = 16777215;
	static var black:Number = 000000;
	static var orange:Number = 13191700;
	static var red:Number = 11210768;
	static var green:Number = 3975750;
	static var grey:Number = 9803157;
	//
	//grid
	//
	static var horizGridSize:Number = 9;
	static var vertGridSize:Number = 13;
	//
	//constant
	//
	static var animated:Boolean = true;
	static var topX:Number = 2.5;
	static var topY:Number = 2.5;
	static var gap:Number = 10;
	static var stageHeight:Number = Stage.height - 7.5;
	static var stageWidth:Number = Stage.width - 7.5;
	static var sideWidth:Number = 110;
	static var topHeight:Number = 60;
	static var descriptionHeight:Number = 50;
	static var helperHeight:Number = 60;
	static var funcBarHeight:Number = 60;
	static var pluginDescriptionHeight:Number = 20;
	static var tabHeight:Number = 20;
	static var tabWidth:Number = 100;
	static var scrollerWidth:Number = 30;
	//
	//variable
	//
	static var readyYet:Boolean = false;
	static var initialIndex:Number;
	////////Stage variables
	//	//	x
	static var tabX:Number;
	static var sideX:Number;
	static var descriptionX:Number;
	static var settingsX:Number;
	static var helperX:Number;
	static var funcBarX:Number;
	static var pluginDescriptionX:Number;
	//	//  y
	static var sideY:Number;
	static var descriptionY:Number;
	static var settingsY:Number;
	static var helperY:Number;
	static var funcBarY:Number;
	static var pluginDescriptionY:Number;
	static var settingsAreaY:Number;
	//	//	width
	static var descriptionWidth:Number;
	static var settingsWidth:Number;
	static var helperWidth:Number;
	static var funcBarWidth:Number;
	static var pluginDescriptionWidth:Number;
	//	//	height
	static var gripHeight:Number;
	static var settingsAreaHeight:Number;
	static var settingsHeight:Number;
	static var sideHeight:Number;
	////////Plugins
	static var pluginDescriptionImageX:Number;
	static var pluginDescriptionImageY:Number;
	static var pluginDescriptionImageWidth:Number;
	static var pluginDescriptionImageHeight:Number;
	//
	//
	public static function trace (text:Object, colour:Number)
	{
		var lc:LocalConnection = new LocalConnection ();
		lc.send ('tracelog', 'tracer', text, colour);
	}
	public static function startPoint(__container:MovieClip, theType:String)
	{
		//Stuff for the stage
		Stage.scaleMode = "noScale";
		Stage.align = "cc";
		switch (theType)
		{
			case "flashbsm" :
				base.trace('***************NEXT TEST****************');
				createTextFormats ();
				//Finished setting up, now to make the arrays
				__container.theArrays = new arrays (__container);
				__container.theArrays.createArrays (0);
				break;
			case "tracer" :
				createTextFormats ();
				//Finished setting up, now to make the tracer
				__container.theTracer = new tracer (__container);
				break;
		}
	}
	public static function createTextFormats ()
	{
		//descriptionFormat
		//	group -> plugin -> description
		descriptionFormat = new TextFormat ();
		descriptionFormat.font = "Verdana";
		descriptionFormat.size = 12;
		//
		//
		//tabFormat
		//	The tabs seperating plugin settings
		tabFormat = new TextFormat ();
		tabFormat.font = "Verdana";
		tabFormat.size = 10;
		tabFormat.bold = true;
		tabFormat.align = "center";
		//
		//
		//settingsFormat
		//	font used for the actual settings themselves
		settingsFormat = new TextFormat ();
		settingsFormat.font = "Verdana";
		settingsFormat.size = 10;
		settingsFormat.align = "left";
		settingsFormat.bold = true;
		//
		//
		//pluginFormat
		//	plugin names on the plugin objects
		pluginFormat = new TextFormat ();
		pluginFormat.font = "Verdana";
		pluginFormat.size = 9;
		pluginFormat.align = "left";
		pluginFormat.bold = true;
		//
		//
		//groupFormat
		//	Group headings in normal layout
		groupFormat = new TextFormat ();
		groupFormat.font = "Verdana";
		groupFormat.size = 12;
		groupFormat.align = "center";
		groupFormat.bold = true;
		//
		//
		//buttonFormat
		//	buttons used in windows
		buttonFormat = new TextFormat ();
		buttonFormat.font = "Verdana";
		buttonFormat.size = 10;
		buttonFormat.align = "left";
		buttonFormat.bold = true;
		//
		//
		//sortHeaderFormat
		//	headings in showall layout
		sortHeaderFormat = new TextFormat ();
		sortHeaderFormat.font = "Verdana";
		sortHeaderFormat.size = 20;
		sortHeaderFormat.bold = true;
		//
		//
		//sortOptionsFormat
		//	font used on the settings panel that pops up in showall layout
		sortOptionsFormat = new TextFormat ();
		sortOptionsFormat.font = "Verdana";
		sortOptionsFormat.size = 12;
		sortOptionsFormat.bold = true;
		//
		//
		//windowFormat
		//	font used on text fields in windows
		windowFormat = new TextFormat ();
		windowFormat.font = "Verdana";
		windowFormat.size = 12;
		windowFormat.align = "center";
		//
		//
		//traceFormat
		//	font for tracer box
		traceFormat = new TextFormat ();
		traceFormat.font = "Verdana";
		traceFormat.size = 12;
		traceFormat.align = "left";
		traceFormat.bold = true;
		//
		//
	}
}
