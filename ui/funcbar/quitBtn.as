import mx.utils.Delegate;
import objects.*;
class objects.funcBar.quitBtn extends objects.functionBar
{
	public function quitBtn(__name:String, __num:Number)
	{
		theName = __name;
		number = __num;
		arrays.funcBarArray.push(theName);
	}
	function setPosition()
	{
		container._x = funcBarX + funcBarWidth - boxWidth - gap;
		container._y = boxY;
	}
	function activePress()
	{
		active = true;
		reColour(base.red, 20, base.black);
	}
	function inactivePress()
	{
		active = false;
		reColour(base.white, 20, base.black);
	}
}
