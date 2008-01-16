import objects.*;
import ui.*;
import base.*;
import mx.utils.Delegate;
class base.sorter extends objects.plugins
{
	//common variables to all classes
	var baseDepth:Number;
	var neededDepths:Number = 1;
	var container:MovieClip;
	var interval:Number
	//speed
	static var slowSpeed:Number = 0.1;
	static var fastSpeed:Number = 0.5;
	static var sortSpeed:Number = 0.4;
	//
	//
	//////////////////////// SHOWALL
	//
	//
	/*==============doSort==============*/
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
	/*==============enableSort==============*/
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
	/*==============groupSort==============*/
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
			var nextPlugin:Object = pluginObject[thePlugins[i]]
			nextPlugin.isDone = false;
			if (doAnimate == false)
			{
				nextPlugin.doItNow = true;
			}
			nextPlugin.createGroupGrid ();
			if (nextPlugin.groupSortScrollbar)
			{
				nextPlugin.changeAction ("groupSortWithSrollBar");
			}
			else
			{
				nextPlugin.changeAction ("groupSort");
			}
		}
	}
	/*==============hideSort==============*/
	public static function hideSort (group:Number):Void
	{
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			pluginObject[pluginArray[i]].changeAction ("dissapear");
		}
	}
	/*==============searchSort==============*/
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
	//
	//
	//////////////////////// GROUPS
	//
	//
	/*==============normalSort==============*/
	public static function normalSort (doAnimate:Boolean):Void
	{
		var thePlugins:Array = new Array ();
		plugins.horizGridNumber = 0;
		plugins.vertGridNumber = 0;
		stageObject.theStage.createNormalSort ();
		plugins.speed = sortSpeed;
		for (var i:Number = 0; i < pluginArray.length; i++)
		{
			pluginObject[pluginArray[i]].isDone = false;
			if (doAnimate == false)
			{
				pluginObject[pluginArray[i]].doItNow = true;
			}
			pluginObject[pluginArray[i]].createNormalGrid ();
			pluginObject[pluginArray[i]].changeAction ("normalSort");
		}
	}
	/*==============groupRollSort==============*/
	public static function groupRollSort (group:Number):Void
	{
		plugins.speed = slowSpeed;
		for (var j:Number = 0; j < pl_groupArray.length; j++)
		{
			if (groups.selectedGroup != j)
			{
				if (j == group)
				{
					for (var i:Number = 0;i<pl_groupArray[j].length;i++)
					{
						if (pluginObject[pl_groupArray[group][i]].action != "roll")
						{
							pluginObject[pl_groupArray[j][i]].container._x = menuObject[groupArray[j]].menux;
							pluginObject[pl_groupArray[j][i]].container._y = topY;
							pluginObject[pl_groupArray[j][i]].changeAction ("roll");
						}
					}
				}
				else
				{
					for (var i:Number = 0;i<pl_groupArray[j].length;i++)
					{
						pluginObject[pl_groupArray[j][i]].changeAction("dissapear");
					}
				}
			}
		}
	}
	/*==============groupPressSort==============*/
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
	/*==============groupRollOutSort==============*/
	public static function groupRollOutSort (group:Number):Void
	{
		plugins.speed = fastSpeed;
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
}
