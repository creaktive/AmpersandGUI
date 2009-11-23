package {
	[
		SWF(
			backgroundColor	= '#000000',
			frameRate		= '30',
			width			= '800',
			height			= '600'
		)
	]

	import flash.display.*;
	
	import ViewPort;

	public class Ampersand extends Sprite {
		public function Ampersand():void {
			var viewport:ViewPort = new ViewPort();
			addChild(viewport);

			viewport.x = 400;
			viewport.y = 300;

			viewport.zoomlevel = 2;

			var teste = viewport.insert(new ViewPort());
			teste.zoomlevel = 3;

			var teste2 = viewport.insert(new ViewPort());
			teste2.zoomlevel = 2;

			var teste3 = teste2.insert(new ViewPort());
			teste3.zoomlevel = 3;
		}
	}
}
