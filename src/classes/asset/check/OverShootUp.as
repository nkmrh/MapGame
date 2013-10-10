package classes.asset.check
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.Event;
	
	public class OverShootUp extends Sprite
	{
		public function OverShootUp()
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
	}
}