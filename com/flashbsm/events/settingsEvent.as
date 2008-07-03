package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class settingsEvent extends Event
	{
		public static const SETTINGSCHANGE:String = "settingsChange";

		private var theData:*;

		private var theType:String;
		
		private var theSetting:Object;

		public function settingsEvent( inType:String, inData:*, inSettingType:String, inSetting:Object)
		{
			super( inType, true );
			theSetting = inSetting;
			theData = inData;
			settingType = inSettingType;
		}
		
		public function get oldData():*
		{
		    return theSetting.Value;
		}
		
		public function set Value(inValue:*):void
		{
		    theSetting.Value = inValue;
		}

		public function get data():*
		{
			return theData;
		}

		public function set settingFlag(inFlag:String):void
		{
			target.flag = inFlag;
		}

		public function get settingType():String
		{
			return theType;
		}

		public function set settingType(inType:String):void
		{
			theType = inType;
		}

	}
}

