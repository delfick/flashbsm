package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class gotDataEvent extends Event
	{
		public static const GOT_DATA:String = "gotData";

		private var theOutObject:Object;
		private var theResult:*;


		public function gotDataEvent(inOutObject:Object, inResult:*)
		{
			super( GOT_DATA, true );
			theOutObject = inOutObject;
			theResult = inResult;
		}
		
		public function get outObject ():Object
		{
		    return theOutObject;
		}
		
		public function get Result ():*
		{
		    return theResult;
		}
		
		
	}
}
