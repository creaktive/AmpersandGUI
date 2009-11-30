package {
	import flash.display.*;
	import flash.events.*;

	import Spot;

	public class InWheel extends Sprite {
		private var seq:Array = new Array();
		private var idx:Number = 0.0;

		public function InWheel(list:Array) {
			for each (var str:String in list) {
				var btn:Spot = new Spot(str);
				addChild(btn);

				seq.push(btn);
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
