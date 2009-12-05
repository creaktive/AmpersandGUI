package {
	import com.pixelwelders.events.Broadcaster;

	import flash.events.*;

	public class FontSwapper {
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
		public static var CurrentFont:uint = 0;

		public static function swap():void {
			CurrentFont = ++CurrentFont % 2;
			Broadcaster.dispatchEvent(new Event(FONTSWAP));
		}
	}
}
