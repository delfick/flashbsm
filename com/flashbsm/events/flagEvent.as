package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class flagEvent extends Event
	{
		public static const FLAGCHANGE:String = "flagChange";

		private var theFlag:String;


		public function flagEvent( inType:String, inFlag:String)
		{
			super( inType, true );
			theFlag = inFlag;
		}

		public function get flag():String
		{
			return theFlag;
		}

		public function set flag(inFlag:String):void
		{
			theFlag = inFlag;
		}

	}
}

