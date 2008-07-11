package com.flashbsm.views.settings.types
{
	import com.flashbsm.views.settings.*;

	public class checkBox extends settingsBase
	{
		import flash.events.*;
		import com.components.*;
		import com.flashbsm.events.*;
		import flash.utils.Timer;
		import flash.events.TimerEvent;
		import mx.controls.CheckBox;

		private var thing:CheckBox;
		private var isChecked:Boolean;
		
		public function checkBox (inSetting:Object)
		{
			super();
			theSetting = inSetting;
			super.setUpEventListeners();
		}

		override protected function createChildren():void
		{
			super.createChildren();

   			if (!thing)
			{
				thing = new CheckBox();
				thing.selected = theSetting.Value;
				thing.explicitWidth = thing.minWidth;
				thing.addEventListener("click", dispatchTheEvent);
				addChild(thing);
			}
		}

		override protected function measure():void
		{
			super.measure();
			measuredWidth = measuredMinWidth = thing.minWidth + super.theText.width;
			measuredHeight = measuredMinHeight = thing.minHeight + super.theText.height;
		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			thing.y = (thing.minHeight)/2;
			super.theText.x = thing.width + 20;
			super.theText.y = 1;
		}

		public function dispatchTheEvent(event:Event):void
		{
			flag = "changing";
			dispatchEvent( new settingsEvent(settingsEvent.SETTINGSCHANGE, thing.selected, "button", theSetting, this));
		}

		[Bindable]
		override public function get newValue():Boolean
		{
			return isChecked;
		}
		override public function set newValue(inChecked:Boolean):void
		{
			isChecked = inChecked;
			thing.selected = isChecked;
		}	

		override public function set isEnabled(inEnabled:Boolean):void
		{
			thing.enabled = inEnabled;
		}
		
		override public function set isVisible (inVisible:Boolean):void
		{
			super.isVisible = inVisible;
			thing.visible = inVisible;
		}
		
		
	}
}
