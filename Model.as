﻿package  {		import flash.display.MovieClip;	import flash.events.Event;		public class Model {				var grid:Grid;				public function Model(g:Grid) {						this.grid = g;			var r:Rock = new Rock();			var scissor:Scissor = new Scissor();			grid.getTile(24,0).setElement(scissor);			grid.getTile(0,19).setElement(r);		}					}	}