﻿package  {		import flash.events.Event;		public class DialogEvent extends Event 	{		public static const DONE:String = "pickerDone";				public function DialogEvent( type:String, bubbles:Boolean = false, cancelable:Boolean = false ) 		{			super( type, bubbles, cancelable );		}		override public function clone():Event		{			return new PickerEvent( type, bubbles, cancelable );		}	}}