﻿package  {	import flash.events.MouseEvent;		public class Controller {		var selectedElement: Element;		var targetTile: Tile;		var model:Model;		var hoverTarget:Tile;		var unitInterface:Unit;		var gameBackground:SoundPlayer;				public function Controller() {		}		public function gridClickHandler(evt:MouseEvent):void{			handleClick(this.getSelectedTile(evt));		}				public function stageClickHandler(evt:MouseEvent):void{			trace(evt.target);			if(evt.target == "[object NextRound]") {				model.switchActivePlayer();				model.stepsLeft = model.steps;					resetAllCosts();			 }			 			 if(evt.target == "[object ExitButton]") {								model.addMenue();				model.removeGame();				this.gameBackground.stopSound();			 }			 			  if(unitInterface != null && unitInterface.playerId == getSelectedTile(evt).owner && getSelectedTile(evt).elementStack[0] == null){				 model.grid.getTile(getSelectedTile(evt).gx,getSelectedTile(evt).gy).createElement(unitInterface);				 unitInterface = null;			 }			 			 if(evt.target == "[object ScissorInterface]" && this.model.activePlayer.getLight()>=5 && model.checkForFreeTiles(model.activePlayer.id)){				 unitInterface = model.createUnit("scissor", model.activePlayer);				 this.model.removeLight(model.activePlayer.id, 5);			 }			 			  if(evt.target == "[object PaperInterface]" && this.model.activePlayer.getLight()>=5&& model.checkForFreeTiles(model.activePlayer.id)){				 unitInterface = model.createUnit("paper", model.activePlayer);				 this.model.removeLight(model.activePlayer.id, 5);			 }				 			  if(evt.target == "[object RockInterface]" && this.model.activePlayer.getLight()>=5&& model.checkForFreeTiles(model.activePlayer.id)){				unitInterface = model.createUnit("rock", model.activePlayer);				 this.model.removeLight(model.activePlayer.id, 5);			 }		 		}								public function handleClick(t:Tile):void{			var tmpElement:Element = t.getElement();			trace(model.activePlayer.id);						if (t.getObstacle() != null){ 			//nur obstaclefreie felder auswählen				handleObstacle(t);			}else {				var u:Unit;				if(tmpElement != null && tmpElement is Unit && unitInterface == null){		//Unitauswahl nur für eigene Units					u = tmpElement as Unit;					if (u.playerId == model.getActivePlayer().id){						//trace("auswahl");						selectedElement = u;					}				}				//Targetauswahl nur für  leere oder gegnerische Felder 				if(selectedElement is Unit){					u = tmpElement as Unit;					if(tmpElement == null || u.playerId != model.getActivePlayer().id){						var tsd:Unit = selectedElement as Unit;						if(tsd.cost == 0){							if(tsd.gotoTarget(t.gx,t.gy, getStepsLeft()) != null){								tsd.cost = tsd.gotoTarget(t.gx,t.gy, getStepsLeft()).cost/2;								//trace("Kosten für: "+tsd+ tsd.cost);								setStepsLeft();							}						}						else {							tsd.cost = 0;							setStepsLeft();							if(tsd.gotoTarget(t.gx,t.gy, getStepsLeft()) != null){								tsd.cost = tsd.gotoTarget(t.gx,t.gy, getStepsLeft()).cost/2;								//trace("Kosten für: "+tsd+ tsd.cost);								setStepsLeft();							}						}						selectedElement = null;						targetTile = null;					}				}			}		}				public function handleObstacle(t:Tile):void{		}				public function gridHoverHandler(evt:MouseEvent):void{			if(getSelectedTile(evt) == null) return;			if(unitInterface != null && unitInterface.playerId == getSelectedTile(evt).owner && getSelectedTile(evt).elementStack[0] == null){				getSelectedTile(evt).gotoAndStop(2);			}			if (hoverTarget != null){				if (hoverTarget.getObstacle() != null){					hoverTarget.getObstacle().gotoAndStop(1);				}				hoverTarget.gotoAndStop(1);			}			hoverTarget = getSelectedTile(evt);			var unit:Unit = hoverTarget.elementStack[0] as Unit;			if(hoverTarget.elementStack[0] != null && unit.playerId == model.activePlayer.id && unitInterface == null ) hoverTarget.gotoAndStop(2);			if(selectedElement != null && hoverTarget.getObstacle() == null) hoverTarget.gotoAndStop(2);			if(hoverTarget.getObstacle() != null) hoverTarget.getObstacle().play();					}				public function getSelectedTile(evt:MouseEvent):Tile{			var w:Number = model.grid.getTile(0,0).width;			var h:Number = model.grid.getTile(0,0).height;			var gx:int = (model.grid.mouseX+w/2)/w;			var gy:int = (model.grid.mouseY+h/2)/h;			if(gx<Grid.XSIZE && gy<Grid.YSIZE) return model.grid.getTile(gx,gy);			else{				trace("FALSCHE TILEKOORDINATE!!!!! "+gx+" "+gy);				return null;			}		}			public function startClickHandler(evt:MouseEvent):void{						trace(evt.target);			trace(evt.localX);			trace(evt.localY);			if(evt.target.toString() == "[object StartButton]"){				if(Model.soundOn){					var menuSelection:SoundPlayer = new SoundPlayer();					menuSelection.playSound("MenuSelection");										var soundPlayer:SoundPlayer= new SoundPlayer();					soundPlayer.playSound("StartGame");										gameBackground = new SoundPlayer();					gameBackground.playAndRepeatSound("GameBackground");				}								model.menue.removeMenue();				model.removeChild(model.menueBackground);				model.startGame();			}						if(evt.target == "[object Farbtafel1]")			{				if(Model.soundOn){					var soundPlayerFarbTafel1:SoundPlayer = new SoundPlayer();					soundPlayerFarbTafel1.playSound("SelectColor");				}				model.menue.farbtafel1();			}						if(evt.target == "[object Farbtafel2]")			{				if(Model.soundOn){					var soundPlayerFarbTafel2:SoundPlayer = new SoundPlayer();					soundPlayerFarbTafel2.playSound("SelectColor");				}				model.menue.farbtafel2();			}						if(evt.target == "[object CreditsButton]"){				if(Model.soundOn){					var creditSelection:SoundPlayer = new SoundPlayer();					creditSelection.playSound("MenuSelection");				}								model.menue.removeMenue();				model.credits = new Credits(this);				model.addChild(model.credits);				model.credits.x = 607;				model.credits.y = 442;				//model.credits.addChild(model.goBackButton);			}						if(evt.target == "[object OptionsButton]"){				if(Model.soundOn){					var optionSelection:SoundPlayer = new SoundPlayer();					optionSelection.playSound("MenuSelection");				}								model.menue.removeMenue();				model.options = new Options(this);				model.addChild(model.options);				model.options.x = 815.25;				model.options.y = 260;			}						if(evt.target == "[object InstructionsButton]"){				if(Model.soundOn){					var instructionSelection:SoundPlayer = new SoundPlayer();					instructionSelection.playSound("MenuSelection");				}								model.menue.removeMenue();				model.instructions = new Instructions(this);				model.addChild(model.instructions );				model.instructions .x = 635.25;				model.instructions .y = 420;			}		}				public function optionsClickHandler(evt:MouseEvent):void{			trace(evt.target);						if(evt.target == "[object NextRound]"){				model.removeChild(model.options);				model.menue = new Menue(model,this);				model.addChild(model.menue);			}			if(evt.target == "[object ObstacleButton]"){				model.hard = true;			}						if(evt.target == "[object TileButton]"){				model.hard = false;			}						if(evt.target == "[object SoundOnButton]"){				Model.soundOn = true;			}						if(evt.target == "[object SoundOfButton]"){				Model.soundOn = false;			}		}				public function creditsClickHandler(evt:MouseEvent):void{			trace(evt.target);						if(evt.target == "[object NextRound]"){				model.removeChild(model.credits);				model.menue = new Menue(model,this);				model.addChild(model.menue);			}		}				public function instructionsClickHandler(evt:MouseEvent):void{			trace(evt.target);						if(evt.target == "[object NextRound]")			{				model.removeChild(model.instructions);				model.menue = new Menue(model,this);				model.addChild(model.menue);			}					}				public function setStepsLeft():void{			model.stepsLeft = model.steps;			for each (var u:Unit in model.activePlayer.units){				//trace(model.stepsLeft+" = "+ model.steps+" - "+model.stepsLeft+" - "+u.cost);				model.stepsLeft = model.stepsLeft - u.cost;			}						trace("Steps left: " + model.stepsLeft);		}				public function getStepsLeft():int{			return model.stepsLeft;			}				public function resetAllCosts(){			for each (var u:Unit in model.players[0].units){				u.cost = 0;				//trace(u + "cost " + u.cost);			}			for each (var v:Unit in model.players[1].units){				v.cost = 0;				//trace(u + "cost " + u.cost);			}		}	}}