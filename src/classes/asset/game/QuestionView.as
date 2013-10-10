package asset.game
{
	import asset.game.CountryPannel;
	
	import flash.display.DisplayObject;
	import flash.display.Loader;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class QuestionView extends Sprite
	{
		public var pannel0:CountryPannel;
		public var pannel1:CountryPannel;
		public var pannel2:CountryPannel;
		public var pannel3:CountryPannel;
		
		public function QuestionView()
		{
			super();
			this.addEventListener(Event.REMOVED_FROM_STAGE, rFSH, false, 0, true);
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
		
		public function SetMouseEnable(bool:Boolean):void{
			for(var i:uint = 0; i<4; i++)
				this["pannel"+i].mouseEnabled = bool;
		}
		
		public function SetPannel(num:uint, mov:MovieClip, lang:String):void{
			this["pannel"+num].Clear();
			//trace(mov.name, mov._ja);
			//trace("landName(setpannel)", landName);
			//言語設定
			if(lang == "English"){
				this["pannel"+num].SetTex(mov._en); 
			}
			if(lang == "Japanease"){
				this["pannel"+num].SetTex(mov._ja); 
			}
			
			this["pannel"+num].SetImage(mov.img);
		}
		
	}
}