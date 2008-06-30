package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;
	import mx.controls.Alert;
	import mx.containers.TabNavigator;
	import com.flashbsm.model.*;

	public class pluginDescriptionEvent extends Event
	{
		public static const CHANGE_DESC:String = "changeDesc";

		public var pluginData:Object;
		public var Categ:String;
		public var ShortDesc:String;
		public var LongDesc:String;
		public var theName:String;
		public var pluginIndex:uint;
		public var isEnabled:Boolean;
		public var hasIcon:Boolean;

		public function pluginDescriptionEvent( _pluginIndex:uint, groupIndex:uint)
		{
			super( CHANGE_DESC, true );
			pluginIndex = _pluginIndex;
			pluginData = fbsmModel.getInstance().uiItems.pluginItems.getItemAt(groupIndex).plugins[pluginIndex];
			Categ = fbsmModel.getInstance().uiItems.allGroups[groupIndex];
			ShortDesc = pluginData.ShortDesc;
			LongDesc = pluginData.LongDesc;
			theName = pluginData.Name;
			isEnabled = pluginData.isEnabled;
			hasIcon = pluginData.hasIcon;


		}
	}
}
