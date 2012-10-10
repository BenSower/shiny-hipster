package  {
	import flash.display.MovieClip;
	
	public class Rock extends Unit{
		
		var bg:MovieClip;
		var reflection:MovieClip;
		
		var orbvg:MovieClip;
		var orbhg:MovieClip;
		
		public function Rock(id:int) {
			this.scaleX = this.scaleY = 0.5;
			this.playerId = id;
			tintElements = new Array();
			
			bg = this.getChildAt(5) as MovieClip;
			tintElements.push(bg);
						
			orbhg = this.getChildAt(1) as MovieClip;
			orbhg = orbhg.getChildAt(2) as MovieClip;
			tintElements.push(orbhg);
			
			orbvg = this.getChildAt(6) as MovieClip;
			orbvg = orbvg.getChildAt(2) as MovieClip;
			tintElements.push(orbvg);
			
			reflection = this.getChildAt(0) as MovieClip;
			tintElements.push(reflection);
			
			this.unitId = 0;
			
			

		}
	}
	
}
