package myEvents
{
	import flash.events.Event;
	
	public class SimpleButtonSelectEvent extends Event
	{
		public static const SIMPLE_SELECTED:String = "simple_selected";
		
		private var _name:String = "none";
		
		public function get getName():String {
			return _name;
		}
		
		public function SimpleButtonSelectEvent(type:String, name:String="none")
		{
			super(type, true);
			_name = name;
		}
		
		public override function clone():Event{
			return new SimpleButtonSelectEvent(type, _name);
		}
	}
}