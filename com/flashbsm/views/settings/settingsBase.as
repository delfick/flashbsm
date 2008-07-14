package com.flashbsm.views.settings
{
	import mx.core.UIComponent;

	public class settingsBase extends UIComponent
	{
		import flash.events.*;
		import com.flashbsm.events.*;
		import flash.utils.Timer;
		import flash.events.TimerEvent;
		import mx.effects.Effect;
		import mx.effects.Glow;
		import flash.text.TextField;
   		import flash.text.TextFormat;

		public var theText:TextField;
		private var theTextFormat:TextFormat;
		private var theGlow:Glow = new Glow();
		private var theFlag:String = "normal";
		private var flagTimer:Timer = new Timer(500, 1);
		private var changed:Boolean = false;
		private var isEventListenersSetup:Boolean = false;
		
		[Bindable]
		public var theLabel:String;
		
		[Bindable]
		public var theSetting:Object;
		
		private var _isVisible:Boolean = true;	
		
		
		public function settingsBase():void
		{
			super();
		}

		public function setUpEventListeners():void
		{
			if (!isEventListenersSetup)
			{
				isEventListenersSetup = true;
				this.addEventListener("flagChange", flagChange);
				this.addEventListener("flagChange", applyEffect);	
				theSetting.addEventListener("gotData", function(inEvent:gotDataEvent):void{ newValue = inEvent.Result; });
			}
		}

		public function set isEnabled(inEnabled:Boolean):void
		{
			//implemented by children
		}
		
		public function get newValue():Boolean
		{
			//implemented by children
			return true;
		}
		
		public function set newValue(inChecked:Boolean):void
		{
			//implemented by children
		}	
		
		override protected function createChildren():void
		{
			super.createChildren();

			if (!theText)     
			{
			    theTextFormat = new TextFormat();
       			theTextFormat.font = "Arial";
       			theTextFormat.color = 0x000000;
      			theTextFormat.size = 12;

       			theText = new TextField();
				theText.text = theLabel;
       			theText.autoSize = "left";
				theText.setTextFormat(theTextFormat);
       			addChild(theText);
    		}
		}
		
		public function set flag(inFlag:String):void
		{
			if (theFlag != inFlag)
			{
				theFlag = inFlag;
				dispatchEvent(new flagEvent(flagEvent.FLAGCHANGE, theFlag));
			}
		}

		private function flagChange(event:flagEvent):void
		{
			switch (event.flag)
			{
				case "normal" :
					//trace("changing to normal colour");
					isEnabled = true;
					break;
				case "changing" :
					//trace("changing to yellow colour");
					isEnabled = false;
					break;
				case "changed" :
					//trace("changing to green colour");
					flagTimer.start();
					flagTimer.addEventListener("timerComplete", changeFlagToNormal);
					changed = true;
					break;
				case "error" :
					//trace("changing to red colour");
					flagTimer.start();
					flagTimer.addEventListener("timerComplete", changeFlagToNormal);
					break;
			}
		}

		private function changeFlagToNormal(event:TimerEvent):void
		{
			flag = "normal";
			if (changed)
			{
				changed = false;
				dispatchEvent(new Event("theSettingChanged"))
			}
		}

		private function changeGlow(target:Object, inFlag:String):void
		{
			theGlow.target = target;
			switch (inFlag)
			{
				case "changing" :
					theGlow.duration=50;
					theGlow.alphaFrom=0.3;
					theGlow.alphaTo=1.0;
					theGlow.blurXFrom=10.0;
					theGlow.blurXTo=10.0;
					theGlow.blurYFrom=10.0;
					theGlow.blurYTo=10.0 ;
					theGlow.color=0xd8d11a;
					break;
				case "error" :
					theGlow.duration=500;
					theGlow.alphaFrom=0.3;
					theGlow.alphaTo=1.0;
					theGlow.blurXFrom=0.0;
					theGlow.blurXTo=10.0;
					theGlow.blurYFrom=0.0;
					theGlow.blurYTo=10.0 ;
					theGlow.color=0xFF0000;
					break;
				case "normal" :
					theGlow.duration=500;
					theGlow.alphaFrom=1.0;
					theGlow.alphaTo=0.0;
					theGlow.blurXFrom=10.0;
					theGlow.blurXTo=0;
					theGlow.blurYFrom=10.0;
					theGlow.blurYTo=0 ;
					theGlow.color=theGlow.color;
					break;
				case "changed" :
					theGlow.duration=500;
					theGlow.alphaFrom=0.3;
					theGlow.alphaTo=1.0;
					theGlow.blurXFrom=0.0;
					theGlow.blurXTo=10.0;
					theGlow.blurYFrom=0.0;
					theGlow.blurYTo=10.0 ;
					theGlow.color=0x00FF00;
					break;
			}
			theGlow.play();
		}

		private function applyEffect(inEvent:flagEvent):void
		{
        	changeGlow(inEvent.target, inEvent.flag);
        }
        
		[Bindable]
		public function get isVisible ():Boolean
		{
			return _isVisible;
		}
		public function set isVisible (inVisible:Boolean):void
		{
			_isVisible = inVisible;
		}
	}
}

