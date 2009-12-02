package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	import com.pixelwelders.events.Broadcaster;

	import Hexlay;

	public class Hexagram extends TextField {
		[
			Embed(
				source		= 'Hexagram.ttf',
				fontName	= 'Hexagram',
				mimeType	= 'application/x-font-truetype'
			)
		]
		public static const Hexagram:String;

		[
			Embed(
				source		= 'TRANA___.TTF',
				fontName	= 'SixteenSegments',
				mimeType	= 'application/x-font-truetype'
			)
		]
		public static const SixteenSegments:String;

		public static const FONTSWAP:String = 'HEXAGRAM_FONTSWAP';

		private var fonts:Array = new Array();
		private var i:uint = 0;

		public function Hexagram(str:String, size_:Number = 50, bold_:Boolean = false) {
			fonts[0]			= new TextFormat();
			fonts[0].align		= TextFormatAlign.CENTER;
			fonts[0].bold		= bold_;
			fonts[0].color		= Hexlay.color_front;
			fonts[0].font		= 'Hexagram';
			fonts[0].size		= size_;

			fonts[1]			= new TextFormat();
			fonts[1].align		= TextFormatAlign.CENTER;
			fonts[1].bold		= bold_;
			fonts[1].color		= Hexlay.color_front;
			fonts[1].font		= 'SixteenSegments';
			fonts[1].size		= size_;

			antiAliasType		= AntiAliasType.ADVANCED;
			blendMode			= BlendMode.LAYER;
			defaultTextFormat	= fonts[i];
			embedFonts			= true;
			selectable			= false;
			text				= str;
			type				= TextFieldType.DYNAMIC;
			wordWrap			= false;

			Broadcaster.addEventListener(FONTSWAP, function (e:Event):void {
				defaultTextFormat = fonts[++i % fonts.length];
				text = text;
			});
		}
	}
}
