package asset.game
{
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.URLRequest;
	import flash.text.TextField;
	import flash.text.TextFieldAutoSize;
	import flash.text.TextFormat;
	
	import myEvents.PannelSelectEvent;
	
	
	public class CountryPannel extends Sprite
	{
		public var tex:TextField;
		public var _maru:MovieClip;
		public var _batu:MovieClip;
		private var loader:Loader;
		
		public function CountryPannel()
		{
			super();
			
			_maru.visible = false;
			_batu.visible = false;
			this.buttonMode = true;
			this.tex.mouseEnabled = false;
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN, mdown, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
		}
		
		protected function rFSH(event:Event):void
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mdown);
			this.removeEventListener(MouseEvent.MOUSE_UP, mup);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mout);
			this.removeEventListener(Event.REMOVED_FROM_STAGE, rFSH);
			while(numChildren > 0){
				var display:DisplayObject = getChildAt(0);
				//trace(display);
				removeChild(display);
				display = null;
			}
		}
		
		protected function mdown(event:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_UP, mup, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, mout, false, 0, true);
			this.removeEventListener(MouseEvent.MOUSE_DOWN, mdown);
			alpha = 0.6;
		}		
		
		protected function mout(event:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mdown, false, 0, true);
			this.removeEventListener(MouseEvent.MOUSE_OUT, mout);
			alpha = 1;
		}
		
		protected function mup(event:MouseEvent):void
		{
			this.addEventListener(MouseEvent.MOUSE_DOWN, mdown, false, 0, true);
			this.removeEventListener(MouseEvent.MOUSE_UP, mup);
			alpha = 1;
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new PannelSelectEvent(PannelSelectEvent.PANNEL_SELECTED, this.name));
		}
		
		public function ShowMaru(){
			_maru.visible = true;
		}
		
		public function ShowBatu(){
			_batu.visible = true;
		}
		
		public function Clear(){
			_maru.visible = false;
			_batu.visible = false;
			if(this.getChildByName("myloader")){
				removeChild(loader);
				loader = null;
			}
		}
		
		public function SetTex(str:String){
			var texFormat:TextFormat = new TextFormat("_sans", 10);
			tex.text = String(str);
			tex.setTextFormat(texFormat);
		}
		
		public function SetImage(img:Loader):void{
			loader = new Loader();
			loader = img;
			loader.x = (112 - loader.width) / 2;
			loader.y = (75 - loader.height) / 2;
			loader.name = "myloader";
			addChildAt(loader, 1);
		}
	}
}