package {
	[SWF(width = '302', height = '202')]

	import flash.display.*;
	import flash.geom.*;

	public class new1 extends Sprite {
		[Embed(source='new1.svg')]
		private var svgClass:Class;
		private var svg:Sprite = new svgClass();

		public function new1(){
			var clr:ColorTransform = svg.transform.colorTransform;
			clr.color = 0xFF8822;
			svg.transform.colorTransform = clr; 
			addChild(svg);
		}
	}
}
