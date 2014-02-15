package 
{

	import flash.display.MovieClip;
	import flash.events.Event;


	public class Enemy extends MovieClip
	{
		public var lifePoints:Number;
		public var bankPoints:Number;
		var speed:Number = 3;
		var waypoints:Array;
		var currWP:Number = 0;
		var distWP:Number = 0;
		var offSet:int = 100;
		var hb:HealthBar = new HealthBar();
		var fullHealth:Number;
		var endTrack:Boolean = false;

		public function Enemy(wp:Array, lifePoints:Number, bankPoints:Number)
		{
			this.lifePoints = lifePoints;
			fullHealth = lifePoints;
			this.bankPoints = bankPoints;
			waypoints = wp;
			hb.x = 0;
			hb.y = 50;
			addChild(hb);
		}

		public function updateEnemy():void
		{
			distWP = getDistanceToWayPoint();
			if (distWP < 5)
			{
				currWP++;
			}
			moveEnemy();
		}

		public function getDistanceToWayPoint():Number
		{
			var dist:Number = -1;
			if (waypoints[currWP] != null)
			{
				var dx:Number = waypoints[currWP].x - x;
				var dy:Number = waypoints[currWP].y - y;
				dx += offSet;
				dist = Math.sqrt(dx*dx + dy*dy);
			}
			return dist;
		}

		public function moveEnemy():void
		{
			if (waypoints[currWP] != null)
			{
				var dx:Number = waypoints[currWP].x - x;
				var dy:Number = waypoints[currWP].y - y;
				dx += offSet;
				rotation = Math.atan2(dy,dx) / Math.PI * 180;
				this.x = this.x + Math.cos(this.rotation / 180 * Math.PI) * speed;
				this.y = this.y + Math.sin(this.rotation / 180 * Math.PI) * speed;
				rotation  = 0;
			}
			if(currWP >=waypoints.length && endTrack == false)
			{
				(root as PhatKids).lifePoints.changeValue(-5);
				endTrack = true;
			}
		}
		
		public function setLifePoints(lp:Number):void
		{
			this.lifePoints = lp;
		}
		
		public function getLifePoints():Number
		{
			return lifePoints;
		}
		
		public function changeLifePoints(cp:Number):void
		{
			this.lifePoints += cp;
			hb.greenBar.width *= (this.lifePoints/fullHealth);
		}
		//++++++++++++++++									+++++++++++++++++++++++++++++
		public function setBankPoints(bp:Number):void
		{
			this.bankPoints = bp;
		}
		
		public function getBankPoints():Number
		{
			return bankPoints;
		}
		
		public function changeBankPoints(cp:Number):void
		{
			this.bankPoints += cp;
		}
	}
}