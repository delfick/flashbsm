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
		depth = __depth;
		//
		//
		reportProgress("Adding depths for initial stage");
		depth += stageObject.theStage.createClips ("bottom", depth);
		//
		//
		reportProgress("Adding funcbar objects");
		for (var i:Number = 0;i<funcBarArray.length;i++)
		{
			depth += funcBarObject[funcBarArray[i]].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding plugin holders with a normal depth");
		for (var i:Number=0;i<groupArray.length;i++)
		{
			_root.createEmptyMovieClip ("normal_" + groupArray[i], depth + i);
		}
		depth += groupArray.length
		//
		//
		reportProgress("adding all plugin");
		for (var i:Number= 0; i < pl_groupArray.length; i++)
		{
			for (var j:Number= 0; j < pl_groupArray[i].length; j++)
			{
				depth += pluginObject[pl_groupArray[i][j]].setbaseDepth (depth);
			}
		}
		//
		//
		reportProgress("adding all menus");
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			depth += menuObject[groupArray[i]].setbaseDepth (depth);
		}
		//
		//
		reportProgress("adding plugin holders with a depth higher than the menus");
		for (var i:Number=0;i<groupArray.length;i++)
		{
			_root.createEmptyMovieClip ("groupRoll_" + groupArray[i], depth + i);
		}
		depth += groupArray.length;
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
		//pluginName
		//
		reportProgress("adding mouse");
		depth += mouseObject.mouse.setbaseDepth (depth);
		//
		//
		reportProgress("adding sort layer")
		depth += stageObject.theStage.createClips ("sorter", depth);
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
		//
		//
		reportProgress("adding windows");
		for (var i:Number= 0; i < windowArray.length; i++)
		{
			funcBarObject[windowArray[i]].createWindow ();
		}
		//
		//
		reportProgress("adding groups, menus, plugins, mouse, functionBar");
		groups.createClips ();
		menus.createClips ();
		plugins.createClips ();
		mouseObject.mouse.createClips ();
		functionBar.createClips ();
		//
		//
		reportProgress("making stage");
		stageObject.theStage.createNormalStage ();
		//
		//
		reportProgress("putting plugins in the right place");
		functionBar.searchType = "group"
		plugins.pluginPress (0, 0, 0);
		
	}
}
