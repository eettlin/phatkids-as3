﻿package 
{

	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.utils.Timer;
	import flash.events.TimerEvent;
	import fl.transitions.*;
  	import fl.transitions.easing.*;
  	import flash.geom.Point;


	public class PhatKids extends MovieClip
	{
		var pa:PlayArea;
		var ma:MenuArea;
		var ia:InfoArea;
		var enemyLaunchDelay:Number = 0;
		var maxEnemies:Number = 0;
		var waypointObject:DisplayObject;
		var enemyTimer:Timer = new Timer(2000,40);
		var sendEnemy:Boolean = true;
		var trt:Turret;
		var range:Range = new Range(100);  //default range 100

		
		var bankValue:PointBank = new PointBank(800);
		public var lifePoints:PointBank = new PointBank(200);
		//Arrays
		var waypoints:Array;
		var enemies:Array;
		var bullets:Array;
		var turrets:Array;

		public function PhatKids()
		{
			waypoints = new Array();
			enemies = new Array();
			bullets = new Array();
			turrets = new Array();
			setAreas();
			loadWaypoints();
			addEventListener(Event.ENTER_FRAME, updatePhatKids);
			addEventListener(Event.ENTER_FRAME, enemyLoop);
			addEventListener(Event.ENTER_FRAME, bulletLoop);
			enemyTimer.start();
			enemyTimer.addEventListener(TimerEvent.TIMER, enemyTimerTick);
		}

		public function enemyTimerTick(tevt:TimerEvent):void
		{
			sendEnemy = true;
		}

		private function updatePhatKids(evt:Event):void
		{
			initEnemy();
			updateInfoArea();
		}
		//++++++++++++++++++++++++++++++++++++++++++++++++++  Lesson Eleven
		private function updateInfoArea():void
		{
			ia.bank_value.text = String(bankValue.getValue());
			ia.life_points.text = String(lifePoints.getValue());
		}
		private function enemyLoop(evt:Event):void
		{
			for (var ei:int = 0; ei < enemies.length; ei++)
			{
				if (enemies[ei] != null)
				{
					enemies[ei].updateEnemy();
				}
			}
		}

		private function bulletLoop(evt:Event):void
		{
			for (var bi:int = 0; bi < bullets.length; bi++)
			{
				bullets[bi].updateBullet();
				
				var bdx:Number = bullets[bi].x - (bullets[bi].getStartPosition()).x;
				var bdy:Number = bullets[bi].y - (bullets[bi].getStartPosition()).y;
				var bulletDistance:Number = Math.sqrt(bdx*bdx+bdy*bdy)
				
				if(bulletDistance > bullets[bi].getRange())
				{
					//remove bullet from parent
					this.removeChild(bullets[bi]);
					//remove bullet from the array
					bullets.splice(bi,1);
				}
			}

			for (var i:int  = bullets.length -1; i >= 0; i--)
			{
				for (var j:int = enemies.length -1; j >=0; j--)
				{

					if (bullets[i] != null && enemies[j] != null)
					{
						
						if (bullets[i].hitTestObject(enemies[j]))
						{
							enemies[j].changeLifePoints(-bullets[i].getHPValue());  //Update enemy life points
							//remove bullet from parent
							this.removeChild(bullets[i]);
							//remove bullet from the array
							bullets.splice(i,1);
							//remove enemy from parent
							if(enemies[j].getLifePoints() <= 0){					//  Check if life points pos
								bankValue.changeValue(enemies[j].getBankPoints());	// update bank
								this.removeChild(enemies[j]);
								//remove enemy from the array
								enemies.splice(j, 1);
							}
						}
					}
				}
			}

		}



		public function makeBullet(tx:int, ty:int, tRot:int, bn:int,tRange:Number):void //++++++++++++++++ input parameters
		{
			var bullet:Bullet = null;
			switch(bn){
				case 1:
				 bullet = new BulletOne(70, new Point(tx,ty), tRange); 
				 break;
				case 2:
				 bullet = new BulletTwo(100, new Point(tx,ty), tRange); 
				 break;
				case 3:
				 bullet = new BulletThree(120, new Point(tx,ty), tRange); 
				 break;
				case 4:
				 bullet = new BulletFour(160, new Point(tx,ty), tRange); 
				 break;
				default:
				 bullet = new Bullet(20, new Point(tx,ty), 100); 
				 break;
			
			}
			
			bullet.x = tx;
			bullet.y = ty;
			bullet.rotation = tRot;
			bullet.mask = createPlayAreaMask();
			bullets.push(bullet);
			this.addChild(bullet);
		}

		private function initEnemy():void
		{
			var enemy:Enemy = null;
			if (sendEnemy == true)
			{
				enemy = chooseEnemy();
				enemy.x = stage.stageWidth - 100;
				enemy.y = -100;
				enemy.rotation = Math.random() * 360;
				enemy.mask = createPlayAreaMask();
				enemies.push(enemy);
				this.addChild(enemy);
				maxEnemies++;
				enemyLaunchDelay = 48;
				sendEnemy = false;
			}
		}
		
		public function chooseEnemy():Enemy
		{
				var enemy:Enemy = null;
				var randomEnemy:int = Math.random()*4+1;
				switch(randomEnemy)
				{
					case 1:
						enemy = new EnemyOne(waypoints, 600, 20 );
					break;
					
					case 2:
						enemy  = new EnemyTwo(waypoints, 750, 40);
					break;
					
					case 3:
						enemy  = new EnemyThree(waypoints, 850, 80);
					break;
					
					case 4:
						enemy  = new EnemyFour(waypoints, 1000, 110);
					break;
					
					default:
						enemy  = new Enemy(waypoints, 50, 50);
					break;
				}
				return enemy;
		}

		public function addTurret(t:Turret, cost:Number):void
		{
			bankValue.changeValue(-cost);  //  +++++++  Change Bank value
			range.updateRadius(t.ts.range);
			range.visible = true;
			this.addChild(range);
			
			trt = t;
			trt.x = mouseX;
			trt.y = mouseY;
			trt.startDrag();
			trt.mask = createPlayAreaMask();
			addChild(trt);
			addEventListener(Event.ENTER_FRAME, setRanger );
			addEventListener(MouseEvent.MOUSE_UP, releaseTurret);
			
		}

		private function releaseTurret(me:MouseEvent):void
		{
			trt.stopDrag();
			range.visible = false;
		}

		private function setRanger(e:Event):void
		{
			range.x = trt.x;
			range.y = trt.y;
		}
		
		private function createPlayAreaMask():Sprite
		{
			var playAreaMask:Sprite = new Sprite();
			playAreaMask.graphics.beginFill(0xFFFFFF);
			playAreaMask.graphics.drawRect(pa.x, pa.y, pa.width, pa.height);
			playAreaMask.graphics.endFill();
			return playAreaMask;
		}

		// Set main areas on stage
		private function setAreas():void
		{
			pa = new PlayArea();
			pa.x = 100;
			pa.y = 0;
			addChild(pa);

			ia = new InfoArea();
			ia.x = 0;
			ia.y = 600;
			addChild(ia);

			ma = new MenuArea();
			ma.x = 0;
			ma.y = 0;
			addChild(ma);
		

			ma.addTile(new Tile( new T1Icon(),
								100,
								function() {return new TurretOne()}));

			ma.addTile(new Tile( new T2Icon(),
								200,
								function() {return new TurretTwo()}));

			ma.addTile(new Tile( new T3Icon(),
								300,
								function() {return new TurretThree()}));

			ma.addTile(new Tile( new T4Icon(),
								400,
								function() {return new TurretFour()}));
		
		}

	public function loadWaypoints():void
	{
		var i:int = 1;
		waypointObject = pa.getChildByName("WP" + i);

		while ( waypointObject != null)
		{
			waypoints.push(waypointObject);
			i++;
			waypointObject = pa.getChildByName("WP" + i);
		}
	}



}

}