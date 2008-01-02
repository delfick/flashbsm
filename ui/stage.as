import objects.*;
import mx.utils.Delegate;
class ui.stage extends base.base
{
	//common variables to all classes
	var baseDepth:Number;
	var topBarDepth:Number;
	var sortDepth:Number;
	var paneDepth:Number;
	var settingsDepth:Number;
	var neededSortDepths:Number = 50;
	var neededDepths:Number = 50;
	var neededPaneDepths:Number = 100;
	var neededSettingsDepths:Number = 100;
	var container:MovieClip;
	var interval:Number;
	var interval2:Number;
	static var speed:Number = 0.1;
	static var panelWidth:Number;
	static var panelHeight:Number = 67.1;
	private var sectionHeight:Number = 22;
	//
	//
	public function setStageDimensions ()
	{
		//
		//stageDimensions
		//
		stageHeight = arrays.stageDimensionsData.firstChild.childNodes[1].firstChild.nodeValue - 7.5;
		stageWidth = arrays.stageDimensionsData.firstChild.childNodes[0].firstChild.nodeValue - 7.5;
		if (stageHeight > Stage.height)
		{
			stageHeight = Stage.height - 7.5;
		}
		if (stageWidth > Stage.width)
		{
			stageWidth = Stage.width - 7.5;
		}
		//
		//width
		//
		pluginDescriptionImageWidth = descriptionHeight;
		descriptionWidth = stageWidth - (gap + sideWidth + gap + gap);
		settingsWidth = descriptionWidth;
		helperWidth = descriptionWidth;
		funcBarWidth = stageWidth - gap - gap;
		pluginDescriptionWidth = settingsWidth;
		//
		//Height
		//
		pluginDescriptionImageHeight = descriptionHeight;
		settingsHeight = stageHeight - (topY + topHeight + gap + descriptionHeight + gap + gap + helperHeight + gap + funcBarHeight + gap);
		sideHeight = stageHeight - (topY + topHeight + gap + gap + funcBarHeight + gap);
		//
		//Y co-ord
		//
		sideY = topY + topHeight + gap;
		descriptionY = topY + topHeight + gap;
		settingsY = descriptionY + descriptionHeight + gap;
		helperY = settingsY + settingsHeight + gap;
		funcBarY = helperY + helperHeight + gap;
		pluginDescriptionY = descriptionY + (descriptionHeight - pluginDescriptionHeight) / 2;
		pluginDescriptionImageY = topY + topHeight + gap;
		//
		//X co-ord
		//
		sideX = topX + gap;
		descriptionX = sideX + sideWidth + gap;
		settingsX = descriptionX;
		helperX = descriptionX;
		funcBarX = topX + gap;
		pluginDescriptionX = topX + gap + sideWidth + gap;
		pluginDescriptionImageX = descriptionX;
		//
		//container
		//
		container = _root;
		//
		//the pane
		//
		panelWidth = funcBarWidth;
		//
		//grid
		//
		horizGridSize = (base.stageWidth) / (sideWidth + 2 * gap);
		vertGridSize = (stageHeight - (3 * gap) - funcBarHeight - panelHeight - topY - gap) / (plugins.pluginHeight + gap);
	}
	function createClips ()
	{
		//
		//create movieClips
		//
		container.createEmptyMovieClip ("theOverall", baseDepth + 1);
		container.createEmptyMovieClip ("theSide", baseDepth + 2);
		container.createTextField ("pluginDescription", baseDepth + 4, pluginDescriptionX + gap + descriptionHeight, pluginDescriptionY, pluginDescriptionWidth, pluginDescriptionHeight);
		container.createEmptyMovieClip ("pluginDescriptionImage", baseDepth + 5);
		container.createEmptyMovieClip ("theTop", topBarDepth);
		container.createEmptyMovieClip ("theHelper", baseDepth + 6);
		container.createEmptyMovieClip ("sortCanvas", sortDepth);
		container.createEmptyMovieClip ("theFuncBar", sortDepth + 1);
		container.sortCanvas.createEmptyMovieClip ("base", sortDepth + 2);
		container.sortCanvas.createEmptyMovieClip ("canvas", sortDepth + 3);
		container.sortCanvas.createEmptyMovieClip ("header", sortDepth + 4);
		container.sortCanvas.createEmptyMovieClip ("enableDivider", sortDepth + 5);
		container.createEmptyMovieClip ("optionsPane", sortDepth + 6);
		container.optionsPane.createEmptyMovieClip ("canvas", sortDepth + 7);
		container.optionsPane.createEmptyMovieClip ("pane", sortDepth + 8);
		createPanel (container.optionsPane.pane, paneDepth);
		container.createEmptyMovieClip ("optionsMask", sortDepth + 9);
		container.optionsPane.setMask (container.optionsMask);
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			container.sortCanvas.createEmptyMovieClip ("groupDivider" + i, sortDepth + 10 + i);
		}
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			container.sortCanvas.createTextField ("groupTitle" + i, sortDepth + 11 + groupArray.length + i, groups.groupGap + groups.groupSections * i - 1, 8 + (groups.groupHeight / 2) - (22 / 2), stageWidth / groupArray.length, topHeight);
			container.sortCanvas["groupTitle" + i].setNewTextFormat (textFormat);
			container.sortCanvas["groupTitle" + i].wordWrap = true;
			container.sortCanvas["groupTitle" + i].text = groupArray[i];
			if (container.sortCanvas["groupTitle" + i].textHeight > 20)
			{
				container.sortCanvas["groupTitle" + i]._y -= 4;
			}
		}
		container.createEmptyMovieClip ("theSettings", settingsDepth);
		container.createEmptyMovieClip ("settingsArea", settingsDepth + 20);
		container.createEmptyMovieClip ("settingsMask", settingsDepth + 21);
		container.settingsArea.setMask (container.settingsMask);
		container.createEmptyMovieClip ("settingsScroller", settingsDepth + 22);
		container.settingsScroller.createEmptyMovieClip ("base", settingsDepth + 23);
		container.settingsScroller.createEmptyMovieClip ("grip", settingsDepth + 24);
		container.settingsArea.createTextField ("test", settingsDepth + 25, settingsX, settingsY + tabHeight + (2 * gap), settingsWidth, 500);
		container.settingsArea.test.setNewTextFormat (testFormat);
		createPane ();
		createNormalStage ();
	}
	function createSettingsArea ()
	{
		tabNameArray = plugins.currentPlugin.optionsTabsArray;
		tabX = settingsX;
		if (plugins.currentPlugin.tabNum > 0)
		{
			createRectangle (container.theSettings, settingsX, settingsY + tabHeight, settingsWidth, settingsHeight - tabHeight, 1, 0, black, white, 0);
		}
		else
		{
			createRectangle (container.theSettings, settingsX, settingsY, settingsWidth, settingsHeight, 1, 0, black, white, 0);
		}
		for (var i:Number= 0; i < plugins.numberOfTabs; i++)
		{
			container["tab" + i].clear ();
			container["tab" + i].tabName.text = "";
		}
		for (var i:Number= 0; i < plugins.currentPlugin.tabNum; i++)
		{
			container.createEmptyMovieClip ("tab" + i, settingsDepth + 1 + i);
			container["tab" + i].createTextField ("tabName", i, 0, (tabHeight - 17) / 2, tabNameArray[i].length * 10, 20);
			container["tab" + i].tabName.setNewTextFormat (tabFormat);
			container["tab" + i].tabName.selectable = false;
			container["tab" + i].tabName.text = tabNameArray[i];
			container["tab" + i].tabName.color = blue;
			container["tab" + i]._x = tabX;
			tabX += tabNameArray[i].length * 10;
			container["tab" + i]._y = settingsY;
			if (plugins.chosenTab == i)
			{
				createRectangle (container["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, blue, 50);
			}
			else
			{
				createRectangle (container["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, white, 0);
			}
			plugins.numberOfTabs = plugins.currentPlugin.tabNum;
			setupSettings (plugins.chosenTab);
			setTabEvents(container["tab" + i], container, i)
		}
	}
	function setTabEvents (mc:MovieClip, theClip:MovieClip, num:Number)
	{
		mc.onRollOver = function ()
		{
			stage.tabRoll (theClip, num);
		};
		mc.onPress = function ()
		{
			stage.tabPress (theClip, num);
		};
		mc.onRollOut = function ()
		{
			stage.tabRollOut (theClip, num);
		};
	}
	public static function tabRoll (theClip:MovieClip, num:Number)
	{
		tabNameArray = plugins.currentPlugin.optionsTabsArray;
		for (var i:Number= 0; i < plugins.numberOfTabs; i++)
		{
			if (i == plugins.chosenTab)
			{
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, blue, 50);
				theClip["tab" + i].tabName.color = black;
			}
			else if (i == num)
			{
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, red, 50);
				theClip["tab" + i].tabName.color = black;
			}
			else
			{
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, white, 100);
				theClip["tab" + i].tabName.color = blue;
			}
		}
	}
	public static function tabPress (theClip:MovieClip, num:Number)
	{
		tabNameArray = plugins.currentPlugin.optionsTabsArray;
		for (var i:Number= 0; i < plugins.numberOfTabs; i++)
		{
			if (i == num)
			{
				plugins.chosenTab = num;
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, blue, 50);
				theClip["tab" + i].tabName.color = black;
				stageObject.theStage.setupSettings (num);
			}
			else
			{
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, white, 0);
				theClip["tab" + i].tabName.color = blue;
			}
		}
	}
	public function setupSettings (num:Number)
	{
		settingsAreaHeight = 2400;
		container.settingsArea._x = settingsX;
		createLine (container.settingsArea, 0, 0, settingsWidth - (2 * gap) - scrollerWidth, settingsAreaHeight, 2, black);
		container.settingsArea.test.text = "tab -- " + tabNameArray[num] + "\nplugin -- " + plugins.currentPlugin.Name + "\ngroup -- " + groupArray[groups.selectedGroup];
		if (plugins.currentPlugin.tabNum > 0)
		{
			createRectangle (container.settingsMask, settingsX, settingsY + tabHeight, settingsWidth - (2 * gap) - scrollerWidth, settingsHeight - tabHeight, 1, 0, black, blue, 100);
			settingsAreaY = settingsY + tabHeight;
			if (settingsAreaHeight > settingsHeight)
			{
				gripHeight = (settingsHeight / settingsAreaHeight) * (settingsHeight - tabHeight - (2 * gap));
			}
			else
			{
				gripHeight = (settingsHeight - tabHeight - (2 * gap));
			}
			container.settingsArea._y = settingsY + tabHeight;
			shapes.createScroller (container.settingsScroller, container.settingsArea, settingsY + tabHeight + gap, settingsX + settingsWidth - gap, settingsHeight - tabHeight - (2 * gap), gripHeight, scrollerWidth, settingsHeight);
		}
		else
		{
			createRectangle (container.settingsMask, settingsX, settingsY, settingsWidth - (2 * gap) - scrollerWidth, settingsHeight, 1, 0, black, blue, 100);
			settingsAreaY = settingsY;
			if (settingsAreaHeight > settingsHeight)
			{
				gripHeight = (settingsHeight / settingsAreaHeight) * (settingsHeight - (2 * gap));
			}
			else
			{
				gripHeight = (settingsHeight - (2 * gap));
			}
			container.settingsArea._y = settingsY;
			shapes.createScroller (container.settingsScroller, container.settingsArea, settingsY + gap, settingsX + settingsWidth - gap, settingsHeight - (2 * gap), gripHeight, scrollerWidth, settingsHeight);
		}
	}
	public static function tabRollOut (theClip:MovieClip, num:Number)
	{
		tabNameArray = plugins.currentPlugin.optionsTabsArray;
		for (var i:Number= 0; i < plugins.numberOfTabs; i++)
		{
			if (i == plugins.chosenTab)
			{
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, blue, 50);
				theClip["tab" + i].tabName.color = black;
			}
			else
			{
				createRectangle (theClip["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 1, 0, black, white, 0);
				theClip["tab" + i].tabName.color = blue;
			}
		}
	}
	function createPane ()
	{
		container.optionsPane._x = funcBarX;
		container.optionsPane._y = funcBarY;
		createRectangle (container.optionsPane.canvas, 0, 0, funcBarWidth, panelHeight, 1, 0, black, white, 100);
		container.optionsPane.pane._x = 0;
		container.optionsPane.pane._y = 0;
		container.optionsPane.pane.searchLayout.normalChoice.onRelease = function ()
		{
			if (functionBar.searchType != "search")
			{
				functionBar.searchType = "normal";
			}
			else
			{
				functionBar.tempType = "normal";
			}
			plugins.doSort (true);
			shapes.switchImage (this._parent.normalChoice, "on");
			shapes.switchImage (this._parent.groupChoice, "off");
			shapes.switchImage (this._parent.enableChoice, "off");
			//shapes.createRadioBtn(this._parent.normalChoice, 10, "on");
			//shapes.createRadioBtn(this._parent.groupChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.enableChoice, 10, "off");
		};
		container.optionsPane.pane.searchLayout.groupChoice.onRelease = function ()
		{
			if (functionBar.searchType != "search")
			{
				functionBar.searchType = "group";
			}
			else
			{
				functionBar.tempType = "group";
			}
			plugins.doSort (true);
			shapes.switchImage (this._parent.normalChoice, "off");
			shapes.switchImage (this._parent.groupChoice, "on");
			shapes.switchImage (this._parent.enableChoice, "off");
			//shapes.createRadioBtn(this._parent.normalChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.groupChoice, 10, "on");
			//shapes.createRadioBtn(this._parent.enableChoice, 10, "off");
		};
		container.optionsPane.pane.searchLayout.enableChoice.onRelease = function ()
		{
			if (functionBar.searchType != "search")
			{
				functionBar.searchType = "enable";
			}
			else
			{
				functionBar.tempType = "enable";
			}
			plugins.doSort (true);
			shapes.switchImage (this._parent.normalChoice, "off");
			shapes.switchImage (this._parent.groupChoice, "off");
			shapes.switchImage (this._parent.enableChoice, "on");
			//shapes.createRadioBtn(this._parent.normalChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.groupChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.enableChoice, 10, "on");
		};
		container.optionsPane.pane.searchLayout.alphaCheck.onRelease = function ()
		{
			if (functionBar.isAlphabetical == false)
			{
				functionBar.isAlphabetical = true;
				plugins.doSort (true);
				shapes.switchImage (this, "on");
				//shapes.createCheckBox(this, 10, "off");
			}
			else
			{
				functionBar.isAlphabetical = false;
				plugins.doSort (true);
				shapes.switchImage (this, "off");
				//shapes.createCheckBox(this, 10, "on");
			}
		};
	}
	function createOptionsMask ()
	{
		clearInterval (interval);
		interval = setInterval (EventDelegate.create (this, drawOutPane), 10, container.optionsPane, funcBarY - panelHeight + 1);
	}
	function destroyOptionsMask (speed:String)
	{
		clearInterval (interval);
		if (speed == "quick")
		{
			createRectangle (container.optionsPane, funcBarX, funcBarY - panelHeight, panelWidth, 0, 0, 2, black, white, 100);
		}
		else if (speed == "normal")
		{
			interval = setInterval (EventDelegate.create (this, drawOutPane), 10, container.optionsPane, funcBarY);
		}
	}
	function drawOutPane (mc:MovieClip, finalY:Number)
	{
		if (animated == true)
		{
			if (Math.abs (finalY - mc._y) > 1)
			{
				mc._y += (finalY - mc._y) * speed;
			}
			else
			{
				mc._y = finalY;
				clearInterval (interval);
			}
		}
		else
		{
			mc._y = finalY;
			clearInterval (interval);
		}
	}
	function createNormalStage ()
	{
		resetStage ();
		createRectangle (container.optionsMask, topX, funcBarY - panelHeight - 10, stageWidth, panelHeight + 10, 0, 0, black, black, 100);
		createRectangle (container.theOverall, topX, topY, stageWidth, stageHeight, 5, 0, black, white, 0);
		createRectangle (container.theTop, topX, topY, stageWidth, topHeight, 5, 0, black, white, 100);
		createRectangle (container.theSide, sideX, sideY, sideWidth, sideHeight, 1, 0, black, white, 0);
		createRectangle (container.theFuncBar, funcBarX, funcBarY, funcBarWidth, funcBarHeight, 1, 0, black, white, 0);
		createRectangle (container.theHelper, helperX, helperY, helperWidth, helperHeight, 1, 0, black, white, 0);
		//createRectangle(container.pluginDescriptionImage, pluginDescriptionImageX, pluginDescriptionImageY, pluginDescriptionImageWidth, pluginDescriptionImageHeight, 1, 0, black, black, 0);
		container.pluginDescriptionImage._x = pluginDescriptionImageX;
		container.pluginDescriptionImage._y = pluginDescriptionImageY;
		container.pluginDescription.textColor = black;
		container.pluginDescription.setNewTextFormat (DescriptionText);
		container.pluginDescription.selectable = false;
	}
	public function createPanel (mc:MovieClip, depth:Number)
	{
		mc.createEmptyMovieClip ("canvas", depth);
		createText (mc, "Search Options", depth + 2, 0, (sectionHeight - 20) / 2, 20, 20);
		createText (mc, "Search Layout", depth + 3, 0, sectionHeight + (sectionHeight - 20) / 2, 20, 20);
		createText (mc, "Search", depth + 4, 0, sectionHeight * 2 + (sectionHeight - 20) / 2, 20, 20);
		mc.createTextField ("input_txt", depth + 5, 56.5, 46.4, funcBarWidth - 57, 18.5);
		mc.createEmptyMovieClip ("searchIn", depth + 6);
		createImageHolder (167.3 + 10, (sectionHeight - 14) / 2, depth + 7, mc.searchIn, "searchPlugins", "radio", "on");
		createText (mc.searchIn, "Plugins", depth + 8, 167.3 + 30, (sectionHeight - 17) / 2, 20, 20);
		createImageHolder (167.3 + 110, (sectionHeight - 14) / 2, depth + 14, mc.searchIn, "searchOptionss", "radio", "inactive");
		createText (mc.searchIn, "Options", depth + 10, 167.3 + 130, (sectionHeight - 17) / 2, 20, 20);
		mc.createEmptyMovieClip ("searchLayout", depth + 11);
		createImageHolder (167.3 + 10, (sectionHeight + (sectionHeight - 14) / 2), depth + 21, mc.searchLayout, "alphaCheck", "checkbox", "on");
		createText (mc.searchLayout, "Alphabetical", depth + 13, 167.3 + 30, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		createImageHolder (294.8 + 10, (sectionHeight + (sectionHeight - 14) / 2), depth + 28, mc.searchLayout, "normalChoice", "radio", "on");
		createText (mc.searchLayout, "Normal", depth + 15, 294.8 + 30, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		createImageHolder (294.8 + 110, (sectionHeight + (sectionHeight - 14) / 2), depth + 35, mc.searchLayout, "groupChoice", "radio", "off");
		createText (mc.searchLayout, "Group", depth + 17, 294.8 + 130, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		createImageHolder (294.8 + 210, (sectionHeight + (sectionHeight - 14) / 2), depth + 42, mc.searchLayout, "enableChoice", "radio", "off");
		createText (mc.searchLayout, "Enabled/Disabled", depth + 19, 294.8 + 230, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		mc.input_txt.setNewTextFormat (sortText);
		mc.input_txt.type = "input";
		mc.input_txt.border = true;
		setupInputText (mc.input_txt);
		createStaticRectangle (mc.canvas, 0, 0, funcBarWidth, sectionHeight * 3, 1, 0, black, white, 100);
		createStaticRectangle (mc.canvas, 0, 0, funcBarWidth, sectionHeight, 1, 0, black, white, 100);
		createStaticRectangle (mc.canvas, 0, sectionHeight, funcBarWidth, sectionHeight, 1, 0, black, white, 100);
		createStaticRectangle (mc.canvas, 0, sectionHeight * 2, funcBarWidth, sectionHeight, 1, 0, black, white, 100);
		createLine (mc.canvas, 167.3, 0, 167.3, sectionHeight * 2, 1, black);
		createLine (mc.canvas, 294.8, sectionHeight, 294.8, sectionHeight * 2, 1, black);
	}
	function setupInputText (txt:TextField)
	{
		txt.onChanged = function ()
		{
			if (txt.length > 0)
			{
				if (functionBar.searchType != "search")
				{
					functionBar.tempType = functionBar.searchType;
				}
				functionBar.searchType = "search";
				plugins.searchSort (txt.text, txt.length, true);
			}
			else if (txt.length == 0)
			{
				functionBar.searchType = functionBar.tempType;
				plugins.doSort (true);
			}
		};
	}
	function createText (mc:MovieClip, labelTxt:String, depth:Number, x1:Number, y1:Number, __width:Number, __height:Number)
	{
		mc.createTextField (labelTxt + "_txt", depth, x1, y1, __width, __height);
		mc[labelTxt + "_txt"].setNewTextFormat (sortText);
		mc[labelTxt + "_txt"].autoSize = true;
		mc[labelTxt + "_txt"].selectable = false;
		mc[labelTxt + "_txt"].text = labelTxt;
	}
	function resetStage ()
	{
		container.sortCanvas.header.clear ();
		container.sortCanvas.canvas.clear ();
		container.sortCanvas._visible = false;
		container.theTop.clear ();
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			container.sortCanvas["groupDivider" + i].clear ();
			container.sortCanvas["groupTitle" + i].text = "";
		}
	}
	/*********************************
	//*********************************************
	//** functions to create stages when sorting is enabled
	//*********************************************
	**********************************/
	function createNormalSort ()
	{
		resetStage ();
		container.sortCanvas._visible = true;
		createRectangle (container.sortCanvas.base, topX + 2.5, topY + 2.5, stageWidth - 6, funcBarY - gap, 0, 0, white, white, 100);
		createRectangle (container.sortCanvas.canvas, funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 1, 0, black, white, 100);
	}
	function createGroupSort ()
	{
		resetStage ();
		container.sortCanvas._visible = true;
		createRectangle (container.sortCanvas.base, topX + 2.5, topY + 2.5, stageWidth - 6, funcBarY - gap, 0, 0, white, white, 100);
		createRectangle (container.sortCanvas.canvas, funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 1, 0, black, white, 100);
		createLine (container.sortCanvas.header, funcBarX, topY + topHeight, funcBarX + funcBarWidth, topY + topHeight, 1, black);
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			createLine (container.sortCanvas["groupDivider" + i], groups.groupSections * i, topY + gap, groups.groupSections * i, topY + gap + stageHeight - (3 * gap) - funcBarHeight - panelHeight, 1, black);
			container.sortCanvas["groupTitle" + i].text = groupArray[i];
		}
	}
	function createEnableSort ()
	{
		resetStage ();
		container.sortCanvas._visible = true;
		createRectangle (container.sortCanvas.base, topX + 2.5, topY + 2.5, stageWidth - 6, funcBarY - gap, 0, 0, white, white, 100);
		createRectangle (container.sortCanvas.canvas, funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 1, 0, black, white, 100);
	}
}
