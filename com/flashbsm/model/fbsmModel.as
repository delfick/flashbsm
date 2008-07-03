

package com.flashbsm.model
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	import mx.controls.Alert;
	import com.flashbsm.events.*;
	import com.flashbsm.model.*;
	import com.flashbsm.events.*;
	import com.components.*;

	public class fbsmModel
	{
		private static var instance:fbsmModel;
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
		
		public function fbsmModel()
		{
            allInfo.theType="getInfo";
			trace("asking server for information");
			allInfo.getInfo();
			allInfo.addEventListener("gotData", recieveData);

			if ( instance != null )
			{
				throw( new Error( "there can be only one instance of the fbsmModel" ) );
			}
		}

		public function recieveData(event:gotDataEvent):void
		{
			trace("recieved information from the server");
			var theData:* = event.target.theResult;
			trace("data decoded, now objectifying");
			for each (var categ:Object in theData)
			{
				everything.addCategory(categ)
			}
			trace("added all categories");
			everything.setCurrentGroup(0);
			changeTheView(NORMAL);
			
		}
		
		public function changeTheView (inNewView:String):void
		{
			dispatchEvent(new changeViewEvent(currentView, inNewView));
			currentView = inNewView
		}
		

		public static function getInstance():fbsmModel
		{
			if( instance == null )
			{

				instance = new fbsmModel();
			}

			return instance;
		}
	}
}
