package  {
	
	public class PointBank {

		private var bankValue:Number;
		
		public function PointBank(startValue:Number) {
			this.bankValue = startValue;
		}
		
		public function getValue():Number{
			return bankValue;
		}
		
		public function setValue(bv:Number):void{
			bankValue = bv;
		}
		
		public function changeValue(cv:Number):void{
			bankValue = bankValue + cv;
		}

	}
	
}
