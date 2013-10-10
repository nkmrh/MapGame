package classes.asset.count
{
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class CountView extends Sprite
	{
		public var one:MovieClip;
		public var two:MovieClip;
		public var three:MovieClip;
		
		private var tween:ITween;
		
		public function CountView()
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
			one.alpha = 0;
			two.alpha = 0;
			three.alpha = 0;
		}
		
		public function startCount():void
		{
			tween = BetweenAS3.delay(BetweenAS3.serial(
				BetweenAS3.to(three, {alpha:1}, 0.5, Cubic.easeOut),
				BetweenAS3.to(three, {alpha:0}, 0.5, Cubic.easeOut),
				BetweenAS3.to(two, {alpha:1}, 0.5, Cubic.easeOut),
				BetweenAS3.to(two, {alpha:0}, 0.5, Cubic.easeOut),
				BetweenAS3.to(one, {alpha:1}, 0.5, Cubic.easeOut),
				BetweenAS3.to(one, {alpha:0}, 0.5, Cubic.easeOut)
				), 0.5);
			tween.addEventListener(TweenEvent.COMPLETE, tweenCompleteHandler, false, 0, true);
			tween.play();
		}
		
		private function tweenCompleteHandler(event:TweenEvent):void{
			tween.removeEventListener(TweenEvent.COMPLETE, tweenCompleteHandler);
			tween.stop();
			tween = null;
			this.dispatchEvent(new Event("countEnd"));
		}
		
		protected function rFSH(event:Event):void
		{
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