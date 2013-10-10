package myEvents
{
	import flash.events.Event;
	
	public class MapSelectEvent extends Event
	{
		public static const SELECTED:String = "selected";
		private var _d:Object;
		
		public function get gd():Object {
			return _d;
		}
				
		public function MapSelectEvent(type:String, data:Object)
		{
			super(type, true);
			_d = data;
		}
		
		public override function clone():Event{
			return new MapSelectEvent(type, _d);
		}
	}
}