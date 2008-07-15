package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class menuEvent extends Event
	{
		public static const CREATE_MENU:String = "createMenu";
		public static const SHOW_MENU:String = "showMenu";
		public static const HIDE_MENU:String = "hideMenu";
		
		private var theIndex:Number;
		private var theX:Number;
		private var theY:Number;
		private var theWidth:Number;
		private var theHeight:Number;

		public function menuEvent( inType:String, inIndex:Number)
		{
			super( inType, true );
			theIndex = inIndex;
		}
		
		public function get Index():Number
		{
		    return theIndex;
		}	
		
		public function get x ():Number
		{
			return theX;
		}
		public function set x (inX:Number):void
		{
			theX = inX;
		}
		
		public function get y ():Number
		{
			return theY;
		}
		public function set y (inY:Number):void
		{
			theY = inY;
		}
		
		public function get width ():Number
		{
			return theWidth;
		}
		public function set width (inWidth:Number):void
		{
			theWidth = inWidth;
		}
		
		public function get height ():Number
		{
			return theHeight;
		}
		public function set height (inHeight:Number):void
		{
			theHeight = inHeight;
		}
		
		

	}
}

