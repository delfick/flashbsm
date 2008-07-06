package com.flashbsm.views.settings.types
{
	import com.flashbsm.views.settings.*;

	public class hSlider extends settingsBase
	{
		import flash.events.*;
		import com.flashbsm.events.*;
		import flash.utils.Timer;
		import flash.events.TimerEvent;
		import mx.controls.HSlider;
		import mx.controls.NumericStepper;
		import flash.events.MouseEvent;
		import flash.events.KeyboardEvent;
		import mx.events.SliderEvent;

		private var HS:HSlider;
		private var NS:NumericStepper;
		private var hSliderValue:Number = 0;
		private var minV:Number = 0;
		private var maxV:Number = 100;
		private var stepS:Number = 1;
		private var hWidth:Number = 200;
		private var nWidth:Number = 100;
		private var theHeight:Number = 25;
		private var oldValue:Number = 0;


		override protected function createChildren():void
		{
			super.createChildren();

   			if (!HS)
			{
				HS = new HSlider();
				HS.explicitWidth = HS.minWidth;
				HS.width = HS.minWidth + hWidth;
				HS.height = HS.minHeight + theHeight;

				HS.addEventListener("change", dispatchTheEventHS);
				HS.addEventListener("change", changeNSValue);
				HS.addEventListener(SliderEvent.THUMB_DRAG, changeNSValueT);

				HS.minimum = minV;
				HS.maximum = maxV;
				HS.snapInterval = stepS;
				addChild(HS);
			}

   			if (!NS)
			{
				NS = new NumericStepper();
				NS.explicitWidth = NS.minWidth;
				NS.width = NS.minWidth + nWidth;
				NS.height = HS.minHeight + theHeight;

				NS.addEventListener(MouseEvent.CLICK, dispatchTheEventNS);
            	NS.addEventListener(KeyboardEvent.KEY_UP, dispatchTheEventNSK);
				NS.addEventListener("change", changeHSValue);

				NS.minimum = minV;
				NS.maximum = maxV;
				NS.stepSize = stepS;
				addChild(NS);
			}
		}

		override protected function measure():void
		{
			super.measure();
			measuredWidth = measuredMinWidth = HS.width + NS.width + super.theText.width + 20;
			measuredHeight = measuredMinHeight = HS.height + NS.height + super.theText.height;

		}

		override protected function updateDisplayList(unscaledWidth:Number, unscaledHeight:Number):void
		{
			super.updateDisplayList(unscaledWidth, unscaledHeight);
			HS.y = (HS.minHeight)/2;
			HS.x = theText.width + 10;
			NS.x = HS.x + HS.width + 10;
			NS.y = HS.y + 3;
			super.theText.y = HS.y+8;

		}

		private function dispatchTheEventNS(event:MouseEvent):void
		{
			if (NS.value != oldValue)
			{
				flag = "changing";
				dispatchEvent( new settingsEvent(settingsEvent.SETTINGSCHANGE, NS.value, "hSlider"));
				oldValue = NS.value;
			}

		}
		private function dispatchTheEventNSK(event:KeyboardEvent):void
		{
			if (event.keyCode == 13)
			{
				if (oldValue != NS.value)
				{
					flag = "changing";
					dispatchEvent( new settingsEvent(settingsEvent.SETTINGSCHANGE, NS.value, "hSlider"));
					oldValue = NS.value
				}
			}
		}
		private function dispatchTheEventHS(event:Event):void
		{
			flag = "changing";
			dispatchEvent( new settingsEvent(settingsEvent.SETTINGSCHANGE, HS.value, "hSlider"));
			oldValue = HS.value;
		}

		[Bindable]
		public function get newValue():Number
		{
			return hSliderValue;
		}

		public function set newValue(inValue:Number):void
		{
			hSliderValue = inValue;
			HS.value = hSliderValue;
			NS.value = hSliderValue;
		}

		override public function set isEnabled(inEnabled:Boolean):void
		{
			HS.enabled = inEnabled;
			NS.enabled = inEnabled;
		}

		private function changeNSValue(event:Event):void
		{
			NS.value = HS.value;
		}
		private function changeNSValueT(event:SliderEvent):void
		{
			NS.value = event.value;
		}
		private function changeHSValue(event:Event):void
		{
			HS.value = NS.value;
		}
	}
}
