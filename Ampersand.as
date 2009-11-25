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
	import flash.ui.*;

	import Hexagram;
	import Hexget;
	import Hexlay;
	import Hexsel;

	public class Ampersand extends Sprite {
		private var container:Sprite = new Sprite();
		private var topmost:Hexget;
		private var path:Array = new Array();
		private var view:Hexaffine;

		private var fmt:Hexlay = new Hexlay(60);

		public function Ampersand():void {
			stage.quality		= StageQuality.HIGH;
			stage.scaleMode		= StageScaleMode.SHOW_ALL;
			//stage.displayState	= StageDisplayState.FULL_SCREEN;

			Multitouch.inputMode = MultitouchInputMode.GESTURE;

			addChild(container);
			container.x = 400;
			container.y = 300;

			InitView();
			InitMenu();
		}

		private function InitView():void {
			var screen:Sprite = new Sprite();
			screen.y = 50;
			container.addChild(screen);

			var port:Shape = new Shape();
			screen.addChild(port);
			port.graphics.lineStyle(0, 0xffffff, 1.0);
			port.graphics.beginFill(0xffffff, 1.0);
			port.graphics.drawCircle(0, 0, 251);
			port.graphics.endFill;
			screen.mask = port;

			topmost = new Hexget(Cell('PRINCIPAL'), 250);
			screen.addChild(topmost);

			var border:Shape = new Shape();
			screen.addChild(border)
			border.graphics.lineStyle(0, Hexlay.color_front, 1.0);
			border.graphics.drawCircle(0, 0, 250);


			var sub = topmost.addChild(new Hexget(Cell('NIVEL 2 A')));
			sub.addChild(Cell('NIVEL 2 B'));
			sub.addChild(Cell('NIVEL 2 C'));

			var sub2 = sub.addChild(new Hexget(Cell('NIVEL 3 A')));
			sub2.addChild(Cell('NIVEL 3 B'));

			for (var i:uint = 1; i < 10; i++)
				topmost.addChild(Cell('NIVEL 1 ' + i));


			addEventListener(Hexsel.HEXSEL, function (e:Hexsel):void {
				path.push(e.params);
				PlaceView();
			});

			stage.addEventListener(MouseEvent.RIGHT_CLICK, function (e:MouseEvent):void {
				Unzoom();
			});

			stage.addEventListener(TransformGestureEvent.GESTURE_ZOOM, function (e:TransformGestureEvent):void {
				if ((e.scaleX + e.scaleY) / 2 < 0.8)
					Unzoom();
			});
		}

		private function Unzoom():void {
			if (path.length) {
				var last:Object = path.pop();
				last['ref'].overview();
				PlaceView();
			}
		}

		private function Cell(str:String):Sprite {
			var cell:Sprite = new Sprite();
			cell.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				trace('test');
			});

			var bg:Shape = new Shape();
			cell.addChild(bg);
			bg.graphics.lineStyle(0, Hexlay.color_back, 1.0);
			bg.graphics.beginFill(Hexlay.color_back, 1.0);
			bg.graphics.drawCircle(0, 0, 400);
			bg.graphics.endFill;

			var txt:Hexagram = new Hexagram(str, fmt);
			cell.addChild(txt);
			txt.width = 500;
			txt.x = -250;
			txt.y = -35;

			return cell;
		}

		private function InitMenu():void {
			var list:Array = new Array('O','A','E','S','M','R','L','U','I','N','Z','D','T','Y','K','G','H','X','C','P','W','B','V','F','J','Q');

			var input:InWheel = new InWheel(list);
			input.y = 25;
			container.addChild(input);

			stage.addEventListener(MouseEvent.MOUSE_WHEEL, function (e:MouseEvent):void {
				input.rotation -= e.delta * 5;
			});

			stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, function (e:TransformGestureEvent):void {
				input.rotation -= e.rotation * 5;
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
	}
}
