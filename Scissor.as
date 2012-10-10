package  {
	import flash.display.MovieClip;
		
	public class Scissor extends Unit {
		
		var lower:MovieClip;
		var upper:MovieClip;
		var reflection:MovieClip;

		public function Scissor(id:int) {
			this.scaleX = this.scaleY = 0.5;
			this.playerId = id;
			tintElements = new Array();
			
			upper = this.getChildAt(1) as MovieClip;
			upper = upper.getChildAt(3) as MovieClip;
			tintElements.push(upper);

			lower = this.getChildAt(1) as MovieClip;
			lower = lower.getChildAt(0) as MovieClip;
			tintElements.push(lower);
			
			reflection = this.getChildAt(0) as MovieClip;
			tintElements.push(reflection);
			this.unitId = 2;
		}
	}
	
}
