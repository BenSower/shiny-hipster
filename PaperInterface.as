﻿package  {	import flash.display.SimpleButton;	import flash.display.DisplayObject;		public class PaperInterface extends SimpleButton{				public function PaperInterface(gx: Number, gy: Number) {			this.x = gx;			this.y = gy;			this.scaleX = this.scaleY = 0.3;		}				public function enableButton():void{			this.enabled = true;		}				public function disableButton():void{			this.enabled = false;		}	}	}