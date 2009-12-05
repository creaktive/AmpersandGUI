package {
	import flash.display.*;
	import flash.events.*;
	import flash.text.*;

	import com.pixelwelders.events.Broadcaster;

	import FontSwapper;
	import Hexlay;

	public class Hexagram extends TextField {
		private var fonts:Array = new Array();

		public function Hexagram(str:String, size_:Number = 50, width_:Number = 400, bold_:Boolean = false, type_:String = TextFieldType.DYNAMIC, align_:String = TextFormatAlign.CENTER) {
			fonts[0]			= new TextFormat();
			fonts[0].align		= align_;
			fonts[0].bold		= bold_;
			fonts[0].color		= Hexlay.color_front;
			fonts[0].font		= 'SixteenSegments';	// 'Hexagram';
			fonts[0].size		= size_;

			fonts[1]			= new TextFormat();
			fonts[1].align		= align_;
			fonts[1].bold		= bold_;
			fonts[1].color		= Hexlay.color_front;
			fonts[1].font		= 'Hexagram';			//'SixteenSegments';
			fonts[1].size		= size_;

			antiAliasType		= AntiAliasType.ADVANCED;
			blendMode			= BlendMode.LAYER;
			defaultTextFormat	= fonts[FontSwapper.CurrentFont];
			embedFonts			= true;
			selectable			= true;
			text				= str;
			type				= type_;
			width				= width_;
			height				= size_ * 4;
			wordWrap			= true;

			if (type_ == TextFieldType.INPUT) {
				border			= true;
				borderColor		= Hexlay.color_half;
				height			= size_ + 4;
			}

			Broadcaster.addEventListener(FontSwapper.FONTSWAP, function (e:Event):void {
				defaultTextFormat = fonts[FontSwapper.CurrentFont];
				text = text;
			});
		}
	}
}
