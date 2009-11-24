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
	import flash.events.*
	
	import Hexget;

	public class Ampersand extends Sprite {
		public function Ampersand():void {
			var topmost:Hexget = new Hexget(testshape(0xff0000));
			addChild(topmost);

			topmost.x = 400;
			topmost.y = 300;

			var coco = topmost.addChild(testshape(0x00ff00));

			stage.addEventListener(MouseEvent.CLICK, function () {
				topmost.removeChild(coco);
			});
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
