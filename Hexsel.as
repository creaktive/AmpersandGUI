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
	import flash.events.*;

	public class Hexsel extends Event {
		public static const HEXSEL:String = 'HEXSEL';
		public var params:Object;

		public function Hexsel(params_:Object, type:String, bubbles:Boolean = true, cancelable:Boolean = true) {
			params = params_;
			super(type, bubbles, cancelable);
		}
	}
}
