package  {
	
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.geom.Point;
	
	
	public class Bullet extends MovieClip {
		
		
		var speed:Number = 10;
		var startPosition:Point = new Point();
		private var hitPoints:Number;
		
		public function Bullet(hp:Number) {
			this.hitPoints = hp;
		}
		
		public function updateBullet():void
		{
			this.x = this.x + Math.cos(this.rotation/180*Math.PI)*speed;
			this.y = this.y + Math.sin(this.rotation/180*Math.PI)*speed;
		}
		
		public function getStartPosition():Point
		{
			return  startPosition;
		}
		
		public function setStartPosition(sp:Point):void
		{
			startPosition = sp;
		}
		
		public function getHPValue():Number{
			return hitPoints;
		}
	}
	
}
