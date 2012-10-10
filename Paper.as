package  {
	import flash.display.MovieClip;
		
	
	public class Paper extends Unit {
		
		var bg:MovieClip;
		var reflection:MovieClip;
		
		public function Paper(id:int) {
			this.scaleX = this.scaleY = 0.5;
			this.playerId = id;
			tintElements = new Array();
			
			bg = this.getChildAt(1) as MovieClip;
			tintElements.push(bg);
			
			reflection = this.getChildAt(0) as MovieClip;
			tintElements.push(reflection);
			
			this.unitId = 1;
			
		}
	}
	
}
