import base.*
import mx.remoting.Service;
import mx.rpc.RelayResponder;
import mx.rpc.FaultEvent;
import mx.rpc.ResultEvent;
import mx.remoting.PendingCall;
class base.communicate extends base.base
{
	public var myData:Object;
	public var myLength:Object;
	public var service:Service;

	function createService(theService:String)
	{
		service = new Service ("http://localhost:8000", null, theService, null, null);
	}
	function activateService(theService:String, numArguements:Number)
	{
		var pc:PendingCall;
		var theParams:Array = arguments.splice (2, arguments.length - 2);
		if (numArguements == 0)
		{
			pc = service[theService] ();
		}
		else
		{
			switch (theService)
			{
				//
				//	// Rectangle
				//
				case "getCategoryList" :
					var theGroup:Number = theParams[0];
					pc = service[theService] (theGroup);
					break;
				case "getCategoryListSize" :
					var theGroup:String = theParams[0];
					pc = service[theService] (theGroup);
					break;
				case "getPluginData" :
					var thePlugin:Number = theParams[0];
					pc = service[theService](thePlugin);
					break;
				case "enableDisablePlugin" :
					var thePlugin:String = theParams[0];
					var theStatus:Boolean = theParams[1];
					base.trace(thePlugin);
					pc = service[theService](thePlugin, theStatus);
					break;
			}
		}
		pc.responder = new RelayResponder (this, "onResult", "onFault");
	}
	// Result handler method
	function onResult (re:ResultEvent)
	{
		myData = re.result;
		arrays.tempObject = myData;
		arrays.broadCaster.broadcastMessage("gotData");
	}
	// Fault handler method displays error message
	function onFault (fault:FaultEvent):Void
	{
		// Notify the user of the problem
		base.trace("Remoting error: \n");
		for (var d:String in fault.fault)
		{
			base.trace(fault.fault[d] + "\n");
		}
	}
}
