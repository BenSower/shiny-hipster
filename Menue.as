﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;	import flash.display.Bitmap;	import flash.display.BitmapData;	import flash.events.*;		public class Menue extends MovieClip{				var stageBitmap:BitmapData;		var stageBitmap2:BitmapData;				//var b:Background;		var s:StartButton;		var cS1:Farbtafel1;		var cS2:Farbtafel2;		var cre: CreditsButton;		var opt: OptionsButton;		var ins: InstructionsButton;		var base1: Base1;		var base2: Base2;		var model:Model;		var controller:Controller;		var menuBackground:SoundPlayer;		public function Menue(model:Model, c:Controller) {			this.menuBackground = new SoundPlayer();			this.menuBackground.playAndRepeatSound("MenuBackground");									this.controller = c;			this.model = model;						addEventListener(MouseEvent.MOUSE_UP, controller.startClickHandler);			//b = new Background();			s = new StartButton(640,200);			cS1 = new Farbtafel1(199.0, 412.5);			cS2 = new Farbtafel2(1079.45, 409.5);			cre = new CreditsButton(640, 500);			opt = new OptionsButton(640, 300);			ins = new InstructionsButton(640, 400);			base1 = new Base1(280, 407);			base2 = new Base2(990, 407);			//s.gotoAndStop(1);			//cre.gotoAndStop(1);			//opt.gotoAndStop(1);			//ins.gotoAndStop(1);//			addChild(b);			addChild(s);			addChild(cS1);			addChild(cS2);			addChild(cre);			addChild(opt);			addChild(ins);			addChild(base1);			addChild(base2);						model.view.tintElement(base1, model.tintColor1, 1);			model.view.tintElement(base2, model.tintColor2, 1);					}				public function removeMenue():void{			//this.removeChild(b);			this.removeChild(s);			this.removeChild(cS1);			this.removeChild(cS2);			this.removeChild(base1);			this.removeChild(base2);			this.removeChild(cre);			this.removeChild(opt);			this.removeChild(ins);			this.menuBackground.stopSound();		}				public function farbtafel1():void{						if (stageBitmap == null) {				stageBitmap = new BitmapData(stage.width, stage.height);			 }			stageBitmap.draw(stage);			var rgb:uint = stageBitmap.getPixel(stage.mouseX,stage.mouseY);			trace(rgb);			var red:int =  (rgb >> 16 & 0xff);			var green:int =  (rgb >> 8 & 0xff);			var blue:int =  (rgb & 0xff);			trace(red + "," + green + "," + blue);						model.setColor(rgb, 0);			model.view.tintElement(base1, rgb, 1);		}				public function farbtafel2():void{						if (stageBitmap2 == null) {				stageBitmap2 = new BitmapData(stage.width, stage.height);			 }			stageBitmap2.draw(stage);			var rgb2:uint = stageBitmap2.getPixel(stage.mouseX,stage.mouseY);			var red2:int =  (rgb2 >> 16 & 0xff);			var green2:int =  (rgb2 >> 8 & 0xff);			var blue2:int =  (rgb2 & 0xff);			trace(red2 + "," + green2 + "," + blue2);						model.setColor(rgb2, 1);			model.view.tintElement(base2, rgb2, 1);		}	}	}