import mx.utils.Delegate;
import objects.*;
import base.*;
import ui.*;
class ui.funcbar.showAllBtn extends objects.functionBar
{
	function showAllBtn (__name:String, __num:Number)
	{
		theName = __name;
		theIndex = __num;
		arrays.funcBarArray.push (theName);
	}
	function activePress ()
	{
		for (var i:Number = 0;i<groupArray.length;i++)
		{
			pluginObject[pl_groupArray[i][0]].switchContainer("sorter");
		}
		active = true;
		reColour (base.red, 20, base.black);
		arrays.stageObject.theStage.createOptionsMask ();
	//	plugins.doSort (false);
		sorter.normalSort(false);
		groups.hideGroups ();
	}
	function inactivePress ()
	{
		for (var i:Number = 0;i<groupArray.length;i++)
		{
			pluginObject[pl_groupArray[i][0]].switchContainer("normal");
		}
		
		arrays.stageObject.theStage.destroyOptionsMask ("normal");
		reColour (base.white, 20, base.black);
		if (active)
		{
			plugins.pluginPress (plugins.currentPlugin.groupNum, plugins.currentPlugin.pluginNum, plugins.currentPlugin.pluginIndex);
		}
		arrays.stageObject.theStage.createNormalStage ();
		groups.showGroups ();
		active = false;
	}
}
