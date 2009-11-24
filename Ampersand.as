package {
	[
		SWF(
			backgroundColor	= '#000000',
			frameRate		= '30',
			width			= '800',
			height			= '600'
		)
	]

	import flash.display.*;
	
	import Hexget;

	public class Ampersand extends Sprite {
		public function Ampersand():void {
			var topmost:Hexget = new Hexget();
			addChild(topmost);

			topmost.x = 400;
			topmost.y = 300;

			topmost.addChild(testshape(0xff0000));
			topmost.addChild(testshape(0x00ff00));

			var test3 = topmost.addChild(new Hexget());
			test3.addChild(testshape(0x0000ff));
			test3.addChild(testshape(0xff00ff));
		}

		private function testshape(color:uint):Shape {
			var test1:Shape = new Shape();
			test1.graphics.lineStyle(0, color, 0.5);
			test1.graphics.beginFill(color, 0.5);
			test1.graphics.drawCircle(0, 0, 400);
			test1.graphics.endFill;
			return test1;
		}
	}
}
