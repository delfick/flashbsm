

package com.flashbsm.model
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	import mx.controls.Alert;
	import com.flashbsm.events.*;

	public class fbsmModel
	{
		private static var instance:fbsmModel;

		public static const NORMAL:String = "normal";
		public static const SHOW_ALL:String = "showAll";
		public static const INITIAL:String = "initial";
		
		public static var currentView:String = NORMAL;

		[Bindable]
		public var logText:String = "the flashbsm has been initialised";

		public function fbsmModel()
		{


			if ( instance != null )
			{
				throw( new Error( "there can be only one instance of the fbsmModel" ) );
			}
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
