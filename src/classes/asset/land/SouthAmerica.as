package classes.asset.land
{
	import classes.asset.land.Land;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import myEvents.MapSelectEvent;
	
	public class SouthAmerica extends Land
	{		
		public const MAX:uint = 13;
		
		
		public var brasil:MovieClip;
		public var uruguay:MovieClip;
		public var argentina:MovieClip;
		public var chile:MovieClip;
		public var paraguay:MovieClip;
		public var bolivia:MovieClip;
		public var peru:MovieClip;
		public var ecuador:MovieClip;
		public var colombia:MovieClip;
		public var venezuela:MovieClip;
		public var guyana:MovieClip;
		public var suriname:MovieClip;
		public var guyane:MovieClip;

		public var countrys:Array;
		
		private const _X:Number = 104;
		private const _Y:Number = 40;
		private const _SCALE = 0.74;
		
		
		public function SouthAmerica(bool:Boolean=false)
		{
			super(1, "SouthAmerica", _X, _Y, _SCALE, MAX);
			//trace("SouthAmerica");
			if(bool){
				SetName();
				SetAry();
			}
		}
		
		private function SetAry():void
		{
			countrys = [
				brasil,
				uruguay,
				argentina,
				chile,
				paraguay,
				bolivia,
				peru,
				ecuador,
				colombia,
				venezuela,
				guyana,
				suriname,
				guyane
			];
			
			shuffle(countrys);
			InitColor(countrys);
			
		}
				
		private function SetName(){
			brasil._en = "Brazil";
			brasil._ja = "ブラジル";
			uruguay._en = "Uruguay";
			uruguay._ja = "ウルグアイ";
			argentina._en = "Argentina";
			argentina._ja = "アルゼンチン";
			chile._en = "Chile";
			chile._ja = "チリ";
			paraguay._en = "Paraguay";
			paraguay._ja = "パラグアイ";
			bolivia._en = "Bolivia";
			bolivia._ja = "ボリビア";
			peru._en = "Peru";
			peru._ja = "ペルー";
			ecuador._en = "Ecuador";
			ecuador._ja = "エクアドル";
			colombia._en = "Colombia";
			colombia._ja = "コロンビア";
			venezuela._en = "Venezuela";
			venezuela._ja = "ベネズエラ";
			guyana._en = "Guyana";
			guyana._ja = "ガイアナ";
			suriname._en = "Suriname";
			suriname._ja = "スリナム";
			guyane._en = "Guyane";
			guyane._ja = "フランス領ギアナ";
		}
	}
}