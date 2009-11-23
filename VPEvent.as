package {
	import flash.events.*;

	public class VPEvent extends Event {
		public static const VPEVT:String = 'VPEVT';
		public var msg:Object;

		public function VPEvent(mymsg:Object, type:String, bubbles:Boolean = true, cancelable:Boolean = true) {
			msg = mymsg;
			super(type, bubbles, cancelable);
		}
	}
}
