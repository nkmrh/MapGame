package classes.myEvents
{
	import flash.events.Event;
	
	public class LanguageSelectEvent extends Event
	{
		public static const LANG_SELECTED:String = "lang_selected";
		public static const LIST_NAME:String = "list_name";
		private var _str:String;
		
		
		public function get str():String {
			return _str;
		}
		
		public function LanguageSelectEvent(type:String, str:String)
		{
			super(type, true);
			_str = str;
		}
		
		public override function clone():Event{
			return new LanguageSelectEvent(type, _str);
		}
	}
}