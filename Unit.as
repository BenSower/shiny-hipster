﻿package  {		public class Unit extends Element{		var tintElements:Array;		var playerId:int;		var walkPath:Node;		static const FRAMES_PER_FIELD:int = 14;		var frame: int;		var unitId:int;		var didRun:Boolean = true;		var cost:int;				public function Unit() {			// constructor code		}				public override function walk():void{			if (walkPath==null){				//didRun = false;				return;			}						//didRun = true;						var perc:Number = frame/FRAMES_PER_FIELD;			var currentTile = tile.grid.getTile(walkPath.x,walkPath.y);			var nextTile:Tile = tile.grid.getTile(walkPath.preNode.x,walkPath.preNode.y);			var dx:Number = (nextTile.x - currentTile.x);			var dy:Number = (nextTile.y - currentTile.y);						if (frame==FRAMES_PER_FIELD/2){				tile.grid.getTile(walkPath.preNode.x,walkPath.preNode.y).setElement(this);				currentTile.popElement();				currentTile.obstacle = null;			}			if (frame > FRAMES_PER_FIELD){				frame=0;				walkPath= walkPath.preNode;				if (walkPath.preNode == null) {					walkPath = walkPath.preNode;					//dispatchEvent(new PlayerEvent(PlayerEvent.REACHED,this));					return;				}			}else if (frame >= FRAMES_PER_FIELD/2){				x = nextTile.x-dx*(1-perc);				y = nextTile.y-dy*(1-perc);							}else { //erste hälfte				x = currentTile.x+dx*perc;				y = currentTile.y+dy*perc;			}			frame++;				}				public function gotoTarget(targetX:int,targetY:int, stepsLeft:int):Node {			var node:Node = Dijkstra.routeFromTo(targetX, targetY, tile.gx,tile.gy, tile.grid);			if(node.cost/2 > stepsLeft){				if(Model.soundOn){					var beebSound:SoundPlayer = new SoundPlayer();					beebSound.playSound("BeebSound");				}				node = null;							}			if (node== null){				trace("Weg nicht möglich");			} else {				setWalkPath(node);			}			return node;		}				public function setWalkPath(n:Node):void{			this.walkPath = n;			frame=0;			tile.grid.getTile(walkPath.x, walkPath.y).setElement(this);		}	}	}