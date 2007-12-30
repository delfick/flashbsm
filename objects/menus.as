import mx.utils.Delegate;
import objects.*;
class objects.menus extends objects.shapes
{
	var baseDepth:Number;
	var neededDepths:Number = 1;
	var theName:String;
	var groupNum:Number;
	//containers
	var container:MovieClip;
	//co-ords
	var headerx:Number;
	var headery:Number;
	static var menuy:Number;
	var menux:Number;
	//size
	var headerheight:Number;
	var headerwidth:Number;
	var menuheight:Number;
	static var menuwidth:Number;
	//misc properties
	var color:Number;
	var fill:String;
	var thick:Number;
	var action:String;
	var speed:Number = 3;
	var radius:Number = 20;
	private var v:Number = 0;
	private var Int:Number;
	private var isDone:Boolean = false;
	// constructor
	public function menus(__name:String, __groupNum:Number)
	{
		theName = __name;
		groupNum = __groupNum;
	}
	static function createClips()
	{
		for (var i:Number= 0; i<groupArray.length; i++)
		{
			var meName:String = menuObject[groupArray[i]].Name;
			var meDepth:Number = menuObject[groupArray[i]].Depth;
			_root.createEmptyMovieClip("menu_"+meName, meDepth);
			menuObject[groupArray[i]].container = _root["menu_"+meName];
			menuObject[groupArray[i]].setProperties(i);
		}
	}
	function setProperties(num:Number)
	{
		menuheight = pl_groupArray[num].length*plugins.pluginHeight;
		menuwidth = sideWidth;
		menux = groupObject[groupArray[num]].container._x+(groups.groupWidth-menuwidth)/2;
		menuy = topY+topHeight;
		color = black;
		fill = "0x666666";
		thick = 1;
		action = "dissapear";
		speed = 0.1;
		radius = 5;
	}
	function changeAction(__action:String)
	{
		action = __action;
		clearInterval(Int);
		isDone = false;
		Int = setInterval(EventDelegate.create(this, actionCheck), 10, container);
	}
	function actionCheck()
	{
		if (isDone == false)
		{
			if (action != "dissapear")
			{
				if (action == "down")
				{
					if (animated == true)
					{
						if (Math.abs(menuheight-v)>1)
						{
							//Move towards target
							v += (menuheight-v)*speed;
							createRectangle(container, menux, menuy, menuwidth, v, 2, v<radius ? v : radius, black, white, 100);
						}
						else
						{
							v = menuheight;
							createRectangle(container, menux, menuy, menuwidth, v, 2, v<radius ? v : radius, black, white, 100);
							isDone = true;
						}
					}
					else
					{
						v = menuheight;
						createRectangle(container, menux, menuy, menuwidth, v, 2, v<radius ? v : radius, black, white, 100);
						isDone = true;
					}
				}
				else if (action == "up")
				{
					if (animated == true)
					{
						if (Math.abs(v-0)>1)
						{
							//Move towards target
							v -= (v-0)*speed*5;
							createRectangle(container, menux, menuy, menuwidth, v, 2, v<radius ? v : radius, black, white, 100);
						}
						else
						{
							v = 0;
							createRectangle(container, menux, menuy, menuwidth, v, 2, v<radius ? v : radius, black, white, 100);
							container.clear();
							isDone = true;
						}
					}
					else
					{
						v = 0;
						createRectangle(container, menux, menuy, menuwidth, v, 2, v<radius ? v : radius, black, white, 100);
						container.clear();
						isDone = true;
					}
				}
			}
			else
			{
				container.clear();
				v = 0;
				isDone = true;
			}
		}
		else
		{
			clearInterval(Int);
		}
	}
	function setbaseDepth(__depth:Number):Number
	{
		baseDepth = __depth;
		return neededDepths;
	}
	function get Name():String
	{
		return theName;
	}
	function get Depth():Number
	{
		return baseDepth;
	}
}
