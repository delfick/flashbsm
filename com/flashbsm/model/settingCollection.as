package com.flashbsm.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	public class settingCollection extends EventDispatcher implements IEventDispatcher
	{
		import mx.collections.ArrayCollection;
		import com.flashbsm.model.*;

		[Bindable]
		public var allSettings:Object = new Object;

		[Bindable]
		public var tabArray:ArrayCollection = new ArrayCollection;

		[Bindable]
		public var subGroupArray:ArrayCollection = new ArrayCollection;

		public var ActionSettings:ArrayCollection = new ArrayCollection;

		public function newData(theData:*):void
		{

			for (var nextPlugin:* in theData)
			{
				var theNextPlugin:* = theData[nextPlugin];

				var ActionSettings:ArrayCollection = new ArrayCollection;
				allSettings[nextPlugin] = new ArrayCollection;


				for (var nextTab:* in theNextPlugin)
				{
					var theNextTab:* = theNextPlugin[nextTab];

					var nextTabObject:theTabsClass = new theTabsClass(theNextTab.label, new ArrayCollection);
					var nextsubGroupActionObject:theSubGroupsClass = new theSubGroupsClass(theNextTab.label, new ArrayCollection);
					allSettings[nextPlugin].addItem(nextTabObject);
					ActionSettings.addItem(nextsubGroupActionObject);


					for (var nextSubGroup:* in theNextTab.data)
					{
						var theNextSubGroup:* = theNextTab.data[nextSubGroup];

						var nextsubGroupObject:theSubGroupsClass = new theSubGroupsClass(theNextSubGroup.label,new ArrayCollection);
						allSettings[nextPlugin][nextTab].subGroups.addItem(nextsubGroupObject);

						var nextSetting:*;
						var theNextSetting:theSettingClass;

						if (allHaveSameType(theNextSubGroup.data, "List"))
						{
							var theNextGroupSetting:theGroupSettingClass = new theGroupSettingClass("MultiList");
							for (nextSetting in theNextSubGroup.data)
							{
								theNextSetting = new theSettingClass(theNextSubGroup.data[nextSetting]);
								theNextGroupSetting.addSetting(theNextSetting);
							}
							allSettings[nextPlugin][nextTab].subGroups.getItemAt(nextSubGroup).settings.addItem(theNextGroupSetting);
						}
						else
						{
							for (nextSetting in theNextSubGroup.data)
							{
								theNextSetting = new theSettingClass(theNextSubGroup.data[nextSetting]);

								if (theNextSetting.Type == "Action")
								{
									ActionSettings[nextTab].settings.addItem(theNextSetting);
								}
								else
								{
									allSettings[nextPlugin][nextTab].subGroups.getItemAt(nextSubGroup).settings.addItem(theNextSetting);
								}
							}
						}
					}
				}

				var actionTab:theTabsClass = new theTabsClass("Actions", ActionSettings);
				allSettings[nextPlugin].addItem(actionTab);
			}
			cleanTabs()
		}

		public function allHaveSameType(subGroupData:*, theType:String):Boolean
		{
			var typeArray:Array = new Array;
			var result:Boolean = true;
			for (var nextSetting:* in subGroupData)
			{
				var theNextSetting:theSettingClass = new theSettingClass(subGroupData[nextSetting]);
				typeArray.push(theNextSetting.Type);
			}
			if (typeArray.length <= 1)
			{
				result = false
			}
			else
			{
				for (var i:Number = 0;i<typeArray.length;i++)
				{
					if (typeArray[i] != theType)
					{
						result = false;
					}
				}
			}
			return result;
		}


		public function cleanTabs():void
		{

			for (var nextPlugin:* in allSettings)
			{
				var theNextPlugin:* = allSettings[nextPlugin];


				for (var nextTab:* in theNextPlugin)
				{
					var theNextTab:* = theNextPlugin[nextTab];

					theNextTab.subGroups.filterFunction = subGroupFilter;
					theNextTab.subGroups.refresh();

					theNextPlugin.filterFunction = tabFilter
					theNextPlugin.refresh();


				}

			}

			//finished initilising, now to switch to normal view
			fbsmModel.getInstance().finishedData();

		}

		public function subGroupFilter(item:Object):Boolean
		{
        	return item.settings.length > 0;
        }

		public function tabFilter(item:Object):Boolean
		{
        	return item.subGroups.length > 0;
        }


		public function testActionSettings():void
		{

			for (var nextTab:* in allSettings["core"])
			{
				var theNextTab:* = allSettings["core"][nextTab];

				if (theNextTab.label == "Actions")
				{

					for (var nextSubGroup:* in theNextTab.subGroups)
					{
						var theNextSubGroup:* = theNextTab.subGroups[nextSubGroup];

						trace(theNextSubGroup.label + "___" + theNextSubGroup.settings.length)

						for (var setting:* in theNextSubGroup.settings)
						{
							var theSetting:* = theNextSubGroup.settings[setting];

							trace("****   " + theSetting.ShortDesc);
						}
					}

				}
			}
		}
	}
}
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
internal class theTabsClass extends EventDispatcher implements IEventDispatcher
{

	import mx.collections.ArrayCollection;

	[Bindable]
	public var label:String;

	[Bindable]
	public var subGroups:ArrayCollection = new ArrayCollection;

	public function theTabsClass(_label:String, _subGroups:ArrayCollection):void
	{
		label = _label;
		subGroups = _subGroups;
	}
}

internal class theSubGroupsClass extends EventDispatcher implements IEventDispatcher
{

	import mx.collections.ArrayCollection;

	[Bindable]
	public var label:String;

	[Bindable]
	public var settings:ArrayCollection = new ArrayCollection;

	public function theSubGroupsClass(_label:String, _settings:ArrayCollection):void
	{
		label = _label;
		settings = _settings;
	}
}

internal class theSettingClass extends EventDispatcher implements IEventDispatcher
{

	import mx.collections.ArrayCollection;

	[Bindable]
	public var Type:String;

	[Bindable]
	public var ShortDesc:String;

	[Bindable]
	public var info:*;

	[Bindable]
	public var Value:*;

	public function theSettingClass(theData:*):void
	{
		Type = theData.Type;
		ShortDesc = theData.ShortDesc;
		info = theData.info;
		Value = theData.Value;
	}
}

internal class theGroupSettingClass extends EventDispatcher implements IEventDispatcher
{

	import mx.collections.ArrayCollection;

	[Bindable]
	public var Type:String;

	[Bindable]
	public var settingsArray:ArrayCollection = new ArrayCollection();

	public function theGroupSettingClass(theType:String):void
	{
		Type = theType
	}

	public function addSetting(theSetting:theSettingClass):void
	{
		settingsArray.addItem(theSetting);
	}
}
