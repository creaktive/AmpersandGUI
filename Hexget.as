package {
	import flash.display.*;
	import flash.events.*
	import flash.geom.*

	public class Hexget extends Sprite {
		private const speed:uint = 10;

		private var l:Number;
		private var h:Number;
		private var w:Number;

		private var inner:Sprite = new Sprite();
		private var comb:Sprite = new Sprite();

		private var scale_from:Number;
		private var scale_to:Number;
		private var scale_step:Number;
		private var scale_frame:uint;

		private var mapping:Array = new Array();
		private var holder:Array = new Array();

		private var core:DisplayObject;

		public function Hexget(core_:DisplayObject, len:Number = 300):void {
			var ang:Number = Math.PI / 3;

			l = len;
			h = l * Math.sin(ang);
			w = l * Math.cos(ang);

			BuildMapping();

			inner.addChild(comb);
			super.addChild(inner);

			mask = Hexbound();
			super.addChild(mask);

			Hexgrid(4);

			core = addChild(core_);
		}

		public override function addChild(child:DisplayObject):DisplayObject {
			if (comb.numChildren == 19)
				return null;

			var cell:Sprite = new Sprite();
			cell.x = mapping[comb.numChildren].x;
			cell.y = mapping[comb.numChildren].y;

			cell.mask = Hexbound(-1);
			cell.addChild(child);
			cell.addChild(cell.mask);
			comb.addChild(cell);

			holder.push(new Array(child, cell));

			level();
			return child;
		}

		public override function removeChild(child:DisplayObject):DisplayObject {
			if (child == core)
				return null;

			var new_holder:Array = new Array();

			var j:uint = 0;
			for each (var i:Array in holder)
				if (child == i[0])
					comb.removeChild(i[1]);
				else {
					new_holder.push(i);

					i[1].x = mapping[j].x;
					i[1].y = mapping[j].y;

					++j;
				}

			holder = new_holder;

			level();
			return child;
		}

		public function level():uint {
			var n:uint = 1;
			if (comb.numChildren > 1)
				n = 2;
			else if (comb.numChildren > 7)
				n = 3;

			if (n >= 1 && n <= 3) {
				scale_from	= inner.scaleX;
				scale_to	= 1 / ((n * 2) - 1);	// 1, 1/3, 1/5
				scale_frame	= 0;
				scale_step	= (scale_to - scale_from) / speed;

				addEventListener(Event.ENTER_FRAME, rescale);
			}

			return n;
		}

		private function rescale(e:Event) {
			var n:Number;
			if (scale_frame++ < speed)
				n  = scale_from + scale_step * scale_frame;
			else {
				n = scale_to;
				removeEventListener(Event.ENTER_FRAME, rescale);
			}

			inner.scaleX = inner.scaleY = n;
		}

		private function Hexgrid(num:uint):void {
			var grid:Shape = new Shape();
			inner.addChild(grid);

			grid.graphics.lineStyle(0, 0xff8000);

			var posX:Number = -(w * num + l * (num - 1) + l / 2);
			var posY:Number = -(h * num * 2 - ((num % 2) ? h * 2 : h));

			var startX:Number = posX;

			for (var i:uint = 0; i < num << 1; i++) {
				posX = startX;

				for (var j:uint = 0; j < num; j++) {
					grid.graphics.moveTo(posX + w, posY - h);
					grid.graphics.lineTo(posX + 0, posY);
					grid.graphics.lineTo(posX + w, posY + h);
					grid.graphics.lineTo(posX + w + l, posY + h);
					grid.graphics.lineTo(posX + w * 2 + l, posY);
					grid.graphics.lineTo(posX + w * 2 + l * 2, posY);
					grid.graphics.moveTo(posX + w * 2 + l, posY);
					grid.graphics.lineTo(posX + w + l, posY - h);

					posX += w * 2 + l * 2;
				}

				posY += h * 2;
			}
		}

		private function Hexbound(q:Number = 0.5):Shape {
			var base:Shape = new Shape();

			var s:Number = -(l / 2 + w);

			base.graphics.lineStyle(0, 0xffffff);
			base.graphics.beginFill(0x0000ff);

			base.graphics.moveTo(s - q, 0);
			base.graphics.lineTo(s + w - q, h + q);
			base.graphics.lineTo(s + w + l + q, h + q);
			base.graphics.lineTo(s + w * 2 + l + q, 0);
			base.graphics.lineTo(s + w + l + q, -h - q);
			base.graphics.lineTo(s + w - q, -h - q);

			base.graphics.endFill();

			return base;
		}

		private function BuildMapping():void {
			// lvl 1
			mapping.push(new Point(0, 0));

			// lvl 2
			mapping.push(new Point(l + w, -h));
			mapping.push(new Point(l + w, h));
			mapping.push(new Point(0, 2 * h));
			mapping.push(new Point(-l - w, h));
			mapping.push(new Point(-l - w, -h));
			mapping.push(new Point(0, -2 * h));

			// lvl 3
			mapping.push(new Point(2 * l + 2 * w, -2 * h));
			mapping.push(new Point(2 * l + 2 * w, 0));
			mapping.push(new Point(2 * l + 2 * w, 2 * h));
			mapping.push(new Point(l + w, 3 * h));
			mapping.push(new Point(0, 4 * h));
			mapping.push(new Point(-l - w, 3 * h));
			mapping.push(new Point(-2 * l - 2 * w, 2 * h));
			mapping.push(new Point(-2 * l - 2 * w, 0));
			mapping.push(new Point(-2 * l - 2 * w, -2 * h));
			mapping.push(new Point(-l - w, -3 * h));
			mapping.push(new Point(0, -4 * h));
			mapping.push(new Point(l + w, -3 * h));
		}
	}
}
