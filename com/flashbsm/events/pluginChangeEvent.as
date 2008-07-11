package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;

	public class pluginChangeEvent extends Event
	{
		public static const PLUGINCHANGE:String = "pluginChange";
		
		private var theNewData:*;
		
		private var theSetting:Object;
		
		private var theSettingObject:Object;

		public function pluginChangeEvent( inType:String, inNewData:*, inSetting:Object, inSettingObject:*)
		{
			super( inType, true );
			theSetting = inSetting;
			theNewData = inNewData;
			theSettingObject = inSettingObject;
		}
		
		public function get oldData():*
		{
		    return theSetting.Enabled;
		}
		
		public function set Enabled(inEnabled:Boolean):void
		{
			theSetting.Enabled = inEnabled
			theSettingObject.newValue = inEnabled;
		}
		
		public function get Path ():Array
		{
		    return theSetting.Path;
		}
		
		public function get PathIndex ():Array
		{
		    return theSetting.PathIndex;
		}
		
		public function get PluginNumber ():Number
		{
			return theSetting.PluginNumber;
		}

		public function get newData():*
		{
			return theNewData;
		}
		
		public function get Name ():String
		{
		    return theSetting.Name;
		}
		
		public function set settingFlag(inFlag:String):void
		{
			target.flag = inFlag;
		}
		

	}
}

