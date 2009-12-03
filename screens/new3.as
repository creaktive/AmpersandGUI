package {
	[SWF(width = '335', height = '308')]

	import flash.display.*;
	import flash.geom.*;

	public class new3 extends Sprite {
		[Embed(source='new3.svg')]
		private var svgClass:Class;
		private var svg:Sprite = new svgClass();

		public function new3(){
			var clr:ColorTransform = svg.transform.colorTransform;
			clr.color = 0xFF8822;
			svg.transform.colorTransform = clr; 

			svg.scaleX = svg.scaleY = 0.75;

			addChild(svg);
		}
	}
}
