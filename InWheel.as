package {
	import flash.display.*;
	import flash.events.*;

	import com.pixelwelders.events.Broadcaster;

	import Spot;

	public class InWheel extends Sprite {
		private var seq:Array = new Array();
		private var idx:Number = 0.0;

		private var font_index:uint = 0;

		private var speed:Number = 0;
		private var radius:Number = 275;

		private var new_list:Array;

		public function InWheel(list:Array) {
			var myMask:Shape = drawCrescent();
			addChild(myMask);
			mask = myMask;

			Broadcaster.addEventListener(Hexagram.FONTSWAP, function (e:Event):void {
				++font_index;
			});

			Reload(list);
		}

		public function Reload(list:Array) {
			new_list = list;

			removeEventListener(Event.ENTER_FRAME, Shrink);
			addEventListener(Event.ENTER_FRAME, Shrink);
		}

		private function Shrink(e:Event):void {
			radius -= 10;
			if (radius <= 175) {
				removeEventListener(Event.ENTER_FRAME, Shrink);
				radius = 175;

				for each (var btn:Spot in seq)
					removeChild(btn);

				seq.splice(0);

				for each (var str:String in new_list) {
					var btn:Spot = new Spot(str, font_index);
					addChild(btn);

					seq.push(btn);
				}

				removeEventListener(Event.ENTER_FRAME, Grow);
				addEventListener(Event.ENTER_FRAME, Grow);
			}

			Render();
		}

		private function Grow(e:Event):void {
			radius += 10;
			if (radius >= 275) {
				removeEventListener(Event.ENTER_FRAME, Grow);
				radius = 275;
			}

			Render();
		}

		private function drawCrescent():Shape {
			var step:Number = Math.PI / 50;

			var cr:Shape = new Shape();
			cr.graphics.lineStyle(0, 0xffffff, 0.1);
			cr.graphics.beginFill(0xffffff, 0.1);


			// outer
			var j:Boolean = true;
			for (var i:Number = Math.PI / 2; i <= Math.PI * 5 / 2; i += step) {
				var x_:Number = (radius + 25) * Math.cos(i);
				var y_:Number = (radius + 25) * Math.sin(i) - 25;

				if (j) {
					cr.graphics.moveTo(x_, y_);
					j = false;
				}

				cr.graphics.lineTo(x_, y_);
			}

			// inner
			for (var i:Number = Math.PI * 5 / 2; i >= Math.PI / 2; i -= step) {
				var x_:Number = (radius - 23) * Math.cos(i);
				var y_:Number = (radius - 23) * Math.sin(i) + 25;
				cr.graphics.lineTo(x_, y_);
			}

			cr.graphics.endFill;
			return cr;
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

			alpha = (radius - 175) / 100;
		}
	}
}
