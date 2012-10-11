﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;		public class Model extends MovieClip{		var grid:Grid;		var units:Array;		var view:View;		var controller:Controller;		var activePlayer:Player;		var players:Array;		var fightMatrix:Array;		var fightLight: int = 5;		var stayLight: int = 2;		var roundCounter: int = 0;		var walkFlag:Boolean = false;		var menueBackground:Background		var menue:Menue;		var options:Options;		var credits:Credits;		var instructions:Instructions;		//var roundButton: NextRound;		var tintColor2:uint = uint("0xff4500"); 		var tintColor1:uint = uint("0x0046aa"); 		var counter:int;		var iface:Interface;		var iColorNeutral:uint = uint("0xc7dbdb");		var steps:int = 100;		var stepsLeft:int = steps;				public function Model(v:View, c:Controller) {			this.view = v;			this.controller = c;						menueBackground = new Background();			addChild(menueBackground);			menue = new Menue(this, controller);			addChild(menue);												//startGame();						fightMatrix = new Array();			if(fightMatrix[0] == undefined) fightMatrix[0] = new Array();			if(fightMatrix[1] == undefined) fightMatrix[1] = new Array();			if(fightMatrix[2] == undefined) fightMatrix[2] = new Array();			fightMatrix[0][0] = 0.5;			fightMatrix[1][1] = 0.5;			fightMatrix[2][2] = 0.5;			fightMatrix[0][1] = 0.2;			fightMatrix[1][2] = 0.2;			fightMatrix[2][0] = 0.2;			fightMatrix[0][2] = 0.8;			fightMatrix[1][0] = 0.8;			fightMatrix[2][1] = 0.8;										}				public function startGame():void{					this.grid = new Grid();			this.units = new Array();			players = new Array();			iface = new Interface(1130,400);						grid.addEventListener(PlayerEvent.FIGHT, fightHandler);									//roundButton = new NextRound();			//roundButton.gotoAndStop(1);						addEventListener(Event.ENTER_FRAME, enterFrameHandler);			grid.addEventListener(MouseEvent.MOUSE_UP, controller.gridClickHandler);			stage.addEventListener(MouseEvent.MOUSE_UP, controller.stageClickHandler);			grid.addEventListener(MouseEvent.MOUSE_OVER, controller.gridHoverHandler);  						grid.x += 50;			grid.y += 50;			addChild(iface);			addChild(grid);						this.gameCreation();					}				public function enterFrameHandler(evt:Event):void {			if(checkForWalkpath() == false) {				walkFlag = false;				var v:int = 0;				if(activePlayer == null) setActivePlayer(v);			}			if(walkFlag){				walkAll();			}					iface.stepsLeft.text = String(stepsLeft);							}				public function createPlayer(tintColor:uint):void{			var player:Player = new Player(tintColor);			players.push(player);		}				public function gameCreation(): void{			this.createPlayer(tintColor1);			this.createPlayer(tintColor2);						activePlayer = players[0];			iface.setLightBalken(activePlayer);			view.tintElement(iface, activePlayer.color, 0.6);						addBase(grid.getTile(0,0), 0);			addBase(grid.getTile(Grid.XSIZE-1, Grid.YSIZE-1),1);						grid.getTile(0,1).createElement(createUnit("rock", players[0]));			setOwner(grid.getTile(0,1), 0);			grid.getTile(1,0).createElement(createUnit("paper", players[0]));			setOwner(grid.getTile(1,0), 0);			grid.getTile(1,1).createElement(createUnit("scissor", players[0]));			setOwner(grid.getTile(1,1), 0);									grid.getTile(Grid.XSIZE-2,Grid.YSIZE-2).createElement(createUnit("rock", players[1]));			setOwner(grid.getTile(Grid.XSIZE-2,Grid.YSIZE-2), 1);			grid.getTile(Grid.XSIZE-2,Grid.YSIZE-1).createElement(createUnit("scissor", players[1]));			setOwner(grid.getTile(Grid.XSIZE-2,Grid.YSIZE-1), 1);			grid.getTile(Grid.XSIZE-1,Grid.YSIZE-2).createElement(createUnit("paper", players[1]));			setOwner(grid.getTile(Grid.XSIZE-1,Grid.YSIZE-2), 1);											}				public function addBase(t:Tile, typ:int):void{			if(typ == 0){ 				var b1:Base1 = new Base1(0,0);				view.tintElement(b1,getPlayerById(typ).color,1);				t.setObstacle(b1);				b1.gotoAndStop(1);			}			else if(typ == 1){				var b2:Base2 = new Base2(0,0);				view.tintElement(b2,getPlayerById(typ).color,1);				t.setObstacle(b2);				b2.gotoAndStop(1);			}		}				public function walkAll():void{			//array mit effektiv ausgewählten einheiten?			for each (var e:Element in grid.elementArray){				var u:Unit = e as Unit;				if(u.walkPath != null) u.didRun = true;				e.walk();			}		}				public function getGrid():Grid{			return grid;		}				public function setActivePlayer(i:int):void{						if(i == -1){ 				this.activePlayer = null;				view.tintElement(iface, iColorNeutral, 0.6);				return;			}			checkForVictory();			if(i == 0 && activePlayer == null){				checkIfMoved();				for each (var u:Unit in units){										u.didRun = false;				}			}			this.activePlayer = this.getPlayerById(i);			//trace(this.activePlayer.id);			this.iface.setLightBalken(activePlayer);			view.tintElement(iface, activePlayer.color, 0.6);			if(checkForFreeTiles(activePlayer.id)){				if(activePlayer.light > 4){ 				iface.enableAllUnits();				}			}			else iface.disableAllUnits();		}				public function switchActivePlayer():void{			roundCounter++;			if(roundCounter%2 == 0){								walkFlag = true;				this.setActivePlayer(-1);			}			if(activePlayer != null) {				if(activePlayer.id == 0) setActivePlayer(1);				else setActivePlayer(0);			}				}				public function getActivePlayer():Player{			return this.activePlayer;		}				public function createUnit(type:String, player:Player):Unit{			var unit:Unit;						switch(type){				case "rock": 	unit = new Rock(player.id); break;				case "paper":	unit = new Paper(player.id); break;				case "scissor": unit = new Scissor(player.id); break;			}			this.units.push(unit);			trace("Unit of type " + type+ " constructed");			player.addUnit(unit);					view.tintArray(unit.tintElements,player.color,1);						return unit;					}				public function getPlayerById(id:int):Player{			return players[id];		}				public function fightHandler(evt:PlayerEvent):void{			trace("fight");			var unit1 = evt.unit1;			var unit2 = evt.unit2;			var elementStack = evt.tile.elementStack;			unit1.walkPath = null;			unit2.walkPath = null;			grid.obstaclemc.removeChild(unit1);			grid.obstaclemc.removeChild(unit2);			elementStack[elementStack.indexOf(unit1)] = null;			elementStack[elementStack.indexOf(unit2)] = null;			units[units.indexOf(unit1)] = null;			units[units.indexOf(unit2)] = null;						var tmpArray2:Array = new Array();			var tmpArray:Array = new Array();			for each (var u:Unit in elementStack){				if (u != null) tmpArray.push(u);			}			for each (var v:Unit in units){				if (v != null) tmpArray2.push(v);			}			units = tmpArray2;			trace(units);			evt.tile.elementStack = tmpArray;			this.setOwner(evt.tile, fightCalculation(unit1, unit2));			var explosion:Explosion = new Explosion();			view.tintArray(explosion.tintElements, this.getPlayerById(evt.tile.owner).color, 1);			grid.tilesmc.addChild(explosion);			explosion.x = evt.tile.x;			explosion.y = evt.tile.y;			this.addLight(evt.tile.owner,fightLight);			trace(getPlayerById(evt.tile.owner).getLight());		}				public function fightCalculation(unit1:Unit, unit2:Unit):int{			var calc:Number = fightMatrix[unit1.unitId][unit2.unitId];			var rm:Number = Math.random();			trace(rm);			if(rm<calc) return unit1.playerId;			else return unit2.playerId;		}				public function checkForWalkpath():Boolean{			for each(var e:Unit in units){				if(e.walkPath != null) return true;			}			return false;		}					public function setColor(color:uint, id:int):void{			if(id == 0) tintColor1 = color;			else if(id == 1) tintColor2 = color;		}				public function setOwner(tile:Tile, owner:int):void{			tile.owner = owner;			view.tintElement(tile, getPlayerById(tile.owner).color, 1);		}				public function checkIfMoved():void {			for each (var u:Unit in units){				if(u.didRun == false && u.tile.owner != u.playerId){					trace("setowner");				setOwner(u.tile, u.playerId);				addLight(u.playerId, stayLight);				}			}		}				public function countOwnedTiles(playerId:int):int{			var count = 0;			for each(var a:Array in grid.gridArray){				for each(var t:Tile in a){					if(t.owner == playerId) count++;				}			}			return count;		}				public function checkForFreeTiles(playerId:int):Boolean{			for each(var a:Array in grid.gridArray){				for each(var t:Tile in a){					if(t.owner == playerId && t.elementStack[0] == null)return true;				}			}			return false;		}				public function addLight(id:int, i:int):void{			players[id].light += i;			iface.setLightBalken(players[id]);		}				public function removeLight(id:int, i:int):void{			if(players[id].light >= i) players[id].light -= i;			iface.setLightBalken(players[id]);			if(players[id].light < 5) iface.disableAllUnits();		}				public function checkForVictory():void{			var u1exists = false;			var u2exists = false;						var p1t:int = countOwnedTiles(players[0]);			var p2t:int = countOwnedTiles(players[1]);									for each(var u:Unit in units){					if(u.playerId == 0){						u1exists = true;											}					if(u.playerId == 1){						u2exists = true;										}							}						if(grid.gridArray.length/p1t < 2 || u2exists == false) {				trace(grid.gridArray.length/p1t < 2);				trace(u2exists == false);				trace("Player 1 wins");				//stage.removeChild(this);			}						if(grid.gridArray.length/p2t < 2 || u1exists == false) {				trace("Player 2 wins");				//stage.removeChild(this);			}					}	}	}