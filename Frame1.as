/*****************************************
* kagswf method
******************************************/
import kagstd.scene.*;
// Instance of this class will be
// created automatically in the first
// frame of the movie
class Frame1 extends SceneObject
{

	function Frame1 (mcParent:MovieClip)
	{
		// Parent constructor initializes
		// private variable "mc", which is
		// a reference to a new empty MovieClip
		super (mcParent);
		base.base.createTextFormats(_root);
	}
}

