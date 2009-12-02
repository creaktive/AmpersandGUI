package {
	import flash.display.*;
	import flash.events.*;

	import Hexagram;
	import Hexlay;

	public class Spot extends Sprite {
		private var bg:Shape = new Shape();
		private var txt:Hexagram;

		public function Spot(str:String) {
			addChild(bg);
			bg.graphics.lineStyle(0, Hexlay.color_front, 1.0);
			bg.graphics.beginFill(Hexlay.color_back, 1.0);
			bg.graphics.drawCircle(0, 0, 50);
			bg.graphics.endFill;

			txt = new Hexagram(str, 100);
			addChild(txt);
			txt.mouseEnabled = false;
			txt.width = 100;
			txt.x = -47;
			txt.y = -65;

			var chr:uint = str.charCodeAt(0);

			addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, chr, chr));
			});
		}
	}
}
