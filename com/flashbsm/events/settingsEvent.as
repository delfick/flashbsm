package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class settingsEvent extends Event
	{
		public static const SETTINGSCHANGE:String = "settingsChange";
		
		private var theNewData:*;

		private var theType:String;
		
		private var theSetting:Object;
		
		private var theSettingObject:Object;

		public function settingsEvent( inType:String, inNewData:*, inSettingType:String, inSetting:Object, inSettingObject:*)
		{
			super( inType, true );
			theSetting = inSetting;
			theNewData = inNewData;
			theSettingObject = inSettingObject;
			settingType = inSettingType;
		}
		
		public function get oldData():*
		{
		    return theSetting.Value;
		}
		
		public function set Value(inValue:*):void
		{
		    theSetting.Value = inValue;
		    theSettingObject.newValue = inValue;
		}
		
		public function get Path ():Array
		{
		    return theSetting.Path;
		}
		
		public function get PathIndex ():Array
		{
		    return theSetting.PathIndex;
		}
		
		

		public function get newData():*
		{
			return theNewData;
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
		
		public function get Name ():String
		{
		    return theSetting.Name;
		}
		

	}
}

