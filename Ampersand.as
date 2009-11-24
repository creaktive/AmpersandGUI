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
	import flash.text.*

	import Hexget;
	import Hexsel;

	public class Ampersand extends Sprite {
		public function Ampersand():void {
			var container:Sprite = new Sprite();
			container.x = 400;
			container.y = 300;
			addChild(container);

			var topmost:Hexget = new Hexget(testshape(0xff0000));
			container.addChild(topmost);

			var sub = topmost.addChild(new Hexget(testshape(0x00ff00)));
			sub.addChild(testshape(0x0000ff));
			sub.addChild(testshape(0xff00ff));

			for (var i:uint = 1; i < 15; i++) {
				var crap:Sprite = new Sprite();
				crap.addEventListener(MouseEvent.CLICK, function () {
					trace('fuck');
				});

				crap.addChild(testshape(Math.round(Math.random() * 0xffffff)));

				var fmt:TextFormat		= new TextFormat();
				fmt.align				= TextFormatAlign.CENTER;
				fmt.color				= 0xffffff;
				fmt.font				= 'Trebuchet MS';
				fmt.size				= 100;

				var txt:TextField		= new TextField();
				crap.addChild(txt);
				txt.antiAliasType		= AntiAliasType.ADVANCED;
				txt.blendMode			= BlendMode.LAYER;
				txt.defaultTextFormat	= fmt;
				txt.selectable			= false;
				txt.text				= String(i++);
				txt.wordWrap			= false;

				txt.width				= 200;
				txt.x					= -100;
				txt.y					= -65;

				topmost.addChild(crap);
			}

			var factor:Number = 1;
			addEventListener(Hexsel.HEXSEL, function (e:Hexsel) {
				factor *= e.factor;
				topmost.x = topmost.x * e.factor - e.coords.x;
				topmost.y = topmost.y * e.factor - e.coords.y;
				topmost.scaleX = topmost.scaleY = factor;
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
