﻿package  {	import flash.display.MovieClip;		public class Grid extends MovieClip{		public static const XSIZE:int = 25;		public static const YSIZE:int = 20;		var gridArray:Array;		var elementArray:Array;				public function Grid() {			gridArray = new Array();			elementArray = new Array();			buildGround();					}				public function addTile(t:Tile):void {			addChild(t);			if (gridArray[t.gy] == undefined) gridArray [t.gy] = new Array();			gridArray[t.gy][t.gx] = t;		}						public function getTile(gx:int, gy:int):Tile {			return gridArray[gy][gx];		}				public function getTileArray():Array{			return gridArray;		}					public function buildGround():void {			for (var gx:int = 0; gx < XSIZE; gx++){				for(var gy:int = 0 ; gy < YSIZE; gy++){					var t:Tile = new Tile()					t.init(gx,gy);					t.grid = this;					//addObstacle(t);					addTile(t);				}			}		}			}	}