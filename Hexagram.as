package {
	import flash.display.*;
	import flash.text.*;

	import Hexlay;

	public class Hexagram extends TextField {
		public function Hexagram(str:String, fmt:Hexlay) {
			antiAliasType		= AntiAliasType.ADVANCED;
			blendMode			= BlendMode.LAYER;
			defaultTextFormat	= fmt;
			embedFonts			= true;
			selectable			= false;
			text				= str;
			wordWrap			= false;
		}
	}
}
