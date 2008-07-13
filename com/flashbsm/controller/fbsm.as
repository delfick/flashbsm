package com.flashbsm.controller
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	import mx.controls.Alert;
	import com.flashbsm.events.*;
	import com.flashbsm.model.*;
	import com.flashbsm.events.*;
	import com.components.*;

	public class fbsm
	{
		private static var instance:fbsm;
		private var allInfo:communicate = new communicate();

		public static const NORMAL:String = "normal";
		public static const SHOW_ALL:String = "showAll";
		public static const INITIAL:String = "initial";
		
		public static var currentView:String = NORMAL;

		[Bindable]
		public var logText:String = "the flashbsm has been initialised";

		[Bindable]
		public var i:Number = 0;

		[Bindable]
		public var everything:infoModel = new infoModel();		

		[Bindable]
		public var isVisible:Boolean = false;
		
		public function fbsm()
		{
            allInfo.theType="getInfo";
			trace("asking server for information");
			allInfo.getInfo();
			allInfo.addEventListener("gotData", recieveData);

			if ( instance != null )
			{
				throw( new Error( "there can be only one instance of the fbsm" ) );
			}
		}

		public function recieveData(event:gotDataEvent):void
		{
			trace("recieved information from the server");
			var theData:* = event.Result;
			trace("data decoded, now objectifying");
			for each (var categ:Object in theData)
			{
				everything.addCategory(categ)
			}
			trace("added all categories");
			everything.currentCateg = everything.getCategory(0);
			everything.currentPlugin = everything.currentCateg.getPlugin(0);
			everything.currentGroup = everything.currentPlugin.getGroup(0);
			everything.setCurrentCateg([0,0,0]);
			changeTheView(NORMAL);
			
		}
		
		public function changeTheView (inNewView:String):void
		{
			dispatchEvent(new changeViewEvent(currentView, inNewView));
			currentView = inNewView
		}
		

		public static function getInstance():fbsm
		{
			if( instance == null )
			{

				instance = new fbsm();
			}

			return instance;
		}
	}
}
