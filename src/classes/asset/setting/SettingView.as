package classes.asset.setting
{
	import classes.asset.SimpleButton;
	import classes.myEvents.LanguageSelectEvent;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	public class SettingView extends Sprite
	{
		public var header:MovieClip;
		
		public var enButton:langButton;
		public var jaButton:langButton;
		
		public var africaButton:langButton;
		public var asiaButton:langButton;
		public var australiaButton:langButton;
		public var europeButton:langButton;
		public var northAmericaButton:langButton;
		public var southAmericaButton:langButton;
		
		private var backButton:SimpleButton;
		
		public function SettingView(lang:String)
		{
			super();
			
			header.field.text = "OPTION";
			
			enButton._tex.text = "English";
			jaButton._tex.text = "Japanease";
			
			if(lang=="English"){
				enButton.check.visible = true;
				jaButton.check.visible = false;
			}else{
				enButton.check.visible = false;
				jaButton.check.visible = true;
			}
			
			africaButton._tex.text = "Africa";
			asiaButton._tex.text = "Asia";
			australiaButton._tex.text = "Australia";
			europeButton._tex.text = "Europe";
			northAmericaButton._tex.text = "North America";
			southAmericaButton._tex.text = "South America";
			
			
			this.addEventListener(LanguageSelectEvent.LANG_SELECTED, langSelectHandler, false, 0, true);
			
			backButton = new SimpleButton("", "arrow", 0.2, 0.4);
			backButton.name = "backButton";
			backButton.x = 271;
			backButton.y = 2;
			addChild(backButton);
		}
		
		protected function langSelectHandler(event:LanguageSelectEvent):void
		{
			if(event.str == "English"){
				enButton.check.visible = true;
				jaButton.check.visible = false;
			}else{
				jaButton.check.visible = true;
				enButton.check.visible = false;
			}
		}
	}
}