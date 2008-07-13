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
		public static const CP_SORT:String = "sortByCategAndPlugin";
		public static const ENABLED_SORT:String = "sortBystatus";
		
		private var doChangeLayout:Boolean = false;
		private var doChangeFilter:Boolean = false;
		private var doChangeSort:Boolean = false;
		private var theFilterCallBack:Function = new Function();
		private var theSortType:String = ALPHA_SORT;
		private var theLayoutType:String = AnimatedTileList.LAYOUT_NORMAL;
		private var theSorter:Sort = new Sort();
		private var theFilterText:String = "";
		private var doShowExtras:Boolean = false;
		
		private var sortByCateg:SortField = new SortField("CategIndex");
		private var sortByPlugin:SortField = new SortField("Index");
		private var sortByShortDesc:SortField = new SortField("ShortDesc");
		private var sortByStatus:SortField = new SortField("Enabled");

		public function changeShowAllEvent()
		{
			super( CHANGESHOWALL, true );
			sortByStatus.descending=true;
		}
		
		public function get showExtras ():Boolean
		{
			return doShowExtras;
		}
		
			
			
			
		/*******************************
			Change Layout*/	
	
	
	
		public function get ChangeLayout ():Boolean
		{
			return doChangeLayout;
		}
		
		public function changeTheLayout (inLayoutType:String, isAlphaSelected:Boolean):void
		{
			doChangeLayout = true;
			theLayoutType = inLayoutType
			doShowExtras = false;
			switch (inLayoutType)
			{
				case AnimatedTileList.LAYOUT_NORMAL :
					isAlphaSelected 
						?
						changeTheSort(ALPHA_SORT)				
						:
						changeTheSort(CP_SORT);
					break;
				case AnimatedTileList.LAYOUT_GROUPS :
					isAlphaSelected 
						?
						changeTheSort(CP_SORT)				
						:
						changeTheSort(ENABLED_SORT);
					break;
				case AnimatedTileList.LAYOUT_ENABLED :
					
					isAlphaSelected 
						?
						changeTheSort(ALPHA_SORT)				
						:
						changeTheSort(CP_SORT);		
						doShowExtras = true;
					break;
			}
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
				case ENABLED_SORT :
					doShowExtras = true;
					theSorter.fields = [sortByStatus];
					break;
			}
		}
		
		public function get Sorter ():Sort
		{
			return theSorter;
		}

	}
}

