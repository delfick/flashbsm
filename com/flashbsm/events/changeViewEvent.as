package com.flashbsm.events
{

	import flash.events.Event;

	public class changeViewEvent extends Event
	{
		public static const CHANGE_OF_VIEW:String = "changeOfView";

		private var theOldView:String;
		private var theNewView:String;


		public function changeViewEvent( inOldView:String, inNewView:String)
		{
			super ( CHANGE_OF_VIEW, true );
			this.theOldView = inOldView;
			this.theNewView = inNewView;
		}
		
		public function get oldView ():String
		{
			return theOldView;
		}
		
		public function get newView ():String
		{
			return theNewView;
		}
		
		
	}
}
