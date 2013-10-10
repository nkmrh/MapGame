package asset.game
{
	import classes.asset.SimpleButton;
	import classes.asset.Wrap;
	import classes.asset.count.CountView;
	
	import flash.display.DisplayObject;
	import flash.display.Graphics;
	import flash.display.Loader;
	import flash.display.LoaderInfo;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.ProgressEvent;
	import flash.events.TimerEvent;
	import flash.geom.Matrix;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;
	
	import myEvents.ClearEvent;
	import myEvents.PannelSelectEvent;
	import myEvents.SimpleButtonSelectEvent;
	
	import org.libspark.betweenas3.BetweenAS3;
	import org.libspark.betweenas3.easing.*;
	import org.libspark.betweenas3.events.TweenEvent;
	import org.libspark.betweenas3.tweens.IObjectTween;
	import org.libspark.betweenas3.tweens.ITween;
	
	public class GameView extends Sprite
	{
		public var questionView:QuestionView;
		public var timerBar:TimerBar;
		public var poseView:PoseView;
		public var poseButton:SimpleButton;
		public var header:MovieClip;
		
		private var MAP_CENTER_X:Number;
		private var MAP_CENTER_Y:Number;
		private var _landData:Object;
		private var _count:uint;
		private var _maruCount:uint;
		private var _batuCount:uint;
		private var _myLand:*;
		private var _answer:uint;
		private var _landName;
		private var _tween:ITween;
		private var timer:Timer;
		private var mtr:Matrix;
		private var _lang:String;
		private var _clearFlag:Boolean = false;
		private var countView:CountView;
		private var loadedCount:uint = 0;
		private var savedMatrix:Matrix;
		private var poseFlag:Boolean = false;
		private var mapMask:Sprite;

		private var okSnd:Sound;
		private var ngSnd:Sound;
		
		
		public function GameView(data:Object, lang:String)
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
			//mask set
			mapMask = new Sprite();
			var g:Graphics = mapMask.graphics;
			g.beginFill(0x000000, 1);
			g.drawRect(0, 30, 320, 200);
			mapMask.visible = false;
			addChild(mapMask);
			
			//header set
			header.field.text = data._name;
			_landData = data;
			_lang = lang;
			//pose button set
			poseButton = new SimpleButton("", "recycle", 0.2, 0.4);
			poseButton.name = "poseButton";
			poseButton.x = 10;
			poseButton.y = 2;
			addChild(poseButton);
			
			createCountView();
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
		
		public function poseClick():void
		{
			if(!poseFlag){
				poseView.showPose();
				poseFlag = true;
			}else{
				poseView.hidePose();
				poseFlag = false;
			}
			timerBar.togglePause();
			if(_tween != null){
				_tween.togglePause();
			}
		}
		
		public function Init():void
		{
			var cpath:String = "classes.asset.land.";
			cpath = cpath.concat(_landData._name);
			//trace("cpath", cpath);
			var ClassRef:Class = getDefinitionByName(cpath) as Class;
			_myLand = new ClassRef(true);
			setMyLand();
			//_myLandをセットしてからセンターを保存
			MAP_CENTER_X = _myLand.x + (_myLand.width/2);
			MAP_CENTER_Y = _myLand.y + (_myLand.height/2);
			addChildAt(_myLand, 1);
			//reset
			resetGame();
			//flag load
			this.addEventListener(Event.ENTER_FRAME, tweenCheckEnterFrame, false, 0, true);
			//mask
			_myLand.mask = mapMask;
			//Sound load
			okSnd = new Sound();
			okSnd.load(new URLRequest("/data/sound/ok.mp3"));
			ngSnd = new Sound();
			ngSnd.load(new URLRequest("/data/sound/ng.mp3"));
		}
		
		
		
		private function setMyLand():void
		{
			_myLand.x = _landData._x;
			_myLand.y = _landData._y;
			_myLand.scaleX = _myLand.scaleY = _landData._s;
			_myLand.mouseEnabled = false;
			_myLand.mouseChildren = false;
		}
		
		public function resetGame():void
		{
			_clearFlag = false;
			if(_tween != null){
				_tween.stop();
				_tween = null;
			}
			_count = (_myLand.MAX - 1);
			//_count = 1; //デバッグ用ほんとうは↑
			_maruCount = 0;
			_batuCount = 0;
			questionView.mouseChildren = true;
			questionView.SetMouseEnable(true);
			_myLand.InitColor(_myLand.countrys);
			//シャッフル
			_myLand.shuffle(_myLand.countrys);
			//(Initと共通)
			setMyLand();
		}
		
		private function countryFlagImageLoad():void
		{
			
			for(var i:uint = 0; i < _myLand.countrys.length; i++){
				var url:String = "data/nation_flag/"+String(_landData._name)+"/"+String(_myLand.countrys[i].name)+".gif";
				var urlreq:URLRequest = new URLRequest(url);
				var loader:Loader = new Loader();
				loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loadCompHandler, false, 0, true);
				loader.load(urlreq);
				_myLand.countrys[i].img = loader;
			}
		}
		
		protected function loadCompHandler(event:Event):void
		{
			event.target.removeEventListener(Event.COMPLETE, loadCompHandler);
			loadedCount++;
			if(loadedCount == _landData._max){
				countView.startCount();
			}
		}
		
		protected function tweenCheckEnterFrame(event:Event):void
		{
			if(Wrap(parent).tweenCompFlag){
				this.removeEventListener(Event.ENTER_FRAME, tweenCheckEnterFrame);
				countryFlagImageLoad();
			}
		}
		
		public function createCountView(startFlag:Boolean=false):void
		{
			//count view set
			if(getChildByName("countView")){
				removeChild(countView);
				countView = null;
			}
			countView = new CountView();
			countView.name = "countView";
			addChild(countView);
			countView.addEventListener("countEnd", countEndHandler, false, 0, true);
			if(startFlag){
				countView.startCount();
			}
		}
		
		protected function countEndHandler(event:Event):void
		{
			countView.removeEventListener("countEnd", countEndHandler);
			removeChild(countView);
			countView = null;
			SetQ();
			this.addEventListener(PannelSelectEvent.PANNEL_SELECTED, pannelSelectHandler, false, 0, true);
			timerBar.TimerStart(_landData._max);
		}
		
		private function SetQ():void
		{
			//trace(_answer);
			var num0:Number;
			var num1:Number;
			var num2:Number;
			var num3:Number;
			
			_answer = Math.floor(Math.random() * 4);
			questionView.SetPannel(_answer, _myLand.countrys[_count], _lang);
			
			_myLand.SetColor(_myLand.countrys, _count, 0, 204, 255);
			//問題の国を一番上にする
			_myLand.addChild(_myLand.countrys[_count]);			
			
			if(_answer != 0){
				do{
					num0 = Math.floor(Math.random() * (_myLand.MAX - 1));
				}while(num0 == _count);
				questionView.SetPannel(0, _myLand.countrys[num0], _lang);
			}
			
			if(_answer != 1){
				do{
					num1 = Math.floor(Math.random() * (_myLand.MAX - 1));
				}while(num1 == _count || num1 == num0);
				questionView.SetPannel(1, _myLand.countrys[num1], _lang);
			}
			
			if(_answer != 2){
				do{
					num2 = Math.floor(Math.random() * (_myLand.MAX - 1));
				}while(num2 == _count || num2 == num0 || num2 == num1);
				questionView.SetPannel(2, _myLand.countrys[num2], _lang);
			}
			
			if(_answer != 3){
				do{
					num3 = Math.floor(Math.random() * (_myLand.MAX - 1));
				}while(num3 == _count || num3 == num0 || num3 == num1 || num3 == num2);
				questionView.SetPannel(3, _myLand.countrys[num3], _lang);
			}
			
			zoomInAnimation(_count);
		}
	
		private function zoomInAnimation(c:uint):void{
			var mc:MovieClip = _myLand.countrys[c];
			mtr  = mc.transform.matrix;
			if(_tween != null){
				_tween.stop();
				_tween = null;
			}
			var leng:Number = Math.max(mc.width, mc.height);
			if(leng<100){
				var s:Number = (100 / leng * _landData._s);
				_tween = BetweenAS3.to(_myLand, {transform:{matrix:{a:s, b:0, c:0, d:s, tx:MAP_CENTER_X - (mc.x*s) - (mc.width/2*s), ty:MAP_CENTER_Y - (mc.y*s) - (mc.height/2*s)}}}, 7*s);
				_tween.addEventListener(TweenEvent.COMPLETE, tweenCompHandler, false, 0, true);
				_tween.play();
			}
		}
	
		private function zoomOutAnimation():void
		{
			if(_tween != null){
				_tween.stop();
				_tween = null;
			}
			_tween = BetweenAS3.to(_myLand, {transform:{matrix:{a:_landData._s, b:0, c:0, d:_landData._s, tx:_landData._x, ty:_landData._y}}}, 0.2);
			_tween.addEventListener(TweenEvent.COMPLETE, tweenCompHandler, false, 0, true);
			_tween.play();
		}
		
	
		private function tweenCompHandler(event:TweenEvent):void
		{
			_tween.removeEventListener(TweenEvent.COMPLETE, tweenCompHandler);
			_tween.stop();
			_tween = null;
		}
		
		protected function pannelSelectHandler(event:PannelSelectEvent):void
		{
			//trace(event.pannelName);
			var pannel_name:String = event.pannelName;
			var answer_name:String = String("pannel" + _answer);
			if(pannel_name == answer_name){
				//ok
				questionView.mouseChildren = false;
				playSound(true);
				event.target.ShowMaru();
				Rate();
				_maruCount++;
				zoomOutAnimation();
				_myLand.SetColor(_myLand.countrys, _count, 67, 154, 34);
				//国を一番下にする
				_myLand.setChildIndex(_myLand.getChildAt(_myLand.numChildren - 1), 0);
			}else{
				//ng
				event.target.mouseEnabled = false;
				event.target.mouseChildren = false;
				playSound(false);
				event.target.ShowBatu();
				_batuCount++;
			}
		}
		
		

		private function playSound(param0:Boolean):void
		{
			if(param0){
				okSnd.play();
			}else{
				ngSnd.play();
			}
		}
		
		private function Rate():void
		{
			timer = new Timer(200);
			timer.addEventListener(TimerEvent.TIMER, timerHandler, false, 0, true);
			timer.start();
		}
		
		protected function timerHandler(event:TimerEvent):void
		{
			if(_count > 0){
				//next
				_count--;
				SetQ();
				questionView.mouseChildren = true;
				questionView.SetMouseEnable(true);
				
			}else{
				//game end
				_clearFlag = true;
				GameEnd();
			}
			event.target.removeEventListener(TimerEvent.TIMER, timerHandler);
			event.target.stop();
		}
	
		public function GameEnd():void
		{
			this.removeEventListener(PannelSelectEvent.PANNEL_SELECTED, pannelSelectHandler);
			if(timer != null){
				timer.stop();
			}
			timerBar.TimerStop();
			this.dispatchEvent(new ClearEvent(ClearEvent.CLEAR, _maruCount, _batuCount, _clearFlag));
			questionView.mouseChildren = false;
		}
		
		public function gameHide():void{
			if(_tween != null){
				_tween.stop();
				_tween = null;
			}
			_tween = BetweenAS3.serial(
				BetweenAS3.delay(BetweenAS3.to(this, {alpha:0}, 0.2),0.3),
				BetweenAS3.to(this, {alpha:0}, 0.15)
			);
			_tween.addEventListener(TweenEvent.COMPLETE, hideCompHandler, false, 0, true);
			_tween.play();
		}
		
		private function hideCompHandler(evt:TweenEvent):void{
			evt.target.removeEventListener(TweenEvent.COMPLETE, hideCompHandler);
			evt.target.stop();
			this.dispatchEvent(new Event("gameHided"));
		}
		
	}
}