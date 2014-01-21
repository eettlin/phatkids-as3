package  {
	
	import flash.display.MovieClip;
	
	
	public class MenuArea extends MovieClip {
		
		public var tiles:Array;
		
		public function MenuArea() {
			tiles = new Array();
			
		}
		
		public function addTile(t:Tile):void
			{
				t.x = 50;
				t.y = tiles.length*125 + 100;
				tiles.push(t);
				addChild(t);
			}
	}
	
}
