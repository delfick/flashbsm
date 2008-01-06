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
		active = true;
		reColour (base.red, 20, base.black);
		arrays.stageObject.theStage.createOptionsMask ();
	//	plugins.doSort (false);
		groups.hideGroups ();
	}
	function inactivePress ()
	{
		active = false;
		arrays.stageObject.theStage.destroyOptionsMask ("normal");
		reColour (base.white, 20, base.black);
		plugins.pluginPress (plugins.currentPlugin.groupNum, plugins.currentPlugin.pluginNum, plugins.currentPlugin.pluginIndex);
		arrays.stageObject.theStage.createNormalStage ();
		groups.showGroups ();
	}
}
