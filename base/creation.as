import objects.*;
import base.*;
import ui.*;
class base.creation extends base.base
{
	static var depth:Number = 0;
	static var stageNum:Number = 0;
	static function reportProgress(report:String)
	{
		base.trace(report, true, true, 14);
		arrays.theWindow.editItem("text", "Loading", report);
	}
	static function setDepths (__depth:Number)
	{
		plugins.currentPlugin = pluginObject[pluginArray[20]];
		depth = __depth;
		reportProgress("Adding depths for initial stage");
		depth += stageObject.theStage.createClips ("bottom", depth);
		//
		//
		reportProgress("Adding funcbar objects");
		for (var i:Number = 0;i<funcBarArray.length;i++)
		{
			depth += funcBarArray[i].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding all menus but first two");
		for (var i:Number= 2; i < groupArray.length; i++)
		{
			depth += menuObject[groupArray[i]].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding all plugins but those in first two groups");
		for (var i:Number= 2; i < pl_groupArray.length; i++)
		{
			for (var j:Number= 0; j < pl_groupArray[i].length; j++)
			{
				depth += pluginObject[pl_groupArray[i][j]].setbaseDepth (depth);
			}
		}
		//
		//
		reportProgress("adding second group : menu and plugins");
		depth += menuObject[groupArray[1]].setbaseDepth (depth);
		for (var j:Number= 0; j < pl_groupArray[1].length; j++)
		{
			depth += pluginObject[pl_groupArray[1][j]].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding first group : menu and plugins");
		depth += menuObject[groupArray[0]].setbaseDepth (depth);
		for (var j:Number= 0; j < pl_groupArray[0].length; j++)
		{
			depth += pluginObject[pl_groupArray[0][j]].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding top bar");
		depth += stageObject.theStage.createClips ("top", depth);
		//
		//
		reportProgress("adding groups");
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			depth += groupObject[groupArray[i]].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding mouse");
		depth += mouseObject.mouse.setbaseDepth (depth);
		//
		//
		reportProgress("adding sort layer")
		stageObject.theStage.createClips ("sort", depth);
		//
		//
		reportProgress("adding window layer");
		depth += windows.setbaseDepth (depth);
		//
		//
		reportProgress("making the ui");
		createClips ();

	}
	static function createClips()
	{
		
		reportProgress("making stage");
		stageObject.theStage.createNormalStage ();
		//
		//
	//	reportProgress("adding windows");
		for (var i:Number= 0; i < windowArray.length; i++)
		{
	//		windowObject[windowArray[i]] = new windows ();
	//		funcBarObject[windowArray[i]].createWindow ();
		}
		//
		//
		reportProgress("adding groups, menus, plugins, mouse, functionBar");
	//	groups.createClips ();
	//	menus.createClips ();
	//	plugins.createClips ();
	//	mouseObject.mouse.createClips ();
	//	functionBar.createClips ()
		//
		//
		reportProgress("putting plugins in the right place");
	//	plugins.pluginPress (0, 0, initialIndex);
	}
}
