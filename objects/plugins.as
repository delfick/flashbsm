import objects.*;
import base.*;
import ui.*;
import mx.utils.Delegate;
class objects.plugins extends base.base
{
	//common variables to all classes
	public var baseDepth:Number;
	public var neededDepths:Number = 100;
	private var container:MovieClip;
	private var interval:Number;
	//Dimensions/co-ords
	static var pluginHeight:Number = 40;
	static var pluginWidth:Number;
	static var boxHeight:Number;
	static var boxWidth:Number;
	static var boxX:Number;
	static var boxY:Number;
	private var radius:Number = 0;
	//movement
	private var finaly:Number;
	private var finalx:Number;
	private var gridPosX:Number;
	private var gridPosY:Number;
	//counts
	public static var enabledCount:Number;
	public static var disabledCount:Number;
	private var num:Number;
	static var count:Number = 0;
	//properties
	private var pluginName:String;
	private var colourInt:Number;
	public var isEnabled:Boolean;
	public var groupNum:Number;
	public var groupName:String;
	public var pluginNum:Number;
	public var iconName:String;
	public var pluginNumAlpha:Number;
	public var tabNum:Number;
	public var isSelected:Boolean = false;
	public var doItNow:Boolean = false;
	public var pluginIndex:Number;
	public var descriptionText:String;
	//properties common to all plugins
	static var speed:Number = 0.1;
	static var slowSpeed:Number = 0.1;
	static var fastSpeed:Number = 0.5;
	static var sortSpeed:Number = 0.4;
	static var horizGridNumber:Number = 0;
	static var vertGridNumber:Number = 0;
	static var selectedPlugin:Number = 0;
	private var groupOrderNum:Number;
	//random
	static var initialSort:Boolean = false;
	static var numberOfTabs:Number = 0;
	static var chosenTab:Number = 0;
	private var action:String;
	private var isDone:Boolean = true;
	static var currentPlugin:Object;
	static var hoveredPlugin:Object;
	static var horizGridNumberYesEnable:Number = 0;
	static var vertGridNumberYesEnable:Number = 0;
	static var horizGridNumberNoEnable:Number = 0;
	static var vertGridNumberNoEnable:Number = 0;
	private var gridPosXEnable:Number = 0;
	private var gridPosYEnable:Number = 0;
	//misc
	public var optionsTabsArray:Array = new Array ();
	static var pluginLoader:LoadVars;
	static var theWindow:Object;
	static var groupCount:Number = 0;
	static var gotInformation:Array = new Array();
	public var swappedContainer:String;
	public var firstContainerSwitch:Boolean = true;
	//
	//
	//

	public function plugins (__groupNum:Number, __pluginNum:Number)
	{
		pluginNum = __pluginNum;
		optionsTabsArray = ["test", "test2", "test3"];
		tabNum = 3;
		createGroupGrid ();
		groupNum = __groupNum;
		groupName = groupArray[groupNum];
		createNormalGrid ();
	}
	function createGroupGrid ()
	{
		groupOrderNum = groupOrderArray[groupNum];
		groupOrderArray[groupNum]++;
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
	//
	//
	function setbaseDepth (__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	static function createClips ()
	{
		plugins.theWindow = new ui.windows (400);
		plugins.theWindow.addItem ("text", "info", "...");
		plugins.theWindow.addItem ("button", "done");
		plugins.theWindow.container.canvas.done.onRelease = function ()
		{
			plugins.theWindow.closeWindow (false);
			arrays.theWindow.inactivePress ();
		};
		pluginWidth = sideWidth;
		boxHeight = 33;
		boxWidth = pluginWidth / 1.1;
		boxX = (pluginWidth - boxWidth) / 2;
		boxY = (pluginHeight - boxHeight) / 2;
		if (activePlugins != undefined)
		{
			for (var i:Number = 0; i < activePlugins.length; i++)
			{
				var nextPlugin:Object = pluginObject[iconToPluginName[activePlugins[i]]];
				if (nextPlugin.iconName.toString()==activePlugins[i].toString())
				{
					nextPlugin.isEnabled = true;
				}
			}
		}
		else
		{
			for (var i:Number = 0;i < pluginArray.length;i++)
			{
				var nextPlugin:Object = pluginObject[pluginArray[i]];
				if (Math.round (Math.random(100)) == 1)
				{
					nextPlugin.isEnabled = true;
				}
			}
		}
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			var nextPlugin:Object = pluginObject[pluginArray[i]];
			if (nextPlugin.isEnabled == undefined)
			{
				nextPlugin.isEnabled = false;
			}
			var plName:String = nextPlugin.pluginName;
			var plDepth:Number = nextPlugin.baseDepth + i;
			_root["normal_"+nextPlugin.groupName].createEmptyMovieClip ("plugin_" + plName, plDepth);
			pluginObject[pluginArray[i]].createContainer ();
		}
	}
	public function switchContainer(theType:String)
	{
		if (!firstContainerSwitch)
		{
			container._parent.swapDepths(_root[swappedContainer+"_"+groupName]);
		}
		swappedContainer = theType
		switch (theType)
		{
			case "normal" :
				container._parent.swapDepths(_root["normal_"+groupName]);
				break;
			case "sorter" :
				container._parent.swapDepths(_root["sorter_"+groupName]);
				break;
			case "menu" :
				container._parent.swapDepths(_root["menu_"+groupName]);
				break;
		}
		firstContainerSwitch = false;
	}
	function createContainer (theType:String)
	{
		if (iconName.toString() == "core")
		{
			isEnabled = true;
		}
		container = _root["normal_"+groupName]["plugin_" + pluginName];
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
		shapes.createShape ("rectangle", container.base, boxX, boxY, boxWidth, boxHeight, radius, white, 20, false, true, 1, black);
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
			shapes.switchImage (container.checkBox, "on");
			enabledCount++;
			disabledCount--;
		}
		else
		{
			shapes.switchImage (container.checkBox, "off");
			disabledCount++;
			enabledCount--;
		}
		setEvents (groupNum, pluginNum, pluginIndex);
	}
	//
	//
	private function setEvents (group:Number, plugin:Number, pluginIndex:Number)
	{
		container.base.onRollOver = function ()
		{
			arrays.pluginObject[arrays.pl_groupArray[group][plugin]].reColour("hover");
			plugins.currentPlugin.reColour("selected");
		};
		container.base.onRelease = function ()
		{
			plugins.pluginPress (group, plugin, pluginIndex);
		};
		container.base.onRollOut = function ()
		{
			arrays.pluginObject[arrays.pl_groupArray[group][plugin]].reColour("normal");
			plugins.currentPlugin.reColour("selected");
		};
		container.checkBox.onRelease = function ()
		{

			var nextPlugin:Object = arrays.pluginObject[arrays.pluginArrayAlpha[pluginIndex]];
			arrays.communicate.activateService("enableDisablePlugin",2, nextPlugin.iconName, nextPlugin.isEnabled);
			arrays.listener.gotData = function()
			{
				plugins.theWindow.editItem("text", "info", "It was"+(arrays.tempObject.toString() == true? " ":" not ")+"successful")
				plugins.theWindow.openWindow(false);
			}
			if (nextPlugin.isEnabled == true)
			{
				if (nextPlugin.iconName.toString() == "core")
				{
					plugins.theWindow.editItem("text", "info", "You don't want to disable this plugin :p");
				}
				else
				{
					plugins.theWindow.editItem("text", "info", "Unloading " + nextPlugin.pluginName);
				}
				plugins.theWindow.openWindow(false);
			}
			else
			{
				plugins.theWindow.editItem("text", "info", "Loading " + nextPlugin.pluginName);
				plugins.theWindow.openWindow(false);
			}
			if (nextPlugin.iconName.toString() != "core")
			{
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
				//	plugins.doSort (true);
				}
			}
		};
	}
	//
	//
	function createShape (fillColour:Number, fillAlpha:Number, textColour:Number)
	{
		shapes.createShape ("rectangle", container, boxX, boxY, boxWidth, boxHeight, radius, fillColour, fillAlpha, false, true, 1, black);
		container.label_txt.textColor = textColour;
	}
	function changeAction (__action:String)
	{
		action = __action;
		clearInterval (interval);
		isDone = false;
		interval = setInterval (EventDelegate.create (this, actionCheck), 10);
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
	//
	//
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
			clearInterval (interval);
		}
	}
	//
	//
	static function pluginPress (group:Number, plugin:Number, pluginIndex:Number)
	{

		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			var nextPlugin:Object = pluginObject[pluginArrayAlpha[i]];
			if (nextPlugin.pluginIndex == pluginIndex)
			{
				selectedPlugin = group;
				currentPlugin = nextPlugin;;
				stage.fillOutPluginDescription();
				var theName:String = currentPlugin.Name.toLowerCase ();
				nextPlugin.isSelected = true;
				nextPlugin.reColour ("selected");
				menuObject[groupArray[group]].changeAction ("dissapear");
				groupObject[groupArray[group]].reColour ("pressed");
				groups.selectedGroup = group;
				sorter.groupPressSort (group);
				plugins.chosenTab = 0;
				stageObject.theStage.createSettingsArea ();

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
	//
	//
	public static function determineAbled (option:Boolean, group:Number, plugin:Number)
	{
		var thePlugin:Object = pluginObject[pl_groupArray[group][plugin]];
		if (thePlugin.isEnabled != option)
		{
			thePlugin.isEnabled = option;
			if (option == true)
			{
				shapes.switchImage (thePlugin.container.checkBox, "on");
				enabledCount++;
				disabledCount--;
			}
			else
			{
				shapes.switchImage (thePlugin.container.checkBox, "off");
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
				shapes.switchImage (thePlugin.container.checkBox, "on");
				enabledCount++;
				disabledCount--;
			}
			else
			{
				shapes.switchImage (thePlugin.container.checkBox, "off");
				disabledCount++;
				enabledCount--;
			}
		}
	}
}
