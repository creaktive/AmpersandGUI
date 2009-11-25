package {
	import flash.text.*;

	public class Hexlay extends TextFormat {
		[
			Embed(
				systemFont	= 'weirdo',
				fontName	= 'Hexagram',
				mimeType	= 'application/x-font-truetype'
			)
		]
		public static const Hexagram:String;

		public static const color_front:uint	= 0xFF8822;
		public static const color_back:uint		= 0x221100;

		public function Hexlay(size_:Number = 20, bold_ = false) {
			align	= TextFormatAlign.CENTER;
			bold	= bold_;
			color	= Hexlay.color_front;
			//font	= 'Trebuchet MS';
			font	= 'Hexagram';
			size	= size_;
		}
	}
}
