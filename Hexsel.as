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