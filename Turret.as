package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.display.Sprite;


	public class Turret extends MovieClip
	{
		//lesson ten
		private var range:Number;
		private var cost:Number;
		private var bulletHP:Number
		
		var fireDelay:int = 0;
		var dte:Number;
		var shortestDistance:Number;
		var currEnemy:int;
		var e:Array;

		public function Turret(r:Number, bhp:Number, c:Number)
		{
			this.range = r;
			this.bulletHP = bhp;
			this.cost = c;
			
			addEventListener(Event.ENTER_FRAME, updateTurret);
		}

		public function updateTurret(evt:Event):void
		{
			var r:PhatKids = root as PhatKids;
			if (r == null) {
				return;
			}
			e = r.enemies;
			
			shortestDistance = 1000;
			for(var i:int = 0; i < e.length; i++)
			{
				dte = getDistanceToEnemy(e[i]);
				if(dte < shortestDistance)
				 {
					 shortestDistance = dte;
					 currEnemy = i;
				 }
			}
			
			var dx:Number = x - e[currEnemy].x;
			var dy:Number = y - e[currEnemy].y;
			rotation = 180 + Math.atan2(dy, dx)/Math.PI*180;
			fireDelay--;  
			if ((parent) != null && fireDelay < 0 && (getDistanceToEnemy(e[currEnemy])) <= range) //addes third condition
			{
				(parent as MovieClip).makeBullet(x, y, rotation);
				fireDelay = 24;
			}
			
		}

		public function getDistanceToEnemy(enemy:Enemy):Number
		{
			var dx:Number = x - enemy.x;
			var dy:Number = y - enemy.y;
			return Math.sqrt(dx*dx + dy*dy);
		}

		public function createPlayAreaMask():Sprite
		{
			var playAreaMask:Sprite = new Sprite();
			playAreaMask.graphics.beginFill(0xFFFFFF);
			playAreaMask.graphics.drawRect(100, 0, 900, 600);
			playAreaMask.graphics.endFill();
			return playAreaMask;
		}
		
		public function getRange():Number{
			return this.range;
		}
		
		public function getCost():Number{
			return this.cost;
		}
	}
}