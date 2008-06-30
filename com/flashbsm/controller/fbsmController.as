package com.flashbsm.controller
{
	import com.flashbsm.model.fbsmModel;

	import flash.events.Event;

	import mx.core.UIComponent;
	import mx.events.FlexEvent;
	import mx.controls.Alert;
	import com.flashbsm.events.*;
	import mx.core.Application;

	public class fbsmController extends UIComponent
	{
		public function fbsmController()
		{
			addEventListener( FlexEvent.CREATION_COMPLETE, setupEventListeners );
		}

		private function setupEventListeners( event:Event ):void
		{
			systemManager.addEventListener( pluginDescriptionEvent.CHANGE_DESC, createPluginDescriptionArea );
		}

		public function createPluginDescriptionArea(event:pluginDescriptionEvent):void
		{
			var iconName:String;
			event.hasIcon == true? iconName = event.theName: iconName = "unknown";
			fbsmModel.getInstance().currentPlugin.pluginDescriptionIcon = 'assets/icons/plugin-'+iconName + '.png'
			fbsmModel.getInstance().currentPlugin.pluginDescription = event.Categ + " --> " + event.ShortDesc + " --> " + event.LongDesc;
			fbsmModel.getInstance().updateSettingsData(event.theName);
			fbsmModel.getInstance().currentPlugin.ShortDesc = event.ShortDesc;
			fbsmModel.getInstance().currentPlugin.pluginIndex = event.pluginIndex;
			fbsmModel.getInstance().currentPlugin.isEnabled = event.isEnabled;

		}
	}
}
