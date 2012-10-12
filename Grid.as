﻿package  {	import flash.display.MovieClip;		public class Grid extends MovieClip{		public static const XSIZE:int = 23;		public static const YSIZE:int = 17;		var tilesmc:MovieClip;		var obstaclemc:MovieClip;		var gridArray:Array;		var elementArray:Array;				public function Grid() {			tilesmc = new MovieClip();			addChild(tilesmc);			obstaclemc = new MovieClip();			addChild(obstaclemc);			gridArray = new Array();			elementArray = new Array();			buildBackground();			buildGround();			this.scaleX = this.scaleY = 0.35;					}				public function addTile(t:Tile):void {			tilesmc.addChild(t);			if (gridArray[t.gy] == undefined) gridArray [t.gy] = new Array();			gridArray[t.gy][t.gx] = t;		}						public function getTile(gx:int, gy:int):Tile {			return gridArray[gy][gx];		}				public function getTileArray():Array{			return gridArray;		}						public function buildGround():void {			for (var gx:int = 0; gx < XSIZE; gx++){				for(var gy:int = 0 ; gy < YSIZE; gy++){					var t:Tile = new Tile();					t.gotoAndStop(1);					t.init(gx,gy);					t.grid = this;					//addObstacle(t);					addTile(t);				}			}					}				public function buildBackground():void {						for (var gx:int = 0; gx < XSIZE; gx++){				for(var gy:int = 0 ; gy < YSIZE; gy++){					var t:TileBackground = new TileBackground();					t.init(gx,gy);					t.grid = this;					tilesmc.addChild(t);				}			}					}			}	}