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
	import flash.geom.*;

	public class Hexaffine extends Matrix {
		private var ini:Matrix;
		private var steps:uint;
		private var i:uint = 0;

		public function Hexaffine(ini_:Matrix, x_:Number, y_:Number, factor_:Number, steps_:uint = 10) {
			ini = ini_;
			steps = steps_;

			scale(factor_, factor_);
			translate(x_, y_);
		}

		public function next():Matrix {
			if (i++ < steps)
				return between(i / steps);
			else
				return this;
		}

		private function between(t:Number = 1.0):Matrix {
			var mi	= new Matrix();
			mi.a	= ini.a + (a - ini.a) * t;
			mi.b	= ini.b + (b - ini.b) * t;
			mi.c	= ini.c + (c - ini.c) * t;
			mi.d	= ini.d + (d - ini.d) * t;
			mi.tx	= ini.tx + (tx - ini.tx) * t;
			mi.ty	= ini.ty + (ty - ini.ty) * t;
			return	mi;
		}
	}
}
