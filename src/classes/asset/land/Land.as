package classes.asset.land
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.utils.ByteArray;
	
	import myEvents.MapSelectEvent;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class Land extends Sprite
	{
		public var data:Object;
		public var scale:Number;
		public var point:Point = new Point();
		
		public function Land(id:uint, name:String, x:Number, y:Number, s:Number, max:uint)
		{
			super();
			data = {_id:id, _name:name, _x:x, _y:y, _s:s, _max:max}
			this.cacheAsBitmap = true;
			this.buttonMode = true;
			this.addEventListener(MouseEvent.CLICK, clickHandler, false, 0, true);
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_DOWN,downHandler, false, 0, true);
		}
		
		protected function downHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_DOWN,downHandler);
			this.addEventListener(MouseEvent.MOUSE_UP, upHandler, false, 0, true);
			this.addEventListener(MouseEvent.MOUSE_OUT, outHandler, false, 0, true);
			colorChange(0, 102, 0);
		}
		
		protected function outHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_OUT, outHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,downHandler, false, 0, true);
			colorChange(0, 153, 0);
		}
		
		protected function upHandler(event:MouseEvent):void
		{
			this.removeEventListener(MouseEvent.MOUSE_UP, upHandler);
			this.addEventListener(MouseEvent.MOUSE_DOWN,downHandler, false, 0, true);
			colorChange(0, 153, 0);
		}
		
		public function shuffle(a:Array):void{
			var num = a.length;	// 配列の数
			var i;
			for(i=0;i < num;i++){
				// ランダムな番地を取得
				var r = Math.floor(Math.random() * num);
				
				// i とランダムな番地の中身を入れ替え
				var t = a[r];
				a[r] = a[i];
				a[i] = t;
			}
		}
		
		protected function clickHandler(event:MouseEvent):void
		{
			this.dispatchEvent(new MapSelectEvent(MapSelectEvent.SELECTED, data));
		}
		
		private function colorChange(red:uint, green:uint, blue:uint):void
		{
			var col:ColorTransform = new ColorTransform(0, 0, 0, 1, red, green, blue, 1);
			this.transform.colorTransform = col;
		}
		
		public function InitColor(a:Array = null):void{
			if(a!=null){
				for each(var prop in a) { 
					var ctf:ColorTransform = new ColorTransform(1, 1, 1, 1, 0, 0, 0, 1);
					prop.transform.colorTransform = ctf;
				}
			}
		}
		
		public function SetColor(a:Array, num:String, red:uint, green:uint, blue:uint):void
		{
			if(num!=null){
				var ctf2:ColorTransform = new ColorTransform(0, 0, 0, 1, red, green, blue, 1);
				a[num].transform.colorTransform = ctf2;
			}
		}
		
		protected function rFSH(event:Event):void
		{
			this.removeEventListener(MouseEvent.CLICK, clickHandler);
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