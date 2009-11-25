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
	import flash.geom.*;
	import flash.text.*;

	import Hexget;
	import Hexsel;

	public class Ampersand extends Sprite {
		private var topmost:Hexget;
		private var path:Array = new Array();
		private var view:Hexaffine;

		public function Ampersand():void {
			var container:Sprite = new Sprite();
			container.x = 400;
			container.y = 300;
			addChild(container);

			topmost = new Hexget(testshape(0xff0000));
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

			addEventListener(Hexsel.HEXSEL, function (e:Hexsel):void {
				path.push(e.params);
				PlaceView();
			});

			addEventListener(MouseEvent.RIGHT_CLICK, function (e:MouseEvent):void {
				if (path.length) {
					var last:Object = path.pop();
					last['ref'].overview();
					PlaceView();
				}
			});
		}

		private function PlaceView():void {
			var factor:Number = 1;
			var myX:Number = 0;
			var myY:Number = 0;

			for each (var params:Object in path) {
				factor *= params['factor'];
				myX = (myX * params['factor']) - params['coords']['x'];
				myY = (myY * params['factor']) - params['coords']['y'];
			}

			view = new Hexaffine(topmost.transform.matrix, myX, myY, factor);
			removeEventListener(Event.ENTER_FRAME, ScaleView);
			addEventListener(Event.ENTER_FRAME, ScaleView);
		}

		private function ScaleView(e:Event):void {
			if ((topmost.transform.matrix = view.next()) == view)
				removeEventListener(Event.ENTER_FRAME, ScaleView);
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
