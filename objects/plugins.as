import objects.*;
class objects.plugins extends objects.shapes
{
	var baseDepth:Number;
	var neededDepths:Number = 1;
	public static var enabledCount:Number;
	public static var disabledCount:Number;
	private var container:MovieClip;
	private var num:Number;
	private var pluginName:String;
	public var isEnabled:Boolean;
	public var groupNum:Number;
	private var pluginNum:Number;
	public var iconName:String;
	public var pluginNumAlpha:Number;
	static var pluginHeight:Number = 40;
	static var pluginWidth:Number;
	static var boxHeight:Number;
	static var boxWidth:Number;
	static var boxX:Number;
	static var boxY:Number;
	static var speed:Number = 0.1;
	static var slowSpeed:Number = 0.1;
	static var fastSpeed:Number = 0.5;
	static var sortSpeed:Number = 0.4;
	static var horizGridNumber:Number = 0;
	static var vertGridNumber:Number = 0;
	static var initialSort:Boolean = false;
	static var numberOfTabs:Number = 0;
	static var chosenTab:Number = 0;
	static var iconLoad:LoadVars = new LoadVars ();
	private var Int:Number;
	private var action:String;
	private var isDone:Boolean = true;
	private var finaly:Number;
	private var finalx:Number;
	private var gridPosX:Number;
	private var gridPosY:Number;
	public var tabNum:Number;
	var isSelected:Boolean = false;
	private var colourInt:Number;
	private var radius:Number = 0;
	static var selectedPlugin:Number = 0;
	static var currentPlugin:Object;
	public var doItNow:Boolean = false;
	static var horizGridNumberYesEnable:Number = 0;
	static var vertGridNumberYesEnable:Number = 0;
	static var horizGridNumberNoEnable:Number = 0;
	static var vertGridNumberNoEnable:Number = 0;
	private var gridPosXEnable:Number = 0;
	private var gridPosYEnable:Number = 0;
	private var groupOrderNum:Number;
	public var pluginIndex:Number;
	public var optionsTabsArray:Array = new Array ();
	static var count:Number = 0;
	public var descriptionText:String;
	static var deleteMe:Number = 0;
	static var pluginLoader:LoadVars;
	public function plugins (__name:String, __groupNum:Number, __pluginNum:Number)
	{
		var thisClass:Object = this;
		tabNum = 6;
		pluginNum = __pluginNum;
		createGroupGrid ();
		pluginName = __name;
		groupNum = __groupNum;
		createNormalGrid ();
	}
	function createNormalGrid ()
	{
		gridPosX = horizGridNumber;
		gridPosY = vertGridNumber;
		if (vertGridNumber > vertGridSize)
		{
			vertGridNumber = 0;
			horizGridNumber++;
		}
		else
		{
			vertGridNumber++;
		}
	}
	function createGroupGrid ()
	{
		groupOrderNum = groupOrderArray[groupNum];
		groupOrderArray[groupNum]++;
	}
	function createEnableGrid ()
	{
		if (isEnabled == true)
		{
			gridPosXEnable = horizGridNumberYesEnable;
			gridPosYEnable = vertGridNumberYesEnable;
			if (vertGridNumberYesEnable > vertGridSize)
			{
				vertGridNumberYesEnable = 0;
				horizGridNumberYesEnable++;
			}
			else
			{
				vertGridNumberYesEnable++;
			}
		}
		else
		{
			gridPosXEnable = horizGridNumberNoEnable;
			gridPosYEnable = vertGridNumberNoEnable;
			if (vertGridNumberNoEnable > vertGridSize)
			{
				vertGridNumberNoEnable = 0;
				horizGridNumberNoEnable++;
			}
			else
			{
				vertGridNumberNoEnable++;
			}
		}
	}
	function setbaseDepth (__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	static function createClips ()
	{
		pluginWidth = sideWidth;
		boxHeight = 33;
		boxWidth = pluginWidth / 1.1;
		boxX = (pluginWidth - boxWidth) / 2;
		boxY = (pluginHeight - boxHeight) / 2;
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			var plName:String = pluginObject[pluginArray[i]].Name;
			var plDepth:Number = pluginObject[pluginArray[i]].Depth;
			_root.createEmptyMovieClip ("plugin_" + plName, plDepth);
			pluginObject[pluginArray[i]].createContainer ();
		}
	}
	function reColour (__action:String)
	{
		if (__action == "normal")
		{
			createShape (white, 26, black);
		}
		else if (__action == "selected")
		{
			createShape (red, 26, black);
		}
		else if (__action == "hover")
		{
			createShape (blue, 26, black);
		}
	}
	private function setEvents (group:Number, plugin:Number, pluginIndex:Number)
	{
		container.base.onRollOver = function ()
		{
			plugins.pluginRoll (group, plugin, pluginIndex);
		};
		container.base.onRelease = function ()
		{
			plugins.pluginPress (group, plugin, pluginIndex);
		};
		container.base.onRollOut = function ()
		{
			plugins.pluginRollOut (group, plugin, pluginIndex);
		};
		container.checkBox.onRelease = function ()
		{

			var nextPlugin:Object = arrays.pluginObject[arrays.pluginArrayAlpha[pluginIndex]];
			plugins.pluginLoader = new LoadVars ();
			plugins.pluginLoader.onLoad = function(success:Boolean)
			{
				arrays.editWindow("It was"+(success == true? " ":" not ")+"successful")
			}
			if (nextPlugin.isEnabled == true)
			{
				plugins.pluginLoader.load ("http://localhost:8899/?method=unloadPlugin&plugin=\"" + nextPlugin.Name + "\"");
				arrays.editWindow ("Unloading " + nextPlugin.Name);
			}
			else
			{
				plugins.pluginLoader.load ("http://localhost:8899/?method=loadPlugin&plugin=\"" + nextPlugin.Name + "\"");
				arrays.editWindow ("Loading " + nextPlugin.Name);
			}
			var thePlugin:Object = arrays.pluginObject[arrays.pl_groupArray[group][plugin]];
			if (thePlugin.isEnabled == true)
			{
				plugins.determineAbled (false, group, plugin);
			}
			else
			{
				plugins.determineAbled (true, group, plugin);
			}
			if (arrays.funcBarObject.ShowAll.active == true)
			{
				plugins.doSort (true);
			}
		};
	}
	static function pluginRoll (group:Number, plugin:Number, pluginIndex:Number)
	{
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			var nextPlugin:Object = pluginObject[pluginArray[i]];
			if (nextPlugin.isSelected == true)
			{
				nextPlugin.colourCheck ("selected");
			}
			else
			{
				if (nextPlugin.pluginIndex == pluginIndex)
				{
					nextPlugin.reColour ("hover");
				}
				else
				{
					nextPlugin.reColour ("normal");
				}
			}
		}
	}
	static function pluginPress (group:Number, plugin:Number, pluginIndex:Number)
	{
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			var nextPlugin:Object = pluginObject[pluginArray[i]];
			if (nextPlugin.pluginIndex == pluginIndex)
			{
				selectedPlugin = group;
				currentPlugin = nextPlugin;
				var theName:String = currentPlugin.Name.toLowerCase ();
				iconLoad.load ("images/icons/plugin-" + currentPlugin.iconName + ".png");
				iconLoad.onLoad = function (success:Boolean)
				{
					if (success)
					{
						arrays.stageObject.theStage.clip.pluginDescriptionImage.loadMovie ("images/icons/plugin-" + plugins.currentPlugin.iconName + ".png");
					}
					else
					{
						arrays.stageObject.theStage.clip.pluginDescriptionImage.loadMovie ("images/icons/plugin-unknown.png");
					}
				};
				nextPlugin.isSelected = true;
				nextPlugin.reColour ("selected");
				menuObject[groupArray[group]].changeAction ("dissapear");
				groupObject[groupArray[group]].reColour ("pressed");
				groups.selectedGroup = group;
				plugins.groupPressSort (group);
				plugins.chosenTab = 0;
				stageObject.theStage.createSettingsArea ();
				stageObject.theStage.clip.pluginDescription.text = groupArray[group] + " --> " + plugins.currentPlugin.pluginName + " --> " + plugins.currentPlugin.descriptionText;
				if (funcBarObject.ShowAll.active == true)
				{
					funcBarObject.ShowAll.inactivePress ();
				}
			}
			else
			{
				nextPlugin.isSelected = false;
				nextPlugin.reColour ("normal");
			}
			if (nextPlugin.groupNum != group)
			{
				groupObject[groupArray[i]].reColour ("rollOut");
				menuObject[groupArray[i]].changeAction ("dissapear");
			}
		}
	}
	static function pluginRollOut (group:Number, plugin:Number, pluginIndex:Number)
	{
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			var nextPlugin:Object = pluginObject[pluginArray[i]];
			if (nextPlugin.isSelected == true)
			{
				nextPlugin.colourCheck ("selected");
			}
			else
			{
				nextPlugin.reColour ("normal");
			}
		}
	}
	function setAttributes ()
	{
		pluginName = arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[pluginIndex].childNodes[0].attributes.short;
		iconName = arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[pluginIndex].childNodes[0].attributes.icon;
		descriptionText = arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[pluginIndex].childNodes[2].firstChild.nodeValue;
		optionsTabsArray = new Array ();
		for (var i:Number = 0; i < arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[pluginIndex].childNodes[3].childNodes.length; i++)
		{
			optionsTabsArray[i] = arrays.ArraysXmlData.firstChild.childNodes[1].childNodes[pluginIndex].childNodes[3].childNodes[i].attributes.name;
		}
	}
	function createContainer ()
	{
		if (activePlugins != undefined)
		{
			for (var i:Number = 0; i < activePlugins.length; i++)
			{
				if (activePlugins[i] == iconName)
				{
					isEnabled = true;
				}
			}
			if (isEnabled == undefined)
			{
				isEnabled = false;
			}
		}
		else
		{
			if (Math.round (Math.random (100)) == 1)
			{
				isEnabled = true;
			}
			else
			{
				isEnabled = false;
			}
		}
		if (iconName == "core")
		{
			isEnabled = true;
		}
		container = _root["plugin_" + pluginName];
		container.createEmptyMovieClip ("base", 2);
		container.createEmptyMovieClip ("checkBox", 3);
		container.checkBox.createEmptyMovieClip ("inactiveState", 4);
		container.checkBox.inactiveState.createEmptyMovieClip ("pic", 5);
		container.checkBox.inactiveState.pic.loadMovie ("images/checkbox/inactive.png");
		container.checkBox.createEmptyMovieClip ("onState", 6);
		container.checkBox.onState.createEmptyMovieClip ("pic", 7);
		container.checkBox.onState.pic.loadMovie ("images/checkbox/on.png");
		container.checkBox.createEmptyMovieClip ("offState", 8);
		container.checkBox.offState.createEmptyMovieClip ("pic", 9);
		container.checkBox.offState.pic.loadMovie ("images/checkbox/off.png");
		container.checkBox._x = boxX + boxWidth - 18;
		container.checkBox._y = boxY + boxHeight - 18;
		createRectangle (container.base, boxX, boxY, boxWidth, boxHeight, 1, radius, black, white, 20);
		container.createTextField ("label_txt", 0, boxX + 5, 10, pluginWidth - 30, pluginHeight);
		container.label_txt.setNewTextFormat (pluginFormat);
		container.label_txt.multiline = true;
		container.label_txt.wordWrap = true;
		container.label_txt.text = pluginName;
		if (container.label_txt.textHeight > 20)
		{
			container.label_txt._y -= 4;
		}
		container._x = pluginHeight;
		container._y = pluginWidth;
		container.checkBox.offState.pic._visible = false;
		container.checkBox.onState.pic._visible = false;
		container.checkBox.inactiveState.pic._visible = false;
		if (isEnabled == true)
		{
			switchImage (container.checkBox, "on");
			enabledCount++;
			disabledCount--;
		}
		else
		{
			switchImage (container.checkBox, "off");
			disabledCount++;
			enabledCount--;
		}
		setEvents (groupNum, pluginNum, pluginIndex);
	}
	function createShape (fillColour:Number, fillAlpha:Number, textColour:Number)
	{
		createRectangle (container, boxX, boxY, boxWidth, boxHeight, 1, radius, black, fillColour, fillAlpha);
		container.label_txt.textColor = textColour;
	}
	function changeAction (__action:String)
	{
		action = __action;
		clearInterval (Int);
		isDone = false;
		Int = setInterval (EventDelegate.create (this, actionCheck), 10);
	}
	function actionCheck ()
	{
		if (isDone == false)
		{
			if (action != "dissapear")
			{
				switch (action)
				{
				case "pressed" :
					container._x = sideX;
					container._y = sideY + pluginHeight * pluginNum;
					isDone = true;
					break;
				case "roll" :
					finalx = container._x;
					finaly = menus.menuy + pluginHeight * pluginNum;
					break;
				case "rollOut" :
					finalx = container._x;
					finaly = menus.menuy - pluginHeight - 7.5;
					break;
				case "normalSort" :
					finalx = pluginHeight + gridPosX * pluginWidth;
					finaly = pluginHeight + gridPosY * pluginHeight;
					break;
				case "groupSort" :
					finalx = groups.groupGap * 2 + groups.groupSections * groupNum;
					finaly = topY + topHeight / 2 + pluginHeight + groupOrderNum * pluginHeight;
					break;
				case "enableYesSort" :
					finalx = pluginHeight + gridPosXEnable * pluginWidth;
					finaly = pluginHeight + gridPosYEnable * pluginHeight;
					break;
				case "enableNoSort" :
					finalx = stageWidth - pluginHeight - (gridPosXEnable + 1) * pluginWidth;
					//pluginHeight + (horizGridSize - gridPosXEnable) * pluginWidth;
					finaly = pluginHeight + gridPosYEnable * pluginHeight;
					break;
				}
				if (action != "pressed")
				{
					if (doItNow != true)
					{
						if (base.animated == true && initialSort == false)
						{
							if (Math.abs (container._x - finalx) > 1 || Math.abs (container._y - finaly) > 1)
							{
								//Move towards target
								container._x += (finalx - container._x) * speed;
								container._y += (finaly - container._y) * speed;
							}
							else
							{
								container._x = finalx;
								container._y = finaly;
								isDone = true;
							}
						}
						else
						{
							container._x = finalx;
							container._y = finaly;
							isDone = true;
						}
					}
					else
					{
						container._x = finalx;
						container._y = finaly;
						doItNow = false;
						isDone = true;
					}
				}
			}
			else
			{
				container._x = -pluginWidth;
				container._y = -pluginHeight;
				isDone = true;
			}
		}
		else
		{
			clearInterval (Int);
		}
	}
	public static function doSort (doAnimate:Boolean)
	{
		if (functionBar.searchIn == "plugins")
		{
			switch (functionBar.searchType)
			{
			case "normal" :
				stageObject.theStage.createNormalSort ();
				normalSort (doAnimate);
				break;
			case "group" :
				stageObject.theStage.createGroupSort ();
				groupSort (doAnimate);
				break;
			case "enable" :
				stageObject.theStage.createEnableSort ();
				enableSort (doAnimate);
				break;
			case "search" :
				searchSort (_level0.optionsPane.pane.input_txt.text, _level0.optionsPane.pane.input_txt.length, doAnimate);
				break;
			}
		}
		else
		{
		}
	}
	public static function hideSort (group:Number):Void
	{
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			pluginObject[pluginArray[i]].changeAction ("dissapear");
		}
	}
	public static function groupPressSort (group:Number):Void
	{
		for (var j:Number = 0; j < pl_groupArray.length; j++)
		{
			for (var i:Number = 0; i < pl_groupArray[j].length; i++)
			{
				if (j == group)
				{
					pluginObject[pl_groupArray[j][i]].changeAction ("pressed");
				}
				else
				{
					pluginObject[pl_groupArray[j][i]].changeAction ("dissapear");
				}
			}
		}
	}
	public static function groupRollSort (group:Number):Void
	{
		speed = slowSpeed;
		for (var j:Number = 0; j < pl_groupArray.length; j++)
		{
			for (var i:Number = 0; i < pl_groupArray[j].length; i++)
			{
				if (pluginObject[pl_groupArray[j][i]].action != "pressed")
				{
					if (j == group)
					{
						if (pluginObject[pl_groupArray[group][i]].action != "roll")
						{
							pluginObject[pl_groupArray[j][i]].container._x = menuObject[groupArray[j]].menux;
							pluginObject[pl_groupArray[j][i]].container._y = topY;
							pluginObject[pl_groupArray[j][i]].changeAction ("roll");
						}
					}
					else
					{
						pluginObject[pl_groupArray[j][i]].changeAction ("dissapear");
					}
				}
			}
		}
	}
	public static function searchSort (txt:String, num:Number, doAnimate:Boolean):Void
	{
		var thePlugins:Array = new Array ();
		horizGridNumberYesEnable = 0;
		vertGridNumberYesEnable = 0;
		horizGridNumberNoEnable = 0;
		vertGridNumberNoEnable = 0;
		horizGridNumber = 0;
		vertGridNumber = 0;
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			groupOrderArray[i] = 0;
		}
		speed = sortSpeed;
		if (functionBar.isAlphabetical == false)
		{
			arrays.createEnabledSort ();
			thePlugins = pluginArrayAlphaEnabled;
		}
		else
		{
			thePlugins = pluginArrayAlpha;
		}
		switch (functionBar.tempType)
		{
		case "normal" :
			stageObject.theStage.createNormalSort ();
			for (var i:Number = 0; i < thePlugins.length; i++)
			{
				var subs:String = thePlugins[i].substr (0, num);
				if (subs.toLowerCase () == txt.toLowerCase ())
				{
					pluginObject[thePlugins[i]].isDone = false;
					pluginObject[thePlugins[i]].createNormalGrid ();
					if (doAnimate == false)
					{
						pluginObject[thePlugins[i]].doItNow = true;
					}
					pluginObject[thePlugins[i]].changeAction ("normalSort");
				}
				else
				{
					pluginObject[thePlugins[i]].changeAction ("dissapear");
				}
			}
			break;
		case "group" :
			stageObject.theStage.createGroupSort ();
			for (var i:Number = 0; i < thePlugins.length; i++)
			{
				var subs:String = thePlugins[i].substr (0, num);
				if (subs.toLowerCase () == txt.toLowerCase ())
				{
					pluginObject[thePlugins[i]].isDone = false;
					pluginObject[thePlugins[i]].createGroupGrid ();
					if (doAnimate == false)
					{
						pluginObject[thePlugins[i]].doItNow = true;
					}
					pluginObject[thePlugins[i]].changeAction ("groupSort");
				}
				else
				{
					pluginObject[thePlugins[i]].changeAction ("dissapear");
				}
			}
			break;
		case "enable" :
			stageObject.theStage.createEnableSort ();
			for (var i:Number = 0; i < thePlugins.length; i++)
			{
				var subs:String = thePlugins[i].substr (0, num);
				if (subs.toLowerCase () == txt.toLowerCase ())
				{
					pluginObject[thePlugins[i]].isDone = false;
					pluginObject[thePlugins[i]].createEnableGrid ();
					if (doAnimate == false)
					{
						pluginObject[thePlugins[i]].doItNow = true;
					}
					if (pluginObject[thePlugins[i]].isEnabled == true)
					{
						pluginObject[thePlugins[i]].changeAction ("enableYesSort");
					}
					else
					{
						pluginObject[thePlugins[i]].changeAction ("enableNoSort");
					}
				}
				else
				{
					pluginObject[thePlugins[i]].changeAction ("dissapear");
				}
			}
			break;
		}
	}
	public static function normalSort (doAnimate:Boolean):Void
	{
		var thePlugins:Array = new Array ();
		horizGridNumber = 0;
		vertGridNumber = 0;
		stageObject.theStage.createNormalSort ();
		speed = sortSpeed;
		if (functionBar.isAlphabetical == false)
		{
			arrays.createGroupEnabledSort ();
			thePlugins = pluginNormalArray;
		}
		else
		{
			thePlugins = pluginArrayAlpha;
		}
		for (var i:Number = 0; i < thePlugins.length; i++)
		{
			pluginObject[thePlugins[i]].isDone = false;
			if (doAnimate == false)
			{
				pluginObject[thePlugins[i]].doItNow = true;
			}
			pluginObject[thePlugins[i]].createNormalGrid ();
			pluginObject[thePlugins[i]].changeAction ("normalSort");
		}
	}
	public static function groupSort (doAnimate:Boolean):Void
	{
		var thePlugins:Array = new Array ();
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			groupOrderArray[i] = 0;
		}
		stageObject.theStage.createGroupSort ();
		speed = sortSpeed;
		if (functionBar.isAlphabetical == false)
		{
			arrays.createEnabledSort ();
			thePlugins = pluginArrayAlphaEnabled;
		}
		else
		{
			thePlugins = pluginArrayAlpha;
		}
		for (var i:Number = 0; i < thePlugins.length; i++)
		{
			pluginObject[thePlugins[i]].isDone = false;
			if (doAnimate == false)
			{
				pluginObject[thePlugins[i]].doItNow = true;
			}
			pluginObject[thePlugins[i]].createGroupGrid ();
			pluginObject[thePlugins[i]].changeAction ("groupSort");
		}
	}
	public static function enableSort (doAnimate:Boolean):Void
	{
		arrays.createEnabledSort ();
		stageObject.theStage.createEnableSort ();
		horizGridNumberYesEnable = 0;
		vertGridNumberYesEnable = 0;
		horizGridNumberNoEnable = 0;
		vertGridNumberNoEnable = 0;
		if (functionBar.isAlphabetical == false)
		{
			for (var i:Number = 0; i < pluginArray.length; i++)
			{
				pluginObject[pluginArray[i]].createEnableGrid ();
			}
		}
		else
		{
			for (var i:Number = 0; i < pluginArrayAlpha.length; i++)
			{
				pluginObject[pluginArrayAlpha[i]].createEnableGrid ();
			}
		}
		speed = sortSpeed;
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			pluginObject[pluginArray[i]].isDone = false;
			if (doAnimate == false)
			{
				pluginObject[pluginArray[i]].doItNow = true;
			}
			if (pluginObject[pluginArray[i]].isEnabled == true)
			{
				pluginObject[pluginArray[i]].changeAction ("enableYesSort");
			}
			else
			{
				pluginObject[pluginArray[i]].changeAction ("enableNoSort");
			}
		}
	}
	public static function groupRollOutSort (group:Number):Void
	{
		speed = fastSpeed;
		for (var j:Number = 0; j < pl_groupArray.length; j++)
		{
			for (var i:Number = 0; i < pl_groupArray[j].length; i++)
			{
				if (pluginObject[pl_groupArray[j][i]].action != "pressed")
				{
					if (j == group)
					{
						pluginObject[pl_groupArray[j][i]].changeAction ("rollOut");
					}
					else
					{
						pluginObject[pl_groupArray[j][i]].changeAction ("dissapear");
					}
				}
			}
		}
	}
	public static function determineAbled (option:Boolean, group:Number, plugin:Number)
	{
		var thePlugin:Object = pluginObject[pl_groupArray[group][plugin]];
		if (thePlugin.isEnabled != option)
		{
			thePlugin.isEnabled = option;
			if (option == true)
			{
				switchImage (thePlugin.container.checkBox, "on");
				enabledCount++;
				disabledCount--;
			}
			else
			{
				switchImage (thePlugin.container.checkBox, "off");
				disabledCount++;
				enabledCount--;
			}
		}
	}
	public static function determineAbledByIndex (option:Boolean, index:Number)
	{
		var thePlugin:Object = pluginObject[pluginArray[index]];
		if (thePlugin.isEnabled != option)
		{
			thePlugin.isEnabled = option;
			if (option == true)
			{
				switchImage (thePlugin.container.checkBox, "on");
				enabledCount++;
				disabledCount--;
			}
			else
			{
				switchImage (thePlugin.container.checkBox, "off");
				disabledCount++;
				enabledCount--;
			}
		}
	}
	function get Name ():String
	{
		return pluginName;
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
}
