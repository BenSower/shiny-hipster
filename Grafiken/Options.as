﻿package  {		import flash.display.MovieClip;	import flash.events.MouseEvent;	import flash.events.Event;		public class Options extends MovieClip {						public function Options() {			trace("options erzeugt");			addEventListener(MouseEvent.MOUSE_UP, controller.optionsClickHandler);		}	}	}