package com.flashbsm.events
{

	import flash.events.Event;
	import mx.collections.ArrayCollection;
 	import flash.display.*;
 	import com.components.containers.*;
 	import mx.collections.Sort;
 	import mx.collections.SortField;

	public class changeShowAllEvent extends Event
	{
		public static const CHANGESHOWALL:String = "changeShowAll";
		public static const SEARCH:String = "search";
		public static const ALPHA_SORT:String = "alphaSort";
		public static const CP_SORT:String = "sortByCategAndPlugin"
		
		private var doChangeLayout:Boolean = false;
		private var doChangeFilter:Boolean = false;
		private var doChangeSort:Boolean = false;
		private var theFilterCallBack:Function = new Function();
		private var theSortType:String = ALPHA_SORT;
		private var theLayoutType:String = AnimatedTileList.LAYOUT_NORMAL;
		private var theSorter:Sort = new Sort();
		private var theFilterText:String = "";
		
		private var sortByCateg:SortField = new SortField("CategIndex");
		private var sortByPlugin:SortField = new SortField("Index");
		private var sortByShortDesc:SortField = new SortField("ShortDesc");

		public function changeShowAllEvent()
		{
			super( CHANGESHOWALL, true );
		}
			
			
			
		/*******************************
			Change Layout*/	
	
	
	
		public function get ChangeLayout ():Boolean
		{
			return doChangeLayout;
		}
		
		public function changeTheLayout (inLayoutType:String):void
		{
			doChangeLayout = true;
			theLayoutType = inLayoutType
		}
		
		public function get LayoutType ():String
		{
			return theLayoutType;
		}
		
		
		
		/*******************************
			Change Filter*/	
		
		
		
		public function get ChangeFilter ():Boolean
		{
			return doChangeFilter;
		}
		
		public function changeTheFilter (inFilterType:String):void
		{
			doChangeFilter = true;
			switch (inFilterType)
			{
				case SEARCH : 
					theFilterCallBack = searchFilter
					break;
			}
		}
		
		public function get FilterCallBack ():Function
		{
			return theFilterCallBack;
		}
		
		public function set FilterText(inFilterText:String):void
		{
			theFilterText = inFilterText;
		}
		
		private function searchFilter(item:Object):Boolean 
		{
			return item.ShortDesc.match(new RegExp(theFilterText, "i"));
		}
		
		
		
		/*******************************
			Change Sort*/	
		
		
		
		public function get ChangeSort ():Boolean
		{
			return doChangeSort;
		}
		
		
		public function changeTheSort (inSortType:String):void
		{
			doChangeSort = true;
			theSorter = new Sort()
			switch (inSortType)
			{
				case ALPHA_SORT :
					theSorter.fields = [sortByShortDesc];
					break;
				case CP_SORT :
					theSorter.fields = [sortByCateg, sortByPlugin];
					break;
			}
		}
		
		public function get Sorter ():Sort
		{
			return theSorter;
		}

	}
}

