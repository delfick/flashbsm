/*****************************************
* kagswf method
******************************************/
import kagstd.scene.*;
// Instance of this class will be
// created automatically in the first
// frame of the movie
class tracer.Frame1 extends SceneObject
{

	function Frame1 (mcParent:MovieClip)
	{
		// Parent constructor initializes
		// private variable "mc", which is
		// a reference to a new empty MovieClip
		super (mcParent);
		//start doing stuff
		base.base.startPoint(_root, "tracer");
	}
}

