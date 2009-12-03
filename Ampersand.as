package {
	[
		SWF(
			backgroundColor	= '#000000',
			frameRate		= '30',
			width			= '800',
			height			= '600'
		)
	]

	import fl.managers.*;

	import flash.display.*;
	import flash.events.*
	import flash.geom.*;
	import flash.ui.*;
	import flash.text.*;

	import com.pixelwelders.events.Broadcaster;

	import Hexagram;
	import Hexget;
	import Hexlay;
	import Hexsel;
	import OHTI;

	public class Ampersand extends Sprite {
		[Embed(source='ampersand.svg')]
		private var logoClass:Class;
		private var logo:Sprite = new logoClass();

		[Embed(source='book_text.svg')]
		private var bookClass:Class;
		private var book:Sprite = new bookClass();

		[Embed(source='calculator.svg')]
		private var calculatorClass:Class;
		private var calculator:Sprite = new calculatorClass();

		[Embed(source='calendar.svg')]
		private var calendarClass:Class;
		private var calendar:Sprite = new calendarClass();

		[Embed(source='clock.svg')]
		private var clockClass:Class;
		private var clock:Sprite = new clockClass();

		[Embed(source='download.svg')]
		private var downloadClass:Class;
		private var download:Sprite = new downloadClass();

		[Embed(source='globe.svg')]
		private var globeClass:Class;
		private var globe:Sprite = new globeClass();

		[Embed(source='mail.svg')]
		private var mailClass:Class;
		private var mail:Sprite = new mailClass();

		[Embed(source='music.svg')]
		private var musicClass:Class;
		private var music:Sprite = new musicClass();

		[Embed(source='questionmark.svg')]
		private var questionmarkClass:Class;
		private var questionmark:Sprite = new questionmarkClass();

		[Embed(source='refresh.svg')]
		private var refreshClass:Class;
		private var refresh:Sprite = new refreshClass();

		[Embed(source='settings.svg')]
		private var settingsClass:Class;
		private var settings:Sprite = new settingsClass();

		[Embed(source='upload.svg')]
		private var uploadClass:Class;
		private var upload:Sprite = new uploadClass();

		private var container:Sprite = new Sprite();

		private var topmost:Hexget;
		private var path:Array = new Array();
		private var view:Hexaffine;

		private var ohti:OHTI = new OHTI();

		public function Ampersand():void {
			stage.quality		= StageQuality.HIGH;
			stage.scaleMode		= StageScaleMode.SHOW_ALL;
			//stage.displayState	= StageDisplayState.FULL_SCREEN;

			Multitouch.inputMode = MultitouchInputMode.GESTURE;

			var fm:FocusManager = new FocusManager(this);
			fm.activate();

			addChild(container);
			container.x = 400;
			container.y = 300;

			InitView();
			InitMenu();

			stage.addEventListener(MouseEvent.MIDDLE_CLICK, function (e:MouseEvent):void {
				Broadcaster.dispatchEvent(new Event(Hexagram.FONTSWAP));
			});
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

			var root:Sprite = Cell('ampersand v0.1');
			topmost = new Hexget(root, 250);
			screen.addChild(topmost);

			var border:Shape = new Shape();
			screen.addChild(border)
			border.graphics.lineStyle(0, Hexlay.color_front, 1.0);
			border.graphics.drawCircle(0, 0, 250);

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

			/*
			addChild(new Hexagram('puta que o pariu', 25, 400, false, TextFieldType.INPUT, TextFormatAlign.LEFT));
			*/

			root.addChild(logo);
			logo.x = logo.y = -250;
			logo.transform.colorTransform = new Hexlay();
			logo.alpha = 0.1;

			root.addChild(SetupIcon(book, 'apresentacao', 0));
			var started:Boolean = false;
			book.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				if (!started) {
					started = true;

					var apr_root:Sprite = Cell('apresentacao');
					var apr = topmost.addChild(new Hexget(apr_root));

					apr_root.addChild(SetupIcon(questionmark, 'paradigmas', 7, 100));
					var paradigmas = null;
					questionmark.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						if (!paradigmas) {
							paradigmas = apr.addChild(new Hexget(Cell('paradigmas')));
							paradigmas.addChild(Cell('A'));
							paradigmas.addChild(Cell('B'));
							paradigmas.addChild(Cell('C'));
							paradigmas.addChild(Cell('D'));
						}
					});

					apr_root.addChild(SetupIcon(download, 'input', 1, 100));
					var input = null;
					download.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						if (!input) {
							input = apr.addChild(new Hexget(Cell('input')));
							input.addChild(Cell('A'));
							input.addChild(Cell('B'));
							input.addChild(Cell('C'));
							input.addChild(Cell('D'));
							input.addChild(Cell('E'));
							input.addChild(Cell('F'));
							input.addChild(Cell('G'));
						}
					});

					apr_root.addChild(SetupIcon(upload, 'output', 3, 100));
					var output = null;
					upload.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						if (!output) {
							output = apr.addChild(new Hexget(Cell('output')));
							output.addChild(Cell('A'));
							output.addChild(Cell('B'));
							output.addChild(Cell('C'));
							output.addChild(Cell('D'));
							output.addChild(Cell('E'));
						}
					});

					apr_root.addChild(SetupIcon(refresh, 'proposta', 5, 100));
					var proposta = null;
					refresh.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						if (!proposta) {
							proposta = apr.addChild(new Hexget(Cell('proposta')));
							proposta.addChild(Cell('A'));
							proposta.addChild(Cell('B'));
							proposta.addChild(Cell('C'));
						}
					});
				}
			});

			root.addChild(SetupIcon(mail, 'email', 1));

			root.addChild(SetupIcon(calculator, 'calculadora', 2));
			root.addChild(SetupIcon(calendar, 'calendario', 3));
			root.addChild(SetupIcon(clock, 'relogio', 4));
			root.addChild(SetupIcon(globe, 'internet', 5));
			root.addChild(SetupIcon(music, 'musica', 6));
			root.addChild(SetupIcon(settings, 'configuracoes', 7));
		}

		private function Unzoom():void {
			if (path.length) {
				var last:Object = path.pop();
				last['ref'].overview();
				PlaceView();
			}
		}

		private function SetupIcon(src:Sprite, title:String, idx:uint, r:Number = 150):Sprite {
			var ang:Number = idx * (Math.PI / 4);
			src.x = r * Math.cos(ang) - 25;
			src.y = r * Math.sin(ang) - 25;

			src.transform.colorTransform = new Hexlay();
			src.scaleX = src.scaleY = 1.5625;

			var hit:Sprite = new Sprite();
			src.addChild(hit);
			hit.visible = false;
			src.hitArea = hit;

			var bg:Shape = new Shape();
			hit.addChild(bg);

			bg.graphics.lineStyle(0, 0xffffff, 1.0);
			bg.graphics.beginFill(0xffffff, 1.0);
			bg.graphics.drawCircle(12.5, 12.5, 25);
			bg.graphics.endFill;

			var txt:Hexagram = new Hexagram(title, 14);
			src.addChild(txt);
			txt.mouseEnabled = false;
			txt.width = 100;
			txt.x = -37.5;
			txt.y = 30;

			return src;
		}

		private function Cell(str:String):Sprite {
			var cell:Sprite = new Sprite();

			var bg:Shape = new Shape();
			cell.addChild(bg);
			bg.graphics.lineStyle(0, Hexlay.color_back, 1.0);
			bg.graphics.beginFill(Hexlay.color_back, 1.0);
			bg.graphics.drawCircle(0, 0, 400);
			bg.graphics.endFill;

			var txt:Hexagram = new Hexagram(str, 40, 500, true);
			cell.addChild(txt);
			txt.x = -250;
			txt.y = -225;

			return cell;
		}

		private function InitMenu():void {
			var input:InWheel = new InWheel(ohti.nextChr(''));
			input.y = 25;
			container.addChild(input);

			stage.addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
				if (stage.focus is TextField) {
					var tf:TextField = TextField(stage.focus);
					if (tf.type == TextFieldType.INPUT) {
						var cw:Object = CurrentWord(tf);
						input.Reload(ohti.nextChr(cw['word']));
					}
				}
			});

			stage.addEventListener(KeyboardEvent.KEY_DOWN, function (e:KeyboardEvent):void {
				if (stage.focus is TextField) {
					var tf:TextField = TextField(stage.focus);
					if (tf.type == TextFieldType.INPUT) {
						var chr:String = String.fromCharCode(e.charCode);

						var cw:Object = CurrentWord(tf);

						if (e.charCode == Keyboard.BACKSPACE) {
							tf.text = tf.text.substring(0, cw['to'] - 1) + tf.text.substring(cw['to']);
							tf.setSelection(cw['to'] - 1, cw['to'] - 1);
							input.Reload(ohti.nextChr(cw['word'].substring(0, -1)));
						} else {
							tf.text = tf.text.substring(0, cw['to']) + chr + tf.text.substring(cw['to']);
							tf.setSelection(cw['to'] + 1, cw['to'] + 1);
							input.Reload(ohti.nextChr(cw['word'] + chr));
						}
					}
				}
			});

			stage.addEventListener(MouseEvent.MOUSE_WHEEL, function (e:MouseEvent):void {
				input.Impulse(e.delta);
			});

			stage.addEventListener(TransformGestureEvent.GESTURE_ROTATE, function (e:TransformGestureEvent):void {
				input.Impulse(e.rotation);
			});
		}

		private function CurrentWord(tf:TextField):Object {
			var i:int = tf.selectionBeginIndex - 1;
			while (i >= 0) {
				var chr:uint = tf.text.charCodeAt(i);
				if (!(((chr >= 0x41) && (chr <= 0x5A)) || ((chr >= 0x61) && (chr <= 0x7A))))
					break;

				i--;
			}
			var from:uint = i + 1;

			for (var i:int = from; i < tf.text.length; i++) {
				var chr:uint = tf.text.charCodeAt(i);
				if (!(((chr >= 0x41) && (chr <= 0x5A)) || ((chr >= 0x61) && (chr <= 0x7A))))
					break;
			}
			var to:uint = i;

			return { word: tf.text.substring(from, to), from: from, to: to };
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
