import ui.*;
class tracer extends base.base
{
	var theWindow:Object;
	var receiver:LocalConnection;
	public function tracer()
	{
		//Create the window
		theWindow = new windows ();
		theWindow.fixedWidth = Stage.width - 20;
		theWindow.fixedHeight = Stage.height - 20;
		theWindow.radius = 20;
		theWindow.openWindow (true);
		theWindow.addItem ("trace", "", undefined);
		theWindow.addItem ("trace", "The tracer is ready to trace");
		//Create reciever
		receiver = new LocalConnection ();
		receiver.connect ('tracelog');
		receiver.tracer = function (txt:Object, theParams:Array)
		{
			trace(theParams);
			_root.theTracer.theWindow.addItem ("trace", txt, theParams);
		};
		Stage.addListener (this);
	}
	function onResize()
	{
		theWindow.destroyWindow ();
		theWindow.fixedWidth = Stage.width - 20;
		theWindow.fixedHeight = Stage.height - 20;
		theWindow.radius = 20;
		theWindow.openWindow (true);
		theWindow.editItem ("takeScroller");
		theWindow.updateScroller ();
		theWindow.addItem ("trace", "", undefined, true);
	}
}


