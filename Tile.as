package  {
	
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.ui.Mouse;
	import flash.events.MouseEvent;
	
	
	public class Tile extends MovieClip {
		
		public var turretCreator:Function;
		private var cost:int;
		public var range:int;
		
		public function Tile(image:DisplayObject,
							 cost:int,
							 turretCreator:Function) 
		{
			this.turretCreator = turretCreator;
			this.cost = cost;
			
			image.x = 4;
			image.y = 0;
			addChild(image);
			addEventListener(MouseEvent.MOUSE_DOWN, spawnTurret);
		}
		
		public function spawnTurret(me:MouseEvent):void
		{
			var t:Turret = turretCreator() as Turret;
																					//  Check to see if suficient funds to buy turret 
			if( t != null && (t.getCost() <= (root as PhatKids).bankValue.getValue()))  // (bank value >= turret value)
			{
				t.x = 200;
				t.y = 200;
				
				(root as PhatKids).addTurret(t);
			}else if(t != null){
				trace("Insufficient Funds");
			}
			
		
		}
	}
	
}
