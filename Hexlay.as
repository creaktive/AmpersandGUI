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
	import fl.motion.*;
	import flash.geom.*;

	public class Hexlay extends Color {
		public static const color_front:uint	= 0xFF8822;
		public static const color_back:uint		= 0x221100;
		public static const color_half:uint		= 0x361C03;

		public function Hexlay() {
			setTint(color_front, 1.0);
		}
	}
}
