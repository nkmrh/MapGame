package classes.asset
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	
	import flashx.textLayout.operations.MoveChildrenOperation;
	
	import myEvents.SimpleButtonSelectEvent;
	
	
	public class SimpleButton extends Sprite
	{
		public var _tex:TextField;
		public var down:MovieClip;
		public var up:MovieClip;
		public var hit:MovieClip;
		public var arrow:MovieClip;
		public var recycle:MovieClip;
		public var work:MovieClip;
		
		public function SimpleButton(tex:String, icon:String=null, sx:Number=1, sy:Number=1)
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
			_tex.text = tex;
			_tex.scaleX = sx;
			_tex.scaleY = sy;
			down.scaleX = sx;
			down.scaleY = sy;
			up.scaleX = sx;
			up.scaleY = sy;
			hit.scaleX = sx;
			hit.scaleY = sy;
			_tex.x = (hit.width - _tex.width) / 2;
			_tex.y = (hit.height - _tex.height) / 2;
			
			arrow.visible = false;
			recycle. visible = false;
			work.visible = false;
			
			mouseChildren = false;
			buttonMode = true;
			down.visible = false;
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			this.addEventListener(MouseEvent.CLICK, mouseClickHandler, false, 0, true);
			
			if(icon!=null){
				switch(icon){
					case "arrow":
						arrow.visible = true;
						setIconPos(arrow);
						break;
					case "recycle":
						recycle.visible = true;
						setIconPos(recycle);
						break;
					case "work":
						work.visible = true;
						setIconPos(work);
						break;
					default:
						//nothing
						break;
				}
			}
		}
		
		private function setIconPos(mc:MovieClip):void
		{
			mc.x = (hit.width - mc.width)/2;
			mc.y = (hit.height - mc.height)/2;
		}
		
		protected function mouseClickHandler(event:MouseEvent):void
		{
			//trace("name", name);
			this.dispatchEvent(new SimpleButtonSelectEvent(SimpleButtonSelectEvent.SIMPLE_SELECTED, name));
		}
		
		protected function mouseUpHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			down.visible = false;
		}
		
		protected function mouseDownHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, mouseUpHandler, false, 0, true);
			this.addEventListener(MouseEvent.ROLL_OUT, mouseOutHandler, false, 0, true);
			down.visible = true;
		}
		
		protected function mouseOutHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler, false, 0, true);
			down.visible = false;
		}
		
		protected function rFSH(event:Event):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mouseDownHandler);
			this.removeEventListener(MouseEvent.CLICK, mouseClickHandler);
			this.removeEventListener(MouseEvent.ROLL_OUT, mouseOutHandler);
			this.removeEventListener(MouseEvent.MOUSE_UP, mouseUpHandler);
			
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