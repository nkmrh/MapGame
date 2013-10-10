package myEvents
{
	import flash.events.Event;
	
	public class PannelSelectEvent extends Event
	{
		public static const PANNEL_SELECTED:String = "pannel_selected";
		
		private var _pannelName:String = "none";
		
		public function get pannelName():String {
			return _pannelName;
		}
		
		public function PannelSelectEvent(type:String, name:String="none")
		{
			super(type, true);
			_pannelName = name;
		}
		
		public override function clone():Event{
			return new PannelSelectEvent(type, _pannelName);
		}
	}
}