﻿package  {		import flash.events.Event;		public class MenuEvent extends Event	{		public static const CLICK:String = "menuClick";				public var label:String = null;				public function MenuEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 		{			super( type, bubbles, cancelable );		}		override public function clone():Event		{			return new MenuEvent( type, bubbles, cancelable );		}	}}