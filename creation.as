import objects.*;
class creation extends base
{
	static var depth:Number = 0;
	static function setDepths (__depth:Number)
	{
		depth = __depth;
		//Everything on Stage except for top bar must be on bottom
		//Then the function bar buttons
		//Then the menus for all groups but first and second
		//Then all plugins except for first and second Group
		//Then the depths for the sort layout (the stage)
		//Then menu for first and second group
		//Then plugins for first and second group
		//Then the top bar of the stage
		//Then the groups
		//Then the mouse class
		depth += stageObject.theStage.setbaseDepth (depth);
		depth += stageObject.theStage.setSettingsDepth (depth);
		for (var i:Number= 0; i < funcBarArray.length; i++)
		{
			depth += funcBarObject[funcBarArray[i]].setbaseDepth (depth);
		}
		for (var i:Number= 2; i < groupArray.length; i++)
		{
			depth += menuObject[groupArray[i]].setbaseDepth (depth);
		}
		depth += stageObject.theStage.setSortDepth (depth);
		for (var i:Number= 2; i < pl_groupArray.length; i++)
		{
			for (var j:Number= 0; j < pl_groupArray[i].length; j++)
			{
				depth += pluginObject[pl_groupArray[i][j]].setbaseDepth (depth);
			}
		}
		depth += menuObject[groupArray[1]].setbaseDepth (depth);
		for (var j:Number= 0; j < pl_groupArray[1].length; j++)
		{
			depth += pluginObject[pl_groupArray[1][j]].setbaseDepth (depth);
		}
		depth += menuObject[groupArray[0]].setbaseDepth (depth);
		for (var j:Number= 0; j < pl_groupArray[0].length; j++)
		{
			depth += pluginObject[pl_groupArray[0][j]].setbaseDepth (depth);
		}
		depth += stageObject.theStage.setTopBarDepth (depth);
		depth += stageObject.theStage.setPaneDepth (depth);
		for (var i:Number= 0; i < groupArray.length; i++)
		{
			depth += groupObject[groupArray[i]].setbaseDepth (depth);
		}
		depth += mouseObject.mouse.setbaseDepth (depth);
		depth += windows.setbaseDepth (depth);
		createClips ();
	}
	static function createClips ()
	{
		stageObject.theStage.createClips ();
		for (var i:Number= 0; i < windowArray.length; i++)
		{
			windowObject[windowArray[i]] = new windows ();
			funcBarObject[windowArray[i]].createWindow ();
		}
		groups.createClips ();
		menus.createClips ();
		plugins.createClips ();
		mouseObject.mouse.createClips ();
		plugins.pluginPress (0, 0, initialIndex);
		functionBar.createClips ();
	}
}
