package myEvents
{
	import flash.events.Event;
	
	public class ClearEvent extends Event
	{
		public static const CLEAR:String = "clear";
		
		private var _maruCount:uint;
		private var _batuCount:uint;
		private var _flag:Boolean;
		
		public function get maruCount():uint{
			return _maruCount;
		}
		
		public function get batuCount():uint{
			return _batuCount;
		}
		
		public function get flag():Boolean{
			return _flag;
		}
		
		public function ClearEvent(type:String, maruCount:uint, batuCount:uint, flag:Boolean)
		{
			super(type, true);
			_maruCount = maruCount;
			_batuCount = batuCount;
			_flag = flag;
		}
	}
}