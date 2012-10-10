﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.display.DisplayObjectContainer;		public class Tile extends MovieClip {		static const SCALE:Number = 1;		var gx:int;		var gy:int;		var grid:Grid;		var element:Element;		var obstacle:Obstacle;		var elementStack: Array;		var owner:int = -1;				public function Tile() {			elementStack = new Array();					}				public function init(gx:int,gy:int):void{			this.gx = gx;			this.gy = gy;						scaleX = SCALE;			scaleY = SCALE;			x = gx*width;			y = gy*height;		}				public function createElement(e:Unit):void{			grid.elementArray.push(e);			setElement(e);		}				public function setElement(e:Unit):void{			if (elementStack.indexOf(e,0) != -1) return;			e.tile = this;			elementStack.push(e);			if(elementStack.length > 1){				for(var i:int = 0; i < elementStack.length-1; i++){					var tmp:Unit = elementStack[i] as Unit;					if (e.playerId != tmp.playerId){						/*var parent:DisplayObjectContainer = this.parent;						while(parent !=null) {							trace(parent);							parent = parent.parent;						}*/						dispatchEvent(new PlayerEvent(PlayerEvent.FIGHT, this, e, tmp));						return;					}				}			}			grid.obstaclemc.addChild(e);			e.x = x;			e.y = y;		}				public function getElement():Element{			return elementStack[elementStack.length-1];		}				public function getObstacle():Obstacle{			return obstacle;		}				public function popElement():void{			elementStack.pop();		}				public function setObstacle(o:Obstacle):void{			if (obstacle==o) return;			if(obstacle!=null){				removeChild(obstacle);				obstacle = null;			}			o.tile = this;			obstacle = o;			addChild(obstacle);		}			}	}