import objects.*;
import ui.*;
import base.*;
import mx.utils.Delegate;
class base.sorter extends base.base
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
	/*==============doSort==============*/
	/*==============enableSort==============*/
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
	/*==============groupSort==============*/
	/*==============hideSort==============*/
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
	/*==============searchSort==============*/

}
/*

/////////////////////////////////////////////MOVED FROM ARRAYS
	static function createEnabledSort ()
	{
		pluginArrayAlphaEnabled = new Array ();
		for (var i:Number = 0; i < groupArray.length; i++)
		{
			for (var j:Number = 0; j < pl_groupArray[i].length; j++)
			{
				pluginArrayAlphaEnabled.push (pl_groupArray[i][j]);
			}
		}
		var array:Array = pluginArrayAlphaEnabled;
		var enabledIndex:Number = 0;
		var disabledIndex:Number = 0;
		for (var i:Number = 0; i < array.length; i++)
		{
			var thePlugin:Object = arrays.pluginObject[array[i]];
			var pluginName:String = array[i];
			var pluginState:Boolean = arrays.pluginObject[array.splice (i, 1)].isEnabled;
			if (pluginState == true)
			{
				array.splice (enabledIndex, 0, pluginName);
				enabledIndex++;
			}
			else
			{
				array.splice (enabledIndex + disabledIndex, 0, pluginName);
				disabledIndex++;
			}
		}
	}
	static function createGroupEnabledSort ()
	{
		pluginNormalArray = new Array ();
		for (var j:Number = 0; j < groupArray.length; j++)
		{
			var pluginGroupArray:Array = new Array ();
			for (var i:Number = 0; i < pl_groupArray[j].length; i++)
			{
				pluginGroupArray.push (pl_groupArray[j][i]);
			}
			var array:Array = pluginGroupArray;
			var enabledIndex:Number = 0;
			var disabledIndex:Number = 0;
			for (var i:Number = 0; i < array.length; i++)
			{
				var thePlugin:Object = arrays.pluginObject[array[i]];
				var pluginName:String = array[i];
				var pluginState:Boolean = arrays.pluginObject[array.splice (i, 1)].isEnabled;
				if (pluginState == true)
				{
					array.splice (enabledIndex, 0, pluginName);
					enabledIndex++;
				}
				else
				{
					array.splice (enabledIndex + disabledIndex, 0, pluginName);
					disabledIndex++;
				}
			}
			for (var z:Number = 0; z < array.length; z++)
			{
				pluginNormalArray.push (array[z]);
			}
		}
	}
	*/
