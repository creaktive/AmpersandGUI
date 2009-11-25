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
	import Hexlay;
	import Hexsel;

	public class Ampersand extends Sprite {
		private var container:Sprite = new Sprite();
		private var topmost:Hexget;
		private var path:Array = new Array();
		private var view:Hexaffine;

		public function Ampersand():void {
			stage.quality		= StageQuality.HIGH;
			stage.scaleMode		= StageScaleMode.SHOW_ALL;
			//stage.displayState	= StageDisplayState.FULL_SCREEN;
			
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

			topmost = new Hexget(Cell('main'), 250);
			screen.addChild(topmost);

			var border:Shape = new Shape();
			screen.addChild(border)
			border.graphics.lineStyle(0, Hexlay.color_front, 1.0);
			border.graphics.drawCircle(0, 0, 250);


			var sub = topmost.addChild(new Hexget(Cell('sub 1')));
			sub.addChild(Cell('sub 2'));
			sub.addChild(Cell('sub 3'));

			var sub2 = sub.addChild(new Hexget(Cell('sub 4')));
			sub2.addChild(Cell('sub 5'));

			for (var i:uint = 1; i < 10; i++) {
				topmost.addChild(Cell(String(i)));
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

			var fmt:TextFormat		= new TextFormat();
			fmt.align				= TextFormatAlign.CENTER;
			fmt.color				= Hexlay.color_front;
			fmt.font				= 'Trebuchet MS';
			fmt.size				= 50;

			var txt:TextField		= new TextField();
			cell.addChild(txt);
			txt.antiAliasType		= AntiAliasType.ADVANCED;
			txt.blendMode			= BlendMode.LAYER;
			txt.defaultTextFormat	= fmt;
			txt.selectable			= false;
			txt.text				= str;
			txt.wordWrap			= false;

			txt.width				= 200;
			txt.x					= -100;
			txt.y					= -35;

			return cell;
		}

		private function InitMenu():void {
			var list:Array = new Array('O','A','E','S','M','R','L','U','I','N','Z','D','T','Y','K','G','H','X','C','P','W','B','V','F','J','Q');

			var input:InWheel = new InWheel(list);
			input.y = 25;
			container.addChild(input);

			stage.addEventListener(MouseEvent.MOUSE_WHEEL, function (e:MouseEvent):void {
				input.rotation += e.delta;
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
