﻿package  {		import flash.display.MovieClip;	import flash.events.Event;	import flash.events.MouseEvent;		public class Main extends MovieClip {				var grid:Grid;		var controller:Controller;		var model:Model;		var view: View;		var roundButton: NextRound;				public function Main():void {			view = new View();			controller = new Controller();			model = new Model(view, controller);			controller.model = model;			stage.addChild(model);														}						}	}