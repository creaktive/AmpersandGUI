package {
	import flash.display.*;
	import flash.events.*;

	import Spot;

	public class InWheel extends Sprite {
		private var seq:Array = new Array();
		private var idx:Number = 0.0;

		private var speed:Number = 0;

		public function InWheel(list:Array) {
			for each (var str:String in list) {
				var btn:Spot = new Spot(str);
				addChild(btn);

				seq.push(btn);
			}

			Render();
		}

		public function Impulse(speed_:Number):void {
			speed = speed_;
			removeEventListener(Event.ENTER_FRAME, SpinDown);
			addEventListener(Event.ENTER_FRAME, SpinDown);
		}

		private function SpinDown(e:Event):void {
			if (rotation < 0)
				speed = -1;
			else if (rotation > (seq.length - 6) * 30)	// Math.PI * ((seq.length - 7) / 6)
				speed = 1;

			if (Math.abs(speed) >= 1) {
				speed *= 0.75;
				rotation -= speed * 5;
			} else {
				if (Math.abs(rotation % 30) > 5)
					rotation -= speed * 2.5;
				else {
					rotation = Math.round(rotation / 30) * 30;
					removeEventListener(Event.ENTER_FRAME, SpinDown);
				}
			}
		}

		public override function set rotation(rot:Number):void {
			idx = (rot * Math.PI) / 180;
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
