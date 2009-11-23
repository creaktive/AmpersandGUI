package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	import VPEvent;

	public class ViewPort extends Sprite {
		private var h:Number;
		private var w:Number;
		private var l:Number;

		private var viewport:Sprite	= new Sprite();
		private var mesh:Sprite		= new Sprite();
		private var grid:Shape		= new Shape();
		private var vis:Shape		= new Shape();

		private var zoomn:uint		= 1;

		private var slots:Array		= new Array();
		private var holder:Array	= new Array();

		public function ViewPort(len:Number = 300):void {
			addChild(viewport);
			viewport.addChild(vis);
			viewport.addChild(mesh);
			mesh.addChild(grid);

			l = len;
			h = l * Math.sin(Math.PI / 3);
			w = l * Math.cos(Math.PI / 3);

			grid.graphics.lineStyle(0, 0xff8000);
			hexmod(grid, 4);

			vis.graphics.lineStyle(0, 0xffffff);
			vis.graphics.beginFill(0x0000ff);
			bound(vis);
			vis.graphics.endFill();

			viewport.mask = vis;


			// lvl 1
			slots.push(slot(0, 0));

			// lvl 2
			slots.push(slot(l + w, -h));
			slots.push(slot(l + w, h));
			slots.push(slot(0, 2 * h));
			slots.push(slot(-l - w, h));
			slots.push(slot(-l - w, -h));
			slots.push(slot(0, -2 * h));

			// lvl 3
			slots.push(slot(2 * l + 2 * w, -2 * h));
			slots.push(slot(2 * l + 2 * w, 0));
			slots.push(slot(2 * l + 2 * w, 2 * h));
			slots.push(slot(l + w, 3 * h));
			slots.push(slot(0, 4 * h));
			slots.push(slot(-l - w, 3 * h));
			slots.push(slot(-2 * l - 2 * w, 2 * h));
			slots.push(slot(-2 * l - 2 * w, 0));
			slots.push(slot(-2 * l - 2 * w, -2 * h));
			slots.push(slot(-l - w, -3 * h));
			slots.push(slot(0, -4 * h));
			slots.push(slot(l + w, -3 * h));

			addEventListener(VPEvent.VPEVT, doFocus);
		}

		public function insert(obj:Object, i:int = -1):Object {
			if (i >= 0) {
				holder[i] = obj;
			} else {
				i = holder.length;
				holder.push(obj);
			}

			slots[i].addChild(obj);
			slots[i].setChildIndex(obj, 0);

			return obj;
		}

		public function set zoomlevel(n:uint):void {
			var f:Number;

			zoomn = n;

			switch (n) {
				case 1:		f = 1; break;
				case 2:		f = 1 / 3; break;
				case 3:		f = 1 / 5; break;
				default:	f = 1;
			}

			mesh.scaleX = mesh.scaleY = f;
		}

		public function get zoomlevel():uint {
			return zoomn;
		}

		private function slot(posX:Number, posY:Number):Sprite {
			var slot:Sprite = new Sprite();
			slot.x = posX;
			slot.y = posY;

			var vis:Shape = new Shape();
			slot.addChild(vis);

			vis.graphics.lineStyle(0, 0xffffff);
			vis.graphics.beginFill(0x0000ff);
			bound(vis, -1);
			vis.graphics.endFill();

			slot.mask = vis;


			var fmt:TextFormat		= new TextFormat();
			fmt.align				= TextFormatAlign.CENTER;
			fmt.color				= 0xffffff;
			fmt.font				= 'Trebuchet MS';
			fmt.size				= 50;

			var txt:TextField		= new TextField();
			txt.antiAliasType		= AntiAliasType.ADVANCED;
			txt.blendMode			= BlendMode.LAYER;
			txt.defaultTextFormat	= fmt;
			txt.selectable			= false;
			txt.text				= Math.round(posX) + ',' + Math.round(posY);
			txt.wordWrap			= false;

			txt.width				= 200;
			txt.x					= -100;
			txt.y					= -35;
			slot.addChild(txt);


			var bg:Shape = new Shape();
			slot.addChild(bg);
			bg.graphics.lineStyle(0, 0x0000ff, 0.0);
			bg.graphics.beginFill(0x0000ff, 0.0);
			bg.graphics.drawCircle(0, 0, l);
			bg.graphics.endFill;


			slot.addEventListener(MouseEvent.CLICK, getClick);

			mesh.addChild(slot);

			return slot;
		}

		private function getClick(e:MouseEvent):void {
			dispatchEvent(new VPEvent({ slot: this }, VPEvent.VPEVT));
		}

		private function doFocus(e:VPEvent):void {
			//e.stopImmediatePropagation();
			for each (var slot in holder) {
				if (zoomlevel > 1 && slot == e.msg['slot']) {
					this['mesh'].x -= slot.parent.x;
					this['mesh'].y -= slot.parent.y;
					zoomlevel--;
				}
			}
		}

		private function bound(base:Shape, q:Number = 0.5):void {
			var s:Number = -(l / 2 + w);

			base.graphics.moveTo(s - q, 0);
			base.graphics.lineTo(s + w - q, h + q);
			base.graphics.lineTo(s + w + l + q, h + q);
			base.graphics.lineTo(s + w * 2 + l + q, 0);
			base.graphics.lineTo(s + w + l + q, -h - q);
			base.graphics.lineTo(s + w - q, -h - q);
		}

		private function hexmod(base:Shape, num:uint):void {
			var posX:Number = -(w * num + l * (num - 1) + l / 2);
			var posY:Number = -(h * num * 2 - ((num % 2) ? h * 2 : h));

			var startX:Number = posX;

			for (var i:uint = 0; i < num << 1; i++) {
				posX = startX;

				for (var j:uint = 0; j < num; j++) {
					base.graphics.moveTo(posX + w, posY - h);
					base.graphics.lineTo(posX + 0, posY);
					base.graphics.lineTo(posX + w, posY + h);
					base.graphics.lineTo(posX + w + l, posY + h);
					base.graphics.lineTo(posX + w * 2 + l, posY);
					base.graphics.lineTo(posX + w * 2 + l * 2, posY);
					base.graphics.moveTo(posX + w * 2 + l, posY);
					base.graphics.lineTo(posX + w + l, posY - h);

					posX += w * 2 + l * 2;
				}

				posY += h * 2;
			}
		}
	}
}
