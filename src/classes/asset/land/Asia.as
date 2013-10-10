package classes.asset.land
{
	import classes.asset.land.Land;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	
	public class Asia extends Land
	{		
		public const MAX:uint = 44;
		
		
		public var japan:MovieClip;
		public var taiwan:MovieClip;
		public var philippines:MovieClip;
		public var malaysia:MovieClip;
		public var indonesia:MovieClip;
		public var thailand:MovieClip;
		public var cambodia:MovieClip;
		public var vietnam:MovieClip;
		public var laos:MovieClip;
		public var myanmar:MovieClip;
		public var china:MovieClip;
		public var southKorea:MovieClip;
		public var northKorea:MovieClip;
		public var russia:MovieClip;
		public var mongol:MovieClip;
		public var kazakhstan:MovieClip;
		public var kyrgyz:MovieClip;
		public var tajikistan:MovieClip;
		public var uzbekistan:MovieClip;
		public var turkmenistan:MovieClip;
		public var afghanistan:MovieClip;
		public var pakistan:MovieClip;
		public var india:MovieClip;
		public var sriLanka:MovieClip;
		public var bangladesh:MovieClip;
		public var nepal:MovieClip;
		public var bhutan:MovieClip;
		public var iran:MovieClip;
		public var azerbaijan:MovieClip;
		public var georgia:MovieClip;
		public var armenia:MovieClip;
		public var turkey:MovieClip;
		public var syria:MovieClip;
		public var iraq:MovieClip;
		public var lebanon:MovieClip;
		public var cyprus:MovieClip;
		public var israel:MovieClip;
		public var jordan:MovieClip;
		public var saudiArabia:MovieClip;
		public var kuwait:MovieClip;
		public var qatar:MovieClip;
		public var uae:MovieClip;
		public var oman:MovieClip;
		public var yemen:MovieClip;
		
		
		public var countrys:Array;
		
		private const _X:Number = 37;
		private const _Y:Number = 37;
		private const _SCALE = 0.47;
		
				
		public function Asia(bool:Boolean=false)
		{
			super(4, "Asia", _X, _Y, _SCALE, MAX);
			//trace("Asia");
			if(bool){
				SetName();
				SetAry();
			}
			
		}
		
		private function SetAry():void
		{
			countrys = [
				japan,
				taiwan,
				philippines,
				malaysia,
				indonesia,
				thailand,
				cambodia,
				vietnam,
				laos,
				myanmar,
				china,
				southKorea,
				northKorea,
				russia,
				mongol,
				kazakhstan,
				kyrgyz,
				tajikistan,
				uzbekistan,
				turkmenistan,
				afghanistan,
				pakistan,
				india,
				sriLanka,
				bangladesh,
				nepal,
				bhutan,
				iran,
				azerbaijan,
				georgia,
				armenia,
				turkey,
				syria,
				iraq,
				lebanon,
				cyprus,
				israel,
				jordan,
				saudiArabia,
				kuwait,
				qatar,
				uae,
				oman,
				yemen
			];
			shuffle(countrys);
			InitColor(countrys);
		}
		
		private function SetName(){
			japan._en = "Japan";
			japan._ja = "日本";
			taiwan._en = "Taiwan";
			taiwan._ja = "台湾";
			philippines._en = "Philippines";
			philippines._ja = "フィリピン共和国";
			malaysia._en = "Malaysia";
			malaysia._ja = "マレーシア";
			indonesia._en = "Indonesia";
			indonesia._ja = "インドネシア共和国";
			thailand._en = "Thailand";
			thailand._ja = "タイ王国";
			cambodia._en = "Cambodia";
			cambodia._ja = "カンボジア王国";
			vietnam._en = "Vietnam";
			vietnam._ja = "ベトナム";
			laos._en = "Laos";
			laos._ja = "ラオス";
			myanmar._en = "Myanmar";
			myanmar._ja = "ミャンマー";
			china._en = "China";
			china._ja = "中華人民共和国";
			southKorea._en = "South Korea";
			southKorea._ja = "韓国";
			northKorea._en = "North Korea";
			northKorea._ja = "北朝鮮";
			russia._en = "Russia";
			russia._ja = "ロシア";
			mongol._en = "Mongol";
			mongol._ja = "モンゴル";
			kazakhstan._en = "Kazakhstan";
			kazakhstan._ja = "カザフスタン";
			kyrgyz._en = "Kyrgyz";
			kyrgyz._ja = "キルギス";
			tajikistan._en = "Tajikistan";
			tajikistan._ja = "タジキスタン";
			uzbekistan._en = "Uzbekistan";
			uzbekistan._ja = "ウズベキスタン";
			turkmenistan._en = "Turkmenistan";
			turkmenistan._ja = "トルクメニスタン";
			afghanistan._en = "Afghanistan";
			afghanistan._ja = "アフガニスタン";
			pakistan._en = "Pakistan";
			pakistan._ja = "パキスタン";
			india._en = "India";
			india._ja = "インド";
			sriLanka._en = "Sri Lanka";
			sriLanka._ja = "スリランカ";
			bangladesh._en = "Bangladesh";
			bangladesh._ja = "バングラデシュ";
			nepal._en = "Nepal";
			nepal._ja = "ネパール";
			bhutan._en = "Bhutan";
			bhutan._ja = "ブータン";
			iran._en = "Iran";
			iran._ja = "イラン";
			azerbaijan._en = "Azerbaijan";
			azerbaijan._ja = "アゼルバイジャン";
			georgia._en = "Georgia";
			georgia._ja = "グルジア";
			armenia._en = "Armenia";
			armenia._ja = "アルメニア";
			turkey._en = "Turkey";
			turkey._ja = "トルコ";
			syria._en = "Syria";
			syria._ja = "シリア";
			iraq._en = "Iraq";
			iraq._ja = "イラク";
			lebanon._en = "Lebanon";
			lebanon._ja = "レバノン";
			cyprus._en = "Cyprus";
			cyprus._ja = "キプロス";
			israel._en = "Israel";
			israel._ja = "イスラエル";
			jordan._en = "jordan";
			jordan._ja = "ヨルダン";
			saudiArabia._en = "Saudi Arabia";
			saudiArabia._ja = "サウジアラビア";
			kuwait._en = "Kuwait";
			kuwait._ja = "クウェート";
			qatar._en = "Qatar";
			qatar._ja = "カタール";
			uae._en = "UAE";
			uae._ja = "アラブ首長国連邦";
			oman._en = "Oman";
			oman._ja = "オマーン";
			yemen._en = "Yemen";
			yemen._ja = "イエメン";
		}
	}
}