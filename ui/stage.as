import objects.*;
import base.*;
import ui.*;
import mx.utils.Delegate;
class ui.stage extends base.base
{
	//common variables to all classes
	static var baseDepth:Number;
	static var sortDepth:Number;
	static var neededDepths:Number = 50;
	static var neededSortDepths:Number = 170;
	static var container:MovieClip;
	static var interval:Number;
	static var interval2:Number;
	//
	static var speed:Number = 0.1;
	static var panelWidth:Number;
	static var panelHeight:Number = 67.1;
	private var sectionHeight:Number = 22;
	static var iconLoad:LoadVars = new LoadVars ();
	//
	//
	public function stage (__container:MovieClip)
	{
		container = _root;
		//
		//stageDimensions
		//
		stageHeight = Stage.height - 7.5;
		stageWidth = Stage.width - 7.5;
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
	//
	//
	function createClips (part:String, __depth:Number):Number
	{
		switch (part)
		{
			case "bottom":
				baseDepth = __depth;
				container.createEmptyMovieClip ("theOverall", baseDepth + 1);
				container.createEmptyMovieClip ("theSide", baseDepth + 2);
				container.createEmptyMovieClip ("sidePluginHolder", baseDepth + 3);

					for (var i:Number=0;i<pluginArray.length;i++)
					{
						var plName:String = pluginObject[pluginArray[i]].pluginName;
						container.sidePluginHolder.createEmptyMovieClip ("plugin_" + plName, i);
					}

				container.createEmptyMovieClip ("pluginHeader", baseDepth + 4);

					container.pluginHeader.createTextField("pluginDescription", 1, pluginDescriptionX + gap + descriptionHeight, pluginDescriptionY, pluginDescriptionWidth, pluginDescriptionHeight);
					container.pluginHeader.createEmptyMovieClip("pluginDescriptionImage", 2);

				container.createEmptyMovieClip ("theFuncBar", baseDepth +5);
				container.createEmptyMovieClip ("theHelper", baseDepth + 6);
				container.createEmptyMovieClip ("settingsArea", baseDepth + 7);

					container.settingsArea.createEmptyMovieClip("theSettings", 1);
					container.settingsArea.createEmptyMovieClip("settingsMask", 2);
					container.settingsArea.theSettings.setMask (container.settingsArea.settingsMask);
					container.settingsArea.createEmptyMovieClip("settingsScroller", 3);

						container.settingsArea.settingsScroller.createEmptyMovieClip("base", 1);
						container.settingsArea.settingsScroller.createEmptyMovieClip("grip", 2);

				return neededDepths;
				break;
			case "top" :
				container.createEmptyMovieClip ("topBar", __depth);
				return __depth+1;
				break;
			case "sorter" :
				sortDepth = __depth;
				container.createEmptyMovieClip("sortCanvas", sortDepth + 1);

					container.sortCanvas.createEmptyMovieClip("base", 1);
					container.sortCanvas.createEmptyMovieClip("canvas", 2);

				for (var i:Number=0;i<groupArray.length;i++)
				{
					container.createEmptyMovieClip ("sorterGroupsMask"+i, sortDepth + 2+i);
					container.createEmptyMovieClip ("sorter_" + groupArray[i], sortDepth + 3 + i+groupArray.length);
					container["normal_"+groupArray[i]].setMask(container["sorterGroupsMask"+i]);
				}
				container.createEmptyMovieClip("sortItems", sortDepth + groupArray.length*2 + 4);

					container.sortItems.createEmptyMovieClip("topBar", 1);

						for (var i:Number= 0; i < groupArray.length; i++)
						{
							container.sortItems.topBar.createTextField ("groupTitle" + i, i, 0, groups.gap+(topHeight-22)/2, stageWidth / groupArray.length, topHeight);
							container.sortItems.topBar["groupTitle" + i].setNewTextFormat (sortHeaderFormat);
							container.sortItems.topBar["groupTitle" + i].wordWrap = true;
							container.sortItems.topBar["groupTitle" + i].selectable = false;
							container.sortItems.topBar["groupTitle" + i].text = groupArray[i];
							container.sortItems.topBar["groupTitle" + i].autoSize = "center";
							if (container.sortItems.topBar["groupTitle" + i].textHeight > 22)
							{
								container.sortItems.topBar["groupTitle" + i]._y += (22-container.sortItems.topBar["groupTitle" + i].textHeight);
							}
						}

					container.sortItems.createEmptyMovieClip("vertBars", 4);
					container.sortItems.createEmptyMovieClip ("optionsPane", 5);
					container.sortItems.createEmptyMovieClip("optionsPaneMask", 6);
					container.sortItems.optionsPane.setMask (container.sortItems.optionsPaneMask);

						container.sortItems.optionsPane.createEmptyMovieClip ("pane", 1);

							createPanel (container.sortItems.optionsPane.pane, 6);
							createPane (container.sortItems.optionsPane)

				return neededSortDepths;
				break;
		}
	}
	//
	//
	function resetStage ()
	{

	//	container.theOverall.clear();
		container.theSide.clear();
		container.pluginHeader.clear();
	//	container.pluginHeader.pluginDescription.text = "";
	//	container.pluginHeader.pluginDescriptionImage.clear();
	//	container.theFuncBar.clear();
		container.theHelper.clear();
	//	container.settingsArea.clear();
	//	container.settingsArea.theSettings.clear();
	//	container.settingsArea.settingsMask.clear();
	//	container.settingsArea.settingsScroller.clear();
	//	container.settingsArea.settingsScroller.base.clear();
	//	container.settingsArea.settingsScroller.grip.clear();

		container.topBar.clear();

		container.sortCanvas.clear();
		container.sortItems.clear();
		container.sortCanvas.base.clear();
		container.sortCanvas.canvas.clear();
		container.sortItems.topBar.clear();
		for (var i:Number = 0; i< groupArray.length;i++)
		{
			container.sortItems.topBar["groupTitle" + i].text = "";
		}
		container.sortItems.vertBars.clear();
	//	container.sortItems.optionsPane.clear();
	//	container.sortItems.optionsPane.pane.clear();
	//	container.sortItems.optionsPane.mask.clear();
	}
	function setPluginMask(theType:String)
	{
		switch (theType)
		{
			case "normal" :
				for (var i:Number = 0;i<groupArray.length;i++)
				{
					shapes.createShape ("rectangle", container["sorterGroupsMask"+i], 0, 0, Stage.width, Stage.height, 0, orange, 50, false, false);
				}
				break;
			case "groupSort" :
				for (var i:Number = 0;i<groupArray.length;i++)
				{
					shapes.createShape ("rectangle", container["sorterGroupsMask"+i], funcBarX, topY +topHeight, funcBarWidth, stageHeight - (2 * gap) - funcBarHeight - panelHeight - topHeight, 0, orange, 100, false, true, 1, black);
				}
				break;
			case "normalSort" :
				for (var i:Number = 0;i<groupArray.length;i++)
				{
					shapes.createShape ("rectangle", container["sorterGroupsMask"+i], funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 0, blue, 100, false, true, 1, black);
				}
				break;
			case "enableSort" :
				for (var i:Number = 0;i<groupArray.length;i++)
				{
					shapes.createShape ("rectangle", container["sorterGroupsMask"+i], funcBarX, topY + topHeight, funcBarWidth, stageHeight - (2 * gap) - funcBarHeight - panelHeight - topHeight, 0, green, 100, false, true, 1, black);
				}
				break;
		}
	}
	//
	//
	//////////////////////// STAGE CREATION
	//
	//
	function createNormalStage ()
	{
		resetStage ();
		setPluginMask("normal");
		shapes.createShape ("rectangle", container.sortItems.optionsPaneMask, funcBarX-3, funcBarY-panelHeight-3, panelWidth+6, panelHeight, 0, blue, 100, false, true, 10, black);
		shapes.createShape ("rectangle", container.theOverall, topX, topY, stageWidth, stageHeight, 0, black, 0, false, true, 5, black);
		shapes.createShape ("rectangle", container.topBar, topX, topY, stageWidth, topHeight, 0, white, 100, false, true, 5, black);
		shapes.createShape ("rectangle", container.theSide, sideX, sideY, sideWidth, sideHeight, 0, white, 0, false, true, 1, black);
		shapes.createShape ("rectangle", container.theFuncBar, funcBarX, funcBarY, funcBarWidth, funcBarHeight, 0, white, 0, false, true, 1, black);
		shapes.createShape ("rectangle", container.theHelper, helperX, helperY, helperWidth, helperHeight, 0, white, 0, false, true, 1, black);
		shapes.createShape ("rectangle", container.pluginHeader.pluginDescriptionImage, 0, 0, pluginDescriptionImageWidth, pluginDescriptionImageHeight, 0, black, 0, false, true, 1, black);
		container.pluginHeader.pluginDescriptionImage._x = pluginDescriptionImageX;
		container.pluginHeader.pluginDescriptionImage._y = pluginDescriptionImageY;
		container.pluginHeader.pluginDescription.textColor = black;
		container.pluginHeader.pluginDescription.setNewTextFormat (descriptionFormat);
		container.pluginHeader.pluginDescription.selectable = false;
		base.trace("normal stage made", true, true, 14);
	}
	//
	//
	public static function fillOutPluginDescription()
	{
		iconLoad.load ("images/icons/plugin-" + plugins.currentPlugin.iconName + ".png");
		iconLoad.onLoad = function (success:Boolean)
		{
			if (success)
			{
				_root.pluginHeader.pluginDescriptionImage.loadMovie ("images/icons/plugin-" + plugins.currentPlugin.iconName + ".png");
			}
			else
			{
				_root.pluginHeader.pluginDescriptionImage.loadMovie ("images/icons/plugin-unknown.png");
			}
		};
		_root.pluginHeader.pluginDescription.text = plugins.currentPlugin.groupName + " --> " + plugins.currentPlugin.pluginName + " --> " + plugins.currentPlugin.descriptionText;
	}
	//
	//
	//////////////////////// SORTING STAGE CREATION
	//
	//
	function createNormalSort ()
	{
		resetStage ();
		container.sortItems._visible = true;
		setPluginMask("normalSort");
		shapes.createShape ("rectangle", container.sortCanvas.base, topX + 2.5, topY + 2.5, stageWidth - 6, funcBarY - gap, 0, white, 100, false, false);
		shapes.createShape ("rectangle", container.sortCanvas.canvas, funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 0, white, 100, false, true, 1, black);
	}
	function createGroupSort ()
	{
		resetStage ();
		container.sortItems._visible = true;
		setPluginMask("groupSort");
		shapes.createShape ("rectangle", container.sortCanvas.base, topX + 2.5, topY + 2.5, stageWidth - 6, funcBarY - gap, 0, white, 100, false, false);
		shapes.createShape ("rectangle", container.sortCanvas.canvas, funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 0, white, 100, false, true, 1, black);
		shapes.createShape ("line", container.sortItems.topBar, funcBarX, topY + topHeight, funcBarX + funcBarWidth, topY + topHeight, 1, black);
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			shapes.createShape ("line", container.sortItems.vertBars, funcBarX + groups.groupSections * i, topY + gap, funcBarX + groups.groupSections * i, topY + gap + stageHeight - (3 * gap) - funcBarHeight - panelHeight, 1, black);
			container.sortItems.topBar["groupTitle" + i].text = groupArray[i];
			container.sortItems.topBar["groupTitle" + i]._x = funcBarX + groups.groupSections * i;
		}
	}
	function createEnableSort ()
	{
		resetStage ();
		container.sortItems._visible = true;
		setPluginMask("enableSort");
		shapes.createShape ("rectangle", container.sortCanvas.base, topX + 2.5, topY + 2.5, stageWidth - 6, funcBarY - gap, 0, white, 100, false, false);
		shapes.createShape ("rectangle", container.sortCanvas.canvas, funcBarX, topY + gap, funcBarWidth, stageHeight - (3 * gap) - funcBarHeight - panelHeight, 0, white, 100, false, true, 1, black);
		shapes.createShape ("line", container.sortItems.topBar, funcBarX, topY + topHeight, funcBarX + funcBarWidth, topY + topHeight, 1, black);
	}
	//
	//
	//////////////////////// SETTINGS AREA
	//
	//
	function createSettingsArea ()
	{
		var theBase:MovieClip = container.settingsArea
		theBase.theSettings.createTextField ("test", 10, settingsX, settingsY + tabHeight + (2 * gap), settingsWidth, 500);
		theBase.theSettings.test.setNewTextFormat (settingsFormat);
		//
		//
		tabNameArray = plugins.currentPlugin.optionsTabsArray;
		tabX = settingsX;
		//
		//set the settings area border as according to whether there are tabs or not
		if (plugins.currentPlugin.tabNum > 0)
		{
			shapes.createShape ("rectangle", theBase, 0, 0, settingsWidth - scrollerWidth - gap, settingsHeight - tabHeight, 0, white, 0, false, true, 1, black);
		}
		else
		{
			shapes.createShape ("rectangle", theBase, 0, 0, settingsWidth - scrollerWidth - gap, settingsHeight, 0, white, 0, false, true, 1, black);
		}
		//
		//create the tabs
		for (var i:Number= 0; i < plugins.numberOfTabs; i++)
		{
			container.pluginHeader["tab" + i].clear ();
			container.pluginHeader["tab" + i].tabName.text = "";
		}
		for (var i:Number= 0; i < plugins.currentPlugin.tabNum; i++)
		{
			container.pluginHeader.createEmptyMovieClip ("tab" + i,3 + i);
			container.pluginHeader["tab" + i].createTextField ("tabName", plugins.currentPlugin.tabNum.length + i, 0, (tabHeight - 17) / 2, tabNameArray[i].length * 10, 20);
			container.pluginHeader["tab" + i].tabName.setNewTextFormat (tabFormat);
			container.pluginHeader["tab" + i].tabName.selectable = false;
			container.pluginHeader["tab" + i].tabName.text = tabNameArray[i];
			container.pluginHeader["tab" + i].tabName.color = blue;
			container.pluginHeader["tab" + i]._x = tabX;
			tabX += tabNameArray[i].length * 10;
			container.pluginHeader["tab" + i]._y = settingsY;
			if (plugins.chosenTab == i)
			{
				shapes.createShape ("rectangle", container.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, blue, 50, false, true, 1, black);
			}
			else
			{
				shapes.createShape ("rectangle", container.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, white, 0, false, true, 1, black);
			}
			plugins.numberOfTabs = plugins.currentPlugin.tabNum;;

			setTabEvents(container.pluginHeader["tab" + i], container, i)
		}
		setupSettings (plugins.chosenTab);
	}
	//
	//
	public function setupSettings (num:Number)
	{
		settingsAreaHeight = 2400;
		container.settingsArea._x = settingsX;
		shapes.createShape ("line", container.settingsArea.theSettings, 0, 0, settingsWidth - (2 * gap) - scrollerWidth, settingsAreaHeight, 2, black);
		container.settingsArea.theSettings.test.text = "tab -- " + tabNameArray[num] + "\nplugin -- " + plugins.currentPlugin.iconName + "\ngroup -- " + plugins.currentPlugin.groupName;
		//
		//set the  mask and scroller as according to wehether there are tabs or not.
		if (plugins.currentPlugin.tabNum > 0)
		{
			shapes.createShape ("rectangle", container.settingsArea.settingsMask, 0, 0, settingsWidth - (2 * gap) - scrollerWidth, settingsHeight - tabHeight, 0, blue, 100, false, true, 1, black);
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
			shapes.createControl ("scroller", container.settingsArea.settingsScroller, container.settingsArea.theSettings, 0, settingsWidth, settingsHeight - tabHeight, gripHeight, scrollerWidth, settingsHeight, settingsAreaHeight);
		}
		else
		{
			shapes.createShape ("rectangle", container.settingsArea.settingsMask, settingsX, settingsY, settingsWidth - (2 * gap) - scrollerWidth, settingsHeight, 0, blue, 100, false, true, 1, black);
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
			shapes.createControl ("scroller", container.settingsArea.settingsScroller, container.settingsArea.theSettings, settingsY + gap, settingsX + settingsWidth - gap, settingsHeight - (2 * gap), gripHeight, scrollerWidth, settingsHeight, settingsAreaHeight);
		}
	}
	//
	//
	//////////////////////// TABS
	//
	//
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
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, blue, 50, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = black;
			}
			else if (i == num)
			{
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, red, 50, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = black;
			}
			else
			{
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, white, 100, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = blue;
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
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, blue, 50, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = black;
				stageObject.theStage.setupSettings (num);
			}
			else
			{
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, white, 0, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = blue;
			}
		}
	}
	public static function tabRollOut (theClip:MovieClip, num:Number)
	{
		tabNameArray = plugins.currentPlugin.optionsTabsArray;
		for (var i:Number= 0; i < plugins.numberOfTabs; i++)
		{
			if (i == plugins.chosenTab)
			{
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, blue, 50, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = black;
			}
			else
			{
				shapes.createShape ("rectangle", theClip.pluginHeader["tab" + i], 0, 0, tabNameArray[i].length * 10, tabHeight, 0, white, 0, false, true, 1, black);
				theClip.pluginHeader.pluginHeader["tab" + i].tabName.color = blue;
			}
		}
	}
	//
	//
	//////////////////////// OPTIONS PANE
	//
	//
	public function createPanel (mc:MovieClip, depth:Number)
	{
		//some extra movieclips
		mc.createEmptyMovieClip ("canvas", depth);
		mc.createEmptyMovieClip ("searchIn", depth + 6);
		mc.createEmptyMovieClip ("searchLayout", depth + 11);

		//input text field
		mc.createTextField ("input_txt", depth + 5, 56.5, 46.4, funcBarWidth - 57, 18.5);
			mc.input_txt.setNewTextFormat (sortOptionsFormat);
			mc.input_txt.type = "input";
			mc.input_txt.border = true;
			setupInputText (mc.input_txt);

			//text headings
			createText (mc, "Search Options", depth + 2, 0, (sectionHeight - 20) / 2, 20, 20);
			createText (mc, "Search Layout", depth + 3, 0, sectionHeight + (sectionHeight - 20) / 2, 20, 20);
			createText (mc, "Search", depth + 4, 0, sectionHeight * 2 + (sectionHeight - 20) / 2, 20, 20);

		//text and controls
		shapes.createImageHolder (167.3 + 10, (sectionHeight - 14) / 2, depth + 7, mc.searchIn, "searchPlugins", "radio", "on");
			createText (mc.searchIn, "Plugins", depth + 8, 167.3 + 30, (sectionHeight - 17) / 2, 20, 20);
		shapes.createImageHolder (167.3 + 110, (sectionHeight - 14) / 2, depth + 14, mc.searchIn, "searchOptionss", "radio", "inactive");
			createText (mc.searchIn, "Options", depth + 10, 167.3 + 130, (sectionHeight - 17) / 2, 20, 20);
		shapes.createImageHolder (167.3 + 10, (sectionHeight + (sectionHeight - 14) / 2), depth + 21, mc.searchLayout, "alphaCheck", "checkbox", "on");
			createText (mc.searchLayout, "Alphabetical", depth + 13, 167.3 + 30, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		shapes.createImageHolder (294.8 + 10, (sectionHeight + (sectionHeight - 14) / 2), depth + 28, mc.searchLayout, "normalChoice", "radio", "on");
			createText (mc.searchLayout, "Normal", depth + 15, 294.8 + 30, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		shapes.createImageHolder (294.8 + 110, (sectionHeight + (sectionHeight - 14) / 2), depth + 35, mc.searchLayout, "groupChoice", "radio", "off");
			createText (mc.searchLayout, "Group", depth + 17, 294.8 + 130, sectionHeight + (sectionHeight - 17) / 2, 20, 20);
		shapes.createImageHolder (294.8 + 210, (sectionHeight + (sectionHeight - 14) / 2), depth + 42, mc.searchLayout, "enableChoice", "radio", "off");
			createText (mc.searchLayout, "Enabled/Disabled", depth + 19, 294.8 + 230, sectionHeight + (sectionHeight - 17) / 2, 20, 20);

		//random shapes
		shapes.createShape ("rectangle", mc.canvas, 0, 0, funcBarWidth, sectionHeight * 3, 0, white, 100, true, true, 1, black);
		shapes.createShape ("rectangle", mc.canvas, 0, 0, funcBarWidth, sectionHeight, 0, white, 100, true, true, 1, black);
		shapes.createShape ("rectangle", mc.canvas, 0, sectionHeight, funcBarWidth, sectionHeight, 0, white, 100, true, true, 1, black);
		shapes.createShape ("rectangle", mc.canvas, 0, sectionHeight * 2, funcBarWidth, sectionHeight, 0, white, 100, true, true, 1, black);
		shapes.createShape ("line", mc.canvas, 167.3, 0, 167.3, sectionHeight * 2, 1, black);
		shapes.createShape ("line", mc.canvas, 294.8, sectionHeight, 294.8, sectionHeight * 2, 1, black);
	}
	function createText (mc:MovieClip, labelTxt:String, depth:Number, x1:Number, y1:Number, __width:Number, __height:Number)
	{
		mc.createTextField (labelTxt + "_txt", depth, x1, y1, __width, __height);
		mc[labelTxt + "_txt"].setNewTextFormat (sortOptionsFormat);
		mc[labelTxt + "_txt"].autoSize = true;
		mc[labelTxt + "_txt"].selectable = false;
		mc[labelTxt + "_txt"].text = labelTxt;
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
				sorter.searchSort (txt.text, txt.length, true);
			}
			else if (txt.length == 0)
			{
				functionBar.searchType = functionBar.tempType;
				sorter.doSort (true);
			}
		};
	}
	function createPane (base:MovieClip)
	{
		base._x = funcBarX;
		base._y = funcBarY;
		shapes.createShape ("rectangle", base, 0, 0, funcBarWidth, panelHeight, 0, white, 100, false, true, 1, black);
		base.pane.searchLayout.normalChoice.onRelease = function ()
		{
			if (functionBar.searchType != "search")
			{
				functionBar.searchType = "normal";
			}
			else
			{
				functionBar.tempType = "normal";
			}
			sorter.doSort (true);
			shapes.switchImage (this._parent.normalChoice, "on");
			shapes.switchImage (this._parent.groupChoice, "off");
			shapes.switchImage (this._parent.enableChoice, "off");
			//shapes.createRadioBtn(this._parent.normalChoice, 10, "on");
			//shapes.createRadioBtn(this._parent.groupChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.enableChoice, 10, "off");
		};
		base.pane.searchLayout.groupChoice.onRelease = function ()
		{
			if (functionBar.searchType != "search")
			{
				functionBar.searchType = "group";
			}
			else
			{
				functionBar.tempType = "group";
			}
			sorter.doSort (true);
			shapes.switchImage (this._parent.normalChoice, "off");
			shapes.switchImage (this._parent.groupChoice, "on");
			shapes.switchImage (this._parent.enableChoice, "off");
			//shapes.createRadioBtn(this._parent.normalChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.groupChoice, 10, "on");
			//shapes.createRadioBtn(this._parent.enableChoice, 10, "off");
		};
		base.pane.searchLayout.enableChoice.onRelease = function ()
		{
			base.trace("you clicked enablechoice");
			if (functionBar.searchType != "search")
			{
				functionBar.searchType = "enable";
			}
			else
			{
				functionBar.tempType = "enable";
			}
			sorter.doSort (true);
			shapes.switchImage (this._parent.normalChoice, "off");
			shapes.switchImage (this._parent.groupChoice, "off");
			shapes.switchImage (this._parent.enableChoice, "on");
			//shapes.createRadioBtn(this._parent.normalChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.groupChoice, 10, "off");
			//shapes.createRadioBtn(this._parent.enableChoice, 10, "on");
		};
		base.pane.searchLayout.alphaCheck.onRelease = function ()
		{
			if (functionBar.isAlphabetical == false)
			{
				functionBar.isAlphabetical = true;
				sorter.doSort (true);
				shapes.switchImage (this, "on");
				//shapes.createCheckBox(this, 10, "off");
			}
			else
			{
				functionBar.isAlphabetical = false;
				sorter.doSort (true);
				shapes.switchImage (this, "off");
				//shapes.createCheckBox(this, 10, "on");
			}
		};
	}
	//
	function createOptionsMask ()
	{
		clearInterval (interval);
		interval = setInterval (EventDelegate.create (this, drawOutPane), 10, container.sortItems.optionsPane, funcBarY-panelHeight - 3);
	}
	function destroyOptionsMask (speed:String)
	{
		clearInterval (interval);
		if (speed == "quick")
		{
			container.sortItems.optionsPane._x = funcBarX;
			container.sortItems.optionsPane._y = funcBarY;
			shapes.createShape ("rectangle", container.sortItems.optionsPane, 0, 0, panelWidth, 0, 2, white, 100, false, false);
		}
		else if (speed == "normal")
		{
			interval = setInterval (EventDelegate.create (this, drawOutPane), 10, container.sortItems.optionsPane, funcBarY);
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
}
