﻿package classes.asset.check
	
		{
			event.target.removeEventListener(MouseEvent.MOUSE_DOWN, mDown);
		}
		protected function mUp(event:MouseEvent):void
		{
			event.target.removeEventListener(MouseEvent.MOUSE_UP, mUp);
		}
		
		{
			event.target.removeEventListener(MouseEvent.MOUSE_OUT, mOut);
		}
		{
			webView.stage = this.stage;
		}