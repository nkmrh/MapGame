package asset.game
{
	import classes.asset.SimpleButton;
	
	import flash.display.DisplayObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class PoseView extends Sprite
	{
		private var _retryButton:SimpleButton;
		private var _returnButton:SimpleButton;
		private var t:ITween;
		
		public var _back:MovieClip;
		
		public function PoseView()
		{
			super();
			
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
			
			this.visible = false;
			this.alpha = 0;
			
			buttonSetting();
			
		}
		
		private function buttonSetting():void
		{
			_retryButton = new SimpleButton("Retry", null, 0.49, 0.69);
			_retryButton.name = "_retryButton";
			_retryButton.x = (320 - _retryButton.width) / 2 ;
			_retryButton.y = 210;
			addChild(_retryButton);
			
			_returnButton = new SimpleButton("Home", null, 0.49, 0.69);
			_returnButton.name = "_returnButton";
			_returnButton.x = (320 - _returnButton.width) / 2 ;
			_returnButton.y = 260;
			addChild(_returnButton);
		}
		
		public function showPose():void{
			this.visible = true;
			checkTween();
			t = BetweenAS3.to(this, {alpha:1}, 0.2);
			t.addEventListener(TweenEvent.COMPLETE, showCompHandler, false, 0, true);
			t.play();
		}
		
		private function showCompHandler(evt:TweenEvent):void{
			evt.target.removeEventListener(TweenEvent.COMPLETE, hideCompHandler);
			evt.target.stop();
		}
		
		public function hidePose():void{
			checkTween();
			t = BetweenAS3.serial(
				BetweenAS3.to(this, {alpha:0}, 0.2),
				BetweenAS3.to(this, {alpha:0}, 0.15)
				);
			t.addEventListener(TweenEvent.COMPLETE, hideCompHandler, false, 0, true);
			t.play();
		}
		
		private function hideCompHandler(evt:TweenEvent):void{
			evt.target.removeEventListener(TweenEvent.COMPLETE, hideCompHandler);
			evt.target.stop();
			this.visible = false;
			this.dispatchEvent(new Event("poseHided"));
		}
		
		private function checkTween():void{
			if(t!=null){
				t.stop();
				t = null;
			}
		}
		
		protected function rFSH(event:Event):void
		{
			this.removeEventListener(Event.REMOVED_FROM_STAGE, rFSH);
			while(numChildren > 0){
				var display:DisplayObject = getChildAt(0);
				removeChild(display);
				display = null;
			}
		}
	}
}