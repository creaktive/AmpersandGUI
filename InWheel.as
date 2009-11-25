package {
	import flash.display.*;
	import flash.events.*;

	import Hexagram;
	import Hexlay;

	public class InWheel extends Sprite {
		private var seq:Array = new Array();
		private var idx:Number = 0.0;

		public function InWheel(list:Array) {
			var fmt:Hexlay = new Hexlay(100);

			for each (var str:String in list) {
				var btn:Sprite = new Sprite();
				addChild(btn);
				seq.push(btn);

				var bg:Shape = new Shape();
				btn.addChild(bg);
				bg.graphics.lineStyle(0, Hexlay.color_front, 1.0);
				bg.graphics.beginFill(Hexlay.color_back, 1.0);
				bg.graphics.drawCircle(0, 0, 50);
				bg.graphics.endFill;

				var txt:Hexagram = new Hexagram(str, fmt);
				btn.addChild(txt);
				txt.width = 100;
				txt.x = -45;
				txt.y = -50;
			}

			Render();
		}

		public override function set rotation(rot:Number):void {
			idx = (rot * Math.PI) / 180;

			var upper:Number = Math.PI * ((seq.length - 7) / 6);

			if (idx < 0)
				idx = 0;
			else if (idx > upper)
				idx = upper;

			Render();
		}

		public override function get rotation():Number {
			return (idx * 180) / Math.PI;
		}

		private function Render():void {
			var radius:Number = 275;
			var i:int = 0;
			for each (var btn:Sprite in seq) {
				var ang:Number = (++i * (Math.PI / 6)) - idx;

				if (ang >= 0 && ang <= Math.PI * (7 / 6)) {
					var r:Number = 25 * (1 + Math.sin(ang));

					btn.x = -radius * Math.cos(ang);
					btn.y = -radius * Math.sin(ang);
					btn.scaleX = btn.scaleY = (r - 4) / 50;

					btn.visible = true;
				} else
					btn.visible = false;
			}
		}
	}
}
