﻿package  {		import flash.display.MovieClip;	import flash.events.Event;		public class Model {				var grid:Grid;		var units:Array;				public function Model() {			this.grid = new Grid();			this.units = new Array;		}				public function walkAll():void{			//array mit effektiv ausgewählten einheiten?						for each (var e:Element in grid.elementArray){				e.walk();			}					}				public function getGrid():Grid{			return grid;		}				public function createUnit(type:String):Unit{			var unit:Unit;						switch(type){				case "rock": 	unit = new Rock();				case "paper":	unit = new Paper();				case "scissor": unit = new Scissor();			}			this.units.push(unit)			trace("Unit of type " + type+ " constructed");			return unit;					}	}	}