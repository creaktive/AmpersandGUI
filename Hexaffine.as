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
