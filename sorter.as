import objects.*;
import mx.utils.Delegate;
class sorter extends base.base
{
	//common variables to all classes
	var baseDepth:Number;
	var neededDepths:Number = 1;
	var container:MovieClip;
	var interval:Number
	//
	//
	==============doSort==============
	==============enableSort==============
	==============groupPressSort==============
	==============groupRollOutSort==============
	==============groupRollSort==============
	==============groupSort==============
	==============hideSort==============
	==============normalSort==============
	==============searchSort==============

}

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
