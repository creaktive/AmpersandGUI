package {
	import flash.events.*;
	import flash.geom.*;

	public class Hexsel extends Event {
		public static const HEXSEL:String = 'HEXSEL';
		public var coords:Object;
		public var factor:Number;

		public function Hexsel(coords_:Point, factor_:Number, type:String, bubbles:Boolean = true, cancelable:Boolean = true) {
			coords = coords_;
			factor = factor_;
			super(type, bubbles, cancelable);
		}
	}
}