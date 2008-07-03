package com.custom
{
    import flash.utils.Timer;

    public class dataTimer extends Timer 
	{
        private var theData:Object = new Object();

        public function dataTimer(delay:Number, repeatCount:int=0) {
            super(delay, repeatCount);
        }

		public function set data(inData:Object):void
		{
			theData = inData;
		}

		public function get data():Object
		{
			return theData;
		}
    }
}
