﻿package{	import com.adobe.licensing.LicenseManager;	import classes.asset.Wrap;		import flash.display.MovieClip;	import flash.display.Sprite;		//import com.flashdynamix.utils.SWFProfiler;			public class MapGame extends Sprite	{		public var wrap:Wrap;				/* replace the value below with your own application key */		private static const MY_APPLICATION_KEY:String = "E1A89413-8D90-1FD4-4F53-EC3C7AB9EE34";		private static var DEBUG_MODE:Boolean = false;		private static var UPDATE_MODE:Boolean = true;				public function MapGame()		{			super();			//SWFProfiler.init(stage, this, true);						//var licenseManager:LicenseManager = new LicenseManager();			//licenseManager.checkLicense( this, MY_APPLICATION_KEY, UPDATE_MODE, DEBUG_MODE );		}	}}