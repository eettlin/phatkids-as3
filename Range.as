package  {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	public class Range extends Sprite {
		
		var rangeRadius:int = 0;
		var center:Point;
		
		public function Range(r:int) {

			this.rangeRadius = r;  // default
			this.width = 2*rangeRadius;
			this.height = 2*rangeRadius;
			this.alpha = .75;
		}
		
		public function updateRadius(newRange:Number):void{
			this.rangeRadius = newRange;
			this.width = 2*rangeRadius;
			this.height = 2*rangeRadius;
		}
		
		
	}
	
}