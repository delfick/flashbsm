﻿import objects.*;
import base.*;
import ui.*;
class base.creation extends base
{
	static var depth:Number = 0;
	static var stageNum:Number = 0;
	static function createEverything (__depth:Number, theStage:Number)
	{
		switch (theStage)
		{
			case 1 :
				base.trace("stage one of creation", true, true);
				arrays.theWindow.editItem("text", "Loading", "Adding depths for initial stage");
				break;
		}
		//objects will call back this function after making sure readyYet=false
		//
		//STAGE1 = create stage
		//STAGE2 = create menus group 3 onwards
		//STAGE3 = create plugins group 3 onwards
		//STAGE4 = create menu 1 and 2
		//STAGE5 = create plugins group 1 and 2
		//STAGE6 = create second stage
		//STAGE7 = put everything into position
		//STAGE8 = ready for action message
	}
}
