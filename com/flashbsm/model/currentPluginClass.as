package com.flashbsm.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class currentPluginClass extends EventDispatcher implements IEventDispatcher
	{
		[Bindable]
		public var ShortDesc:String;

		[Bindable]
		public var selectedTab:uint = 0;

		[Bindable]
		public var pluginIndex:uint = 0;

		[Bindable]
		public var isEnabled:Boolean;

		[Bindable]
		public var categIndex:uint = 0;

		[Bindable]
		public var enablerResult:Boolean;

		[Bindable]
		public var pluginDescription:String;

		[Bindable]
		public var pluginDescriptionIcon:String;

	}
}
