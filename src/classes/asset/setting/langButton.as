package classes.asset.setting
{
	import classes.myEvents.LanguageSelectEvent;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.events.Event;
	
	
	public class langButton extends Sprite
	{
		public var _tex:TextField;
		public var down:MovieClip;
		public var up:MovieClip;
		public var check:MovieClip;
		
		public function langButton()
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH);
			check.visible = false;
			//trace(name);
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler, false, 0, true);
			down.visible = false;
		}
		
		protected function outHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler, false, 0, true);
			down.visible = false;
		}
		
		protected function upHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, downHandler, false, 0, true);
			down.visible = false;
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, outHandler, false, 0, true);
			down.visible = true;
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			if(name == "enButton" || name == "jaButton"){
				this.dispatchEvent(new LanguageSelectEvent(LanguageSelectEvent.LANG_SELECTED, _tex.text));
			}else{
				this.dispatchEvent(new LanguageSelectEvent(LanguageSelectEvent.LIST_NAME, _tex.text));
			}
		}
		
		protected function rFSH(event:Event):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, downHandler);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, rFSH);
			while(numChildren > 0){
				var display:DisplayObject = getChildAt(0);
				//trace(display);
				removeChild(display);
				display = null;
			}
		}
	}
}