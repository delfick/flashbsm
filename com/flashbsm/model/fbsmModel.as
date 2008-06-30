

package com.flashbsm.model
{
	import mx.collections.ArrayCollection;
	import flash.events.Event;
	import mx.controls.Alert;
	import com.flashbsm.events.*;

	public class fbsmModel
	{
		private static var instance:fbsmModel;

		public static const VIEWING_NORMAL:String = "normal";
		public static const VIEWING_SHOWALL:String = "showAll";
		public static const VIEWING_INITIAL:String = "initial";

		private var gotDataCount:uint = 0;

		[Bindable]
		public var currentActivity:String = VIEWING_INITIAL;

		[Bindable]
		public var currentPlugin:currentPluginClass = new currentPluginClass();

		[Bindable]
		public var uiItems:interfaceInfo = new interfaceInfo();

		[Bindable]
		public var settingsItems:settingCollection = new settingCollection();

		[Bindable]
		public var logText:String = "the flashbsm has been initialised";

		static public var theSettings:communicate = new communicate();
		static public var categories:communicate = new communicate();
		static public var plugins:communicate = new communicate();

		public function fbsmModel()
		{

			categories.theType="getCategInfo";
			categories.getInfo();
			categories.addEventListener("gotData", giveData);

			plugins.theType="getPluginInfo";
			plugins.getInfo();
			plugins.addEventListener("gotData", giveData);

			theSettings.theType="getSettings";
			theSettings.theTargetObject = settingsItems;
			theSettings.getInfo();
			theSettings.addEventListener("gotData", giveData);


			if ( instance != null )
			{
				throw( new Error( "there can be only one instance of the fbsmModel" ) );
			}
		}
		
		public function finishedData():void
		{
			gotDataCount++;
			if(gotDataCount == 3)
			{
				currentActivity = VIEWING_NORMAL;
				setCurrentPlugin(0, 0);
			}
		}

		public function updateSettingsData(theParam:String):void
		{
			theSettings.theParams = [theParam];
			theSettings.getInfo();
		}

		public function setCurrentPlugin(categ:uint, plugin:uint):void
		{
			var theCurrentPlugin:Object = uiItems.pluginItems.getItemAt(categ).plugins.getItemAt(plugin);
			currentPlugin.ShortDesc = theCurrentPlugin.ShortDesc
			currentPlugin.pluginIndex = 10;
			currentPlugin.pluginIndex = plugin;
			currentPlugin.categIndex = categ;
		}



		public function giveData(event:gotDataEvent):void
		{
			if (event.theType == "getCategInfo")
			{
				uiItems._categs = event.target.theResult;
			}
			else if (event.theType == "getPluginInfo")
			{
				uiItems._plugins = event.target.theResult;
			}
			else
			{
				event.theTargetObject.newData(event.target.theResult);
			}
		}

		public function testData(event:gotDataEvent):void
		{
			trace("testing data \n");
			trace(event.target.theResult[0].label);
			trace("\n data test complete");
		}

		public static function getInstance():fbsmModel
		{
			if( instance == null )
			{

				instance = new fbsmModel();
			}

			return instance;
		}
	}
}
