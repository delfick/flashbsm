import ui.*;
class tracer extends base.base
{
	var theWindow:Object;
	var receiver:LocalConnection = new LocalConnection ();
	public function tracer()
	{
		//Create the window
		theWindow = new windows ();
		theWindow.fixedWidth = Stage.width - 20;
		theWindow.fixedHeight = Stage.height - 20;
		theWindow.radius = 20;
		theWindow.openWindow (true);
		theWindow.addItem ("trace", "", undefined, true);
		theWindow.addItem ("trace", "The tracer is ready to trace");
		//Create reciever
		receiver.connect ('tracelog');
		receiver.tracer = function (txt:Object, colour:Number)
		{
			_root.theTracer.theWindow.addItem ("trace", txt, colour, false);
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


