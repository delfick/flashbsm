package com.flashbsm.model
{
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	public class infoModel extends EventDispatcher implements IEventDispatcher
	{
		import mx.collections.ArrayCollection;

		[Bindable]
		public var theCategories:ArrayCollection = new ArrayCollection;
		
		[Bindable]
		public var currentPlugins:ArrayCollection = new ArrayCollection;
		
		[Bindable]
		public var currentPlugin:plugin;
		
		[Bindable]
		public var currentGroup:group;
		
		[Bindable]
		public var currentCateg:category;
		
		private var groupCount:Number = 0;

		public function addCategory(theData:Object):void
		{
			theCategories.addItem(new category(theData, groupCount));
			groupCount++;
		}

		public function getCategory(theIndex:Number):category
		{
			return theCategories.getItemAt(theIndex) as category;
		}
		
		public function setCurrentCateg (inGroupIndex:Number):void
		{
		    currentCateg.Selected = false;
		    currentCateg = getCategory(inGroupIndex);
		    currentPlugins = currentCateg.thePlugins;
		    currentCateg.Selected = true;
		    setCurrentPlugin(inGroupIndex, 0)
		}
		
		public function setCurrentPlugin(inGroupIndex:Number, inPluginIndex:Number):void
		{
		    currentPlugin.Selected = false;
			currentPlugin = getCategory(inGroupIndex).getPlugin(inPluginIndex);
		    currentPlugin.Selected = true;
		    setCurrentGroup(currentPlugin.PathIndex, 0);
		}
		
		public function setCurrentGroup(inPathIndex:Array, inGroupIndex:Number):void
		{
		    currentGroup.Selected = false;
			currentGroup = getCategory(inPathIndex[0]).getPlugin(inPathIndex[1]).getGroup(inPathIndex[2]);
		    currentGroup.Selected = true;
		}
		
	}
}
import flash.events.EventDispatcher;
import flash.events.IEventDispatcher;
import com.components.*;
import com.flashbsm.events.*;
import com.flashbsm.model.*;

class category extends EventDispatcher implements IEventDispatcher
{
	import mx.collections.ArrayCollection;
	private var theName:String;
	private var theIndex:Number;
	private var isSelected:Boolean;
	private var thePath:Array = new Array();
	private var thePathIndex:Array = new Array();
	private var pluginCount:Number;
	
	[Bindable]
	public var thePlugins:ArrayCollection = new ArrayCollection;
	public function category(inCateg:Object, inIndex:Number)
	{
	    theIndex = inIndex;
		theName = inCateg.Name;
		isSelected = false;
		thePath.push(theName);
		thePathIndex.push(theIndex);
		pluginCount = 0;
		for (var nextPlugin:String in inCateg.Plugins)
		{
			thePlugins.addItem(new plugin(inCateg.Plugins[nextPlugin], pluginCount, thePath, thePathIndex));
			pluginCount++
		}
	}

	[Bindable]
	public function get Name():String
	{
		return theName;
	}
	public function set Name(inName:String):void
	{
		theName = inName;
	}
	
	[Bindable]
	public function get Selected ():Boolean
	{
	    return isSelected;
	}
	public function set Selected (inSelected:Boolean):void
	{
	    isSelected = inSelected;
	}
	
	public function get Index ():Number
	{
	    return theIndex;
	}
	
	public function get Path ():Array
	{
	    return thePath;
	}
	
	public function get PathIndex ():Array
	{
	    return thePathIndex;
	}
	
	

	public function getPlugin(theIndex:Number):plugin
	{
		return thePlugins.getItemAt(theIndex) as plugin;
	}
}
class plugin extends EventDispatcher implements IEventDispatcher
{
	import mx.collections.ArrayCollection;
	private var theName:String;
	private var theShortDesc:String;
	private var theLongDesc:String;
	private var theEnabled:Boolean;
	private var theFeatures:ArrayCollection = new ArrayCollection;
	private var theRanking:Object;
	private var isSelected:Boolean;
	private var hasIcon:Boolean;
	private var theIcon:String;
	private var theIndex:Number;
	private var theGroupIndex:Number;
	private var thePath:Array = new Array();
	private var thePathIndex:Array = new Array();
	private var groupCount:Number;
	[Bindable]
	public var theGroups:ArrayCollection = new ArrayCollection;

	public function plugin(inPlugin:Object, inIndex:Number, inPath:Array, inPathIndex:Array):void
	{
		theName = inPlugin.Name;
		theShortDesc = inPlugin.ShortDesc;
		theLongDesc = inPlugin.LongDesc;
		theEnabled = inPlugin.Enabled;
		Features = inPlugin.Features;
		theRanking = inPlugin.Ranking;
		isSelected = false;
		theIndex = inIndex;
		for each (var pathPart:String in inPath)
		{
		    thePath.push(pathPart);
		}
		for each (var indexPart:Number in inPathIndex)
		{
		    theGroupIndex = indexPart;
		    thePathIndex.push(indexPart);
		}
		thePath.push(theName);
		thePathIndex.push(theIndex);
		inPlugin.HasIcon == true? theIcon = theName: theIcon = "unknown";
		theIcon = 'assets/icons/plugin-'+ theIcon + '.png'
		groupCount = 0;
		for (var nextGroup:String in inPlugin.Groups)
		{
			theGroups.addItem(new group(inPlugin.Groups[nextGroup], groupCount, thePath, thePathIndex));
			groupCount++;
		}
	}

	[Bindable]
	public function get Name():String
	{
		return theName;
	}
	public function set Name(inName:String):void
	{
		theName = inName;
	}

	[Bindable]
	public function get ShortDesc():String
	{
		return theShortDesc;
	}
	public function set ShortDesc(inShortDesc:String):void
	{
		theShortDesc = inShortDesc;
	}

	[Bindable]
	public function get LongDesc():String
	{
		return theLongDesc;
	}
	public function set LongDesc(inLongDesc:String):void
	{
		theLongDesc = inLongDesc;
	}

	[Bindable]
	public function get Enabled():Boolean
	{
		return theEnabled;
	}
	public function set Enabled(inEnabled:Boolean):void
	{
		theEnabled = inEnabled;
	}

	[Bindable]
	public function get Features():*
	{
		return theFeatures;
	}
	public function set Features(inFeatures:*):void
	{
		theFeatures = new ArrayCollection();
		for (var feature:String in inFeatures)
		{
			theFeatures.addItem(inFeatures[feature]);
		}
	}

	[Bindable]
	public function get Ranking():Object
	{
		return theRanking;
	}
	public function set Ranking(inRanking:Object):void
	{
		theRanking = inRanking;
	}
	
	[Bindable]
	public function get Selected ():Boolean
	{
	    return isSelected;
	}
	public function set Selected (inSelected:Boolean):void
	{
	    isSelected = inSelected;
	}
	
	[Bindable]
	public function get Icon ():String
	{
	    return theIcon;
	}
	
	public function set Icon (inIcon:String):void
	{
	    theIcon = inIcon;
	}	
	
	public function get Index ():Number
	{
	    return theIndex;
	}
	
	public function get Path ():Array
	{
	    return thePath;
	}
	
	public function get PathIndex ():Array
	{
	    return thePathIndex;
	}
	
	
	public function get GroupIndex ():Number
	{
	    return theGroupIndex;
	}

	public function getGroup(theIndex:Number):group
	{
		return theGroups.getItemAt(theIndex) as group;
	}


}
class group extends EventDispatcher implements IEventDispatcher
{
	import mx.collections.ArrayCollection;
	private var theName:String;
	private var theIndex:Number;
	private var thePath:Array = new Array();
	private var thePathIndex:Array = new Array();
	private var subGroupCount:Number;
	private var isSelected:Boolean;
	[Bindable]
	public var theSubGroups:ArrayCollection = new ArrayCollection;
	public function group(inGroup:Object, inIndex:Number, inPath:Array, inPathIndex:Array)
	{
		theName = inGroup.Name;
		theIndex = inIndex;
		isSelected = false;
		for each (var pathPart:String in inPath)
		{
		    thePath.push(pathPart);
		}
		for each (var indexPart:Number in inPathIndex)
		{
		    thePathIndex.push(indexPart);
		}
		theName == "General" ?  thePath.push(""): thePath.push(theName);
		thePathIndex.push(theIndex);
		subGroupCount = 0;
		for (var nextSubGroup:String in inGroup.SubGroups)
		{
			theSubGroups.addItem(new subGroup(inGroup.SubGroups[nextSubGroup], subGroupCount, thePath, thePathIndex));
			subGroupCount++
		}
	}

	[Bindable]
	public function get Name():String
	{
		return theName;
	}
	public function set Name(inName:String):void
	{
		theName = inName;
	}
	
	[Bindable]
	public function get Selected ():Boolean
	{
	    return isSelected;
	}
	public function set Selected (inSelected:Boolean):void
	{
	    isSelected = inSelected;
	}
	
	public function get Index ():Number
	{
	    return theIndex;
	}
	
	public function get Path ():Array
	{
	    return thePath;
	}
	
	public function get PathIndex ():Array
	{
	    return thePathIndex;
	}

	public function getSubGroup(theIndex:Number):subGroup
	{
		return theSubGroups.getItemAt(theIndex) as subGroup;
	}
}
class subGroup extends EventDispatcher implements IEventDispatcher
{
	import mx.collections.ArrayCollection;
	private var theName:String;
	private var thePath:Array = new Array();
	private var thePathIndex:Array = new Array();
	private var settingsCount:Number;
	private var theIndex:Number;
	[Bindable]
	public var theSettings:ArrayCollection = new ArrayCollection;
	public function subGroup(inSubGroup:Object, inIndex:Number, inPath:Array, inPathIndex:Array)
	{
		theName = inSubGroup.Name;
		theIndex = inIndex;
		for each (var pathPart:String in inPath)
		{
		    thePath.push(pathPart);
		}
		for each (var indexPart:Number in inPathIndex)
		{
		    thePathIndex.push(indexPart);
		}
		thePath.push(theName);
		thePathIndex.push(theIndex);
		settingsCount = 0;
		for (var nextSetting:String in inSubGroup.Settings)
		{
			theSettings.addItem(new setting(inSubGroup.Settings[nextSetting], settingsCount, thePath, thePathIndex));
			settingsCount++
		}
	}

	[Bindable]
	public function get Name():String
	{
		return theName;
	}
	public function set Name(inName:String):void
	{
		theName = inName;
	}

	public function get Index ():Number
	{
	    return theIndex;
	}
	
	public function get Path ():Array
	{
	    return thePath;
	}
	
	public function get PathIndex ():Array
	{
	    return thePathIndex;
	}
	
	public function getSetting(theIndex:Number):setting
	{
		return theSettings.getItemAt(theIndex) as setting;
	}
}
class setting extends EventDispatcher implements IEventDispatcher
{
	import mx.collections.ArrayCollection;
	private var theName:String;
	private var theShortDesc:String;
	private var theLongDesc:String;
	private var theType:String;
	private var theHints:String;
	private var theInfo:Object;
	private var theValue:Object;
	private var theDefault:Object;
	private var thePath:Array = new Array();
	private var thePathIndex:Array = new Array();
	private var theIndex:Number;
	private var theSettingNumber:Number;
	private var renewSettings:communicate = new communicate();

	public function setting(inSetting:Object, inIndex:Number, inPath:Array, inPathIndex:Array):void
	{
		theName = inSetting.Name;
		theIndex = inIndex;
		theShortDesc = inSetting.ShortDesc;
		theLongDesc = inSetting.LongDesc;
		theType = inSetting.Type;
		theHints = inSetting.Hints
		theInfo = inSetting.Info
		theValue = inSetting.Value
		theSettingNumber = inSetting.SettingNumber
		theDefault = inSetting.Default
		for each (var pathPart:String in inPath)
		{
		    thePath.push(pathPart);
		}
		for each (var indexPart:Number in inPathIndex)
		{
		    thePathIndex.push(indexPart);
		}
		thePath.push(theName);
		thePathIndex.push(theIndex);
	}

	[Bindable]
	public function get Name():String
	{
		return theName;
	}
	public function set Name(inName:String):void
	{
		theName = inName;
	}

	[Bindable]
	public function get ShortDesc():String
	{
		return theShortDesc;
	}
	public function set ShortDesc(inShortDesc:String):void
	{
		theShortDesc = inShortDesc;
	}

	[Bindable]
	public function get LongDesc():String
	{
		return theLongDesc;
	}
	public function set LongDesc(inLongDesc:String):void
	{
		theLongDesc = inLongDesc;
	}

	[Bindable]
	public function get Type():String
	{
		return theType;
	}
	public function set Type(inType:String):void
	{
		theType = inType;
	}

	[Bindable]
	public function get Hints():String
	{
		return theHints;
	}
	public function set Hints(inHints:String):void
	{
		theHints = inHints;
	}

	[Bindable]
	public function get Info():Object
	{
		return theInfo;
	}
	public function set Info(inInfo:Object):void
	{
		theInfo = inInfo;
	}

	[Bindable]
	public function get Value():Object
	{
		return theValue;
	}
	public function set Value(inValue:Object):void
	{
		theValue = inValue;
	}

	[Bindable]
	public function get Default():Object
	{
		return theDefault;
	}
	public function set Default(inDefault:Object):void
	{
		theDefault = inDefault;
	}
	
	public function get Index ():Number
	{
	    return theIndex;
	}
	
	public function get SettingNumber ():Number
	{
	    return theSettingNumber;
	}
	
	
	public function get Path ():Array
	{
	    return thePath;
	}
	
	public function get PathIndex ():Array
	{
	    return thePathIndex;
	}
	
	public function renewValue():void
	{
		renewSettings.theType="renewValue";
		renewSettings.hasParams = true;
		renewSettings.theParams = [theSettingNumber]
		renewSettings.getInfo();
	    renewSettings.addEventListener("gotData", renewTheValue);
	}
	
	private function renewTheValue(inEvent:gotDataEvent):void
	{
		if (theValue != inEvent.Result)
		{
	    	theValue = inEvent.Result;
	    	dispatchEvent(new Event("gotNewValue"));
	    }
	}
}

