﻿package  {		import flash.display.MovieClip;			public class Interface extends MovieClip {				var roundButton: NextRound;		//var tintColor:uint;		var lightBalken:LightBalken;		var scissor:ScissorInterface;		var rock:RockInterface;		var paper:PaperInterface;		var tintElements:Array;				public function Interface(gx: Number, gy: Number) {									this.x = gx;			this.y = gy;						lightBalken = new LightBalken(60,230);			roundButton = new NextRound();			lightBalken.rotation = 270;			lightBalken.scaleX = lightBalken.scaleY = 0.7;						roundButton.x = -50;			roundButton.y = 194;						scissor = new ScissorInterface(-60, -180);			rock = new RockInterface(60, -180);			paper = new PaperInterface(0, -120);						tintElements = new Array();			tintElements[0] = this;			//tintElements[1] = roundButton;			//tintElements[2] = lightBalken.getChildByName(tintable);			//tintElements[2] = rock;			//tintElements[3] = paper;			//tintElements[4] = scissor;											addChild(lightBalken);			addChild(roundButton);			addChild(scissor);			addChild(rock);			addChild(paper);					}				public function setLightBalken(p:Player):void{			lightBalken.gotoAndStop(p.light);		}			}	}