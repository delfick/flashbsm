import objects.*;
class base extends arrays
{
	//
	//text
	//
	static var textFormat:TextFormat;
	static var DescriptionText:TextFormat;
	static var pluginFormat:TextFormat;
	static var sortText:TextFormat;
	static var sortHeaderFormat:TextFormat;
	static var tabFormat:TextFormat;
	static var testFormat:TextFormat;
	static var settingsFormat:TextFormat;
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
	static var initialIndex:Number;
	static var settingsAreaHeight:Number;
	static var settingsAreaY:Number;
	static var gripHeight:Number;
	static var tabX:Number;
	static var pluginDescriptionImageX:Number;
	static var pluginDescriptionImageY:Number;
	static var pluginDescriptionImageWidth:Number;
	static var pluginDescriptionImageHeight:Number;
	var descriptionWidth:Number;
	var settingsWidth:Number;
	var helperWidth:Number;
	static var funcBarWidth:Number;
	static var settingsHeight:Number;
	var sideHeight:Number;
	static var sideY:Number;
	var descriptionY:Number;
	var settingsY:Number;
	var helperY:Number;
	static var funcBarY:Number;
	static var sideX:Number;
	var descriptionX:Number;
	var settingsX:Number;
	var helperX:Number;
	static var funcBarX:Number;
	var pluginDescriptionX:Number;
	var pluginDescriptionWidth:Number;
	static var pluginDescriptionY:Number;
	public static function trace (text:Object, type:String)
	{
		var lc:LocalConnection = new LocalConnection ();
		switch (type)
		{
		case "important" :
			lc.send ('importantTrace', 'tracer', text);
			break;
		default :
			lc.send ('tracelog', 'tracer', text);
		}
	}
	public static function createTextFormats ()
	{
		textFormat = new TextFormat ();
		textFormat.font = "Verdana";
		textFormat.size = 12;
		textFormat.align = "center";
		textFormat.bold = true;
		pluginFormat = new TextFormat ();
		pluginFormat.font = "Verdana";
		pluginFormat.size = 9;
		pluginFormat.align = "left";
		pluginFormat.bold = true;
		DescriptionText = new TextFormat ();
		DescriptionText.font = "Verdana";
		DescriptionText.size = 12;
		sortText = new TextFormat ();
		sortText.font = "Verdana";
		sortText.size = 12;
		sortText.bold = true;
		sortHeaderFormat = new TextFormat ();
		sortHeaderFormat.font = "Verdana";
		sortHeaderFormat.size = 20;
		sortHeaderFormat.bold = true;
		tabFormat = new TextFormat ();
		tabFormat.font = "Verdana";
		tabFormat.size = 10;
		tabFormat.bold = true;
		tabFormat.align = "center";
		testFormat = new TextFormat ();
		testFormat.font = "Verdana";
		testFormat.size = 20;
		testFormat.align = "center";
		testFormat.bold = true;
		settingsFormat = new TextFormat ();
		settingsFormat.font = "Verdana";
		settingsFormat.size = 10;
		settingsFormat.align = "left";
		settingsFormat.bold = true;
	}
}
