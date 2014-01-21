package  {
	
	import flash.display.Sprite;
	import flash.geom.Point;
	
	
	public class Range extends Sprite {
		
		var rangeRadius:int = 30;
		var center:Point;
		
		public function Range(r:int) {
			// constructor code
			this.rangeRadius = r;
			this.width = 2*rangeRadius;
			this.height = 2*rangeRadius;
			this.alpha = .25;
		}
		
		public function updateRadius(r:Number):void{
			this.rangeRadius = r;
			this.width = 2*rangeRadius;
			this.height = 2*rangeRadius;
		}
		
		
	}
	
}