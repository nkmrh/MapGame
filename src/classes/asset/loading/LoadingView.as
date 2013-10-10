package classes.asset.loading
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.geom.*;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.utils.Timer;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class LoadingView extends Sprite
	{
		private var pcontainer:Sprite;
		private const ANIMATION_IN_SPEED:Number = 0.16;
		private const ANIMATION_OUT_SPEED:Number = ANIMATION_IN_SPEED*4;
		private const ANIMATION_NONE_SPEED:Number = ANIMATION_IN_SPEED*4;
		private const INTERVAL:Number = ((ANIMATION_IN_SPEED + ANIMATION_OUT_SPEED + ANIMATION_NONE_SPEED)*1000)/13;
		
		private var a:Array = new Array();
		
		public function LoadingView()
		{
			super();
			
			var bg:Sprite = new Sprite();
			with (bg.graphics)
			{
				beginFill(0x333333, 1);
				drawRect(0, 0, 320, 480);
			}
			addChild(bg);
			
			var tex:TextField = new TextField();
			tex.text = "Loading...";
			var texFormat0:TextFormat = new TextFormat("_sans", 50, 0x00CCFF, true);
			tex.setTextFormat(texFormat0);
			tex.width = tex.textWidth;
			tex.height = tex.textHeight + 50;
			tex.x = (320 - tex.width) / 2;
			tex.y = (480 - tex.height) / 2;
			addChild(tex);
			
			
			
			pcontainer = new Sprite();
			pcontainer.x = (bg.width-100) / 2 + 50;
			pcontainer.y = (bg.height-100) / 2 + 0;//(+25)で中央
			addChild(pcontainer);
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
		}
		
		public function playAnimation():void{
			var timer:Timer = new Timer(INTERVAL, 12);
			timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
			timer.addEventListener(TimerEvent.TIMER_COMPLETE, timerCompHandler, false, 0, true);
			timer.start();
		}
		
		private function timerHandler(event:TimerEvent):void{
			var c:uint = event.target.currentCount;
			var p:Sprite = new Sprite();
			with (p.graphics)
			{
				beginFill(0xFFFFFF, 1);
				drawRoundRect(-4, -50, 8, 22, 8);
			}
			
			p.rotation = (c-1) * 30;
			p.alpha = 0;
			
			var t:ITween = BetweenAS3.serial(
				BetweenAS3.to(p, {alpha:0.5}, ANIMATION_IN_SPEED),
				BetweenAS3.to(p, {alpha:0}, ANIMATION_OUT_SPEED),
				BetweenAS3.to(p, {alpha:0}, ANIMATION_NONE_SPEED)
			);
			
			t.stopOnComplete = false;
			t.play();
			a.push(t);
			
			pcontainer.addChild(p);
		}
		
		private function timerCompHandler(event:TimerEvent):void{
			event.target.removeEventListener(TimerEvent.TIMER, timerHandler);
			event.target.removeEventListener(TimerEvent.TIMER_COMPLETE, timerCompHandler);
			//trace(pcontainer.width, pcontainer.height);
		}
		
		protected function rFSH(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, rFSH);
			while (numChildren > 0)
			{
				var display:DisplayObject = getChildAt(0);
				//trace(display);
				removeChild(display);
				display = null;
			}
			//メモリ漏れ防止
			for each(var prop in a){
				prop.stopOnComplete = true;
				prop.stop();
				prop = null;
			}
		}
	}
}