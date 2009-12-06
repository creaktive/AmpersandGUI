/*
This file is part of Ampersand.

Ampersand is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Ampersand is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with Ampersand.  If not, see <http://www.gnu.org/licenses/>.
*/

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
