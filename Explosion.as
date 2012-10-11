package  {
	import flash.display.MovieClip;
		
	
	//public class Explosion extends Unit {
	public class Explosion extends Unit {
		
		var outline:MovieClip;
		
		public function Paper(id:int) {
			this.scaleX = this.scaleY = 0.5;
			//this.playerId = id;
			tintElements = new Array();
			
			outline = this.getChildAt(1) as MovieClip;
			tintElements.push(outline);
			
			//this.unitId = 1;
			
		}
	}
	
}
