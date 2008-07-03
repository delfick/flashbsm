package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class gotDataEvent extends Event
	{
		public static const GOT_DATA:String = "gotData";

		public var theTarget:ArrayCollection;
		public var theTargetObject:*;
		public var theType:String;


		public function gotDataEvent( _theTarget:ArrayCollection , _theTargetObject:*, _theType:String)
		{
			super( GOT_DATA, true );
			this.theTarget = _theTarget;
			this.theTargetObject = _theTargetObject;
			this.theType = _theType;
		}
	}
}
