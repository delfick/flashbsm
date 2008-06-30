package com.flashbsm.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;

	public class interfaceInfo extends EventDispatcher implements IEventDispatcher
	{
		import mx.collections.ArrayCollection;

		[Bindable]
		public var allGroups:ArrayCollection = new ArrayCollection;

		[Bindable]
		public var activePlugins:ArrayCollection = new ArrayCollection;

		[Bindable]
		public var pluginItems:ArrayCollection = new ArrayCollection;

		[Bindable]
		public var allPlugins:ArrayCollection = new ArrayCollection;

		public function set _categs(theData:*):void
		{
			for (var g:String in theData[0].allGroups)
			{
				var nextCateg:String = theData[0].allGroups[Number(g)];
				allGroups.addItem(nextCateg);
			}


			for (var aP:String in theData[0].activePlugins)
			{
				var nextActivePlugin:String = theData[0].activePlugins[Number(aP)];
				activePlugins.addItem(nextActivePlugin);
			}
			fbsmModel.getInstance().finishedData();
		}

		public function set _plugins(theData:*):void
		{
			for (var g:* in theData)
			{
				var theGroups:pl_groupClass = new pl_groupClass(theData[g], g);
				pluginItems.addItem(theGroups);
			}

			for (var ca:* in pluginItems)
			{
				for (var pl:* in pluginItems.getItemAt(ca).plugins)
				{
					allPlugins.addItem(pluginItems.getItemAt(ca).plugins.getItemAt(pl));
				}
			}

			for (var np:* in allPlugins)
			{
				var theNextPlugin:* = allPlugins.getItemAt(np);
				pluginItems.getItemAt(theNextPlugin.categIndex).plugins.getItemAt(theNextPlugin.pluginIndex).globalIndex = np;
			}

			fbsmModel.getInstance().finishedData();
		}


	}
}
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
internal class pluginClass extends EventDispatcher implements IEventDispatcher
{

	[Bindable]
	public var ShortDesc:String;

	[Bindable]
	public var Name:String;

	[Bindable]
	public var LongDesc:String;

	[Bindable]
	public var isEnabled:Boolean;

	[Bindable]
	public var Categ:String;

	[Bindable]
	public var hasIcon:Boolean;

	[Bindable]
	public var categIndex:Number;

	[Bindable]
	public var pluginIndex:Number;

	[Bindable]
	public var globalIndex:Number;

	[Bindable]
	public var thumb:*;

	[Bindable]
	public var selectionFlag:Boolean;


	public function pluginClass(theData:*, _categIndex:Number, _pluginIndex:Number):void
	{
		ShortDesc = theData.ShortDesc;
		Name = theData.Name;
		LongDesc = theData.LongDesc;
		isEnabled = theData.isEnabled;
		Categ = theData.Categ;
		hasIcon = theData.hasIcon;
		categIndex = _categIndex;
		pluginIndex = _pluginIndex;
		if (Name == "core")
		{
			isEnabled = true;
		}
	}
}

internal class pl_groupClass extends EventDispatcher implements IEventDispatcher
{

	import mx.collections.ArrayCollection;

	[Bindable]
	public var plugins:ArrayCollection = new ArrayCollection;

	[Bindable]
	public var allPlugins:ArrayCollection = new ArrayCollection;


	public function pl_groupClass(theData:*, _categIndex:Number):void
	{
		for (var p:* in theData.plugins)
		{
			var nextPlugin:pluginClass = new pluginClass(theData.plugins[p], _categIndex, p);
			plugins.addItem(nextPlugin);
		}

		for (var aP:* in theData.allPlugins)
		{
			allPlugins.addItem(aP);
		}
	}
}

