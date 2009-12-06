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
	import flash.display.*;
	import flash.events.*;
	import flash.ui.*;

	import Hexagram;
	import Hexlay;
	import InWheel;

	public class Spot extends Sprite {
		[Embed(source='arrow_sans_left.svg')]
		private var backspaceClass:Class;
		private var backspace:Sprite = new backspaceClass();

		[Embed(source='arrow_sans_right.svg')]
		private var spaceClass:Class;
		private var space:Sprite = new spaceClass();

		[Embed(source='calculator.svg')]
		private var calculatorClass:Class;
		private var calculator:Sprite = new calculatorClass();

		[Embed(source='paragraph.svg')]
		private var paragraphClass:Class;
		private var paragraph:Sprite = new paragraphClass();


		private var bg:Shape = new Shape();
		private var txt:Hexagram;

		public function Spot(str:String) {
			addChild(bg);
			bg.graphics.lineStyle(0, Hexlay.color_front);
			bg.graphics.beginFill(Hexlay.color_back);
			bg.graphics.drawCircle(0, 0, 50);
			bg.graphics.endFill;

			if (str.length > 1) {
				if (str == 'BCK') {
					addChild(backspace);
					backspace.transform.colorTransform = new Hexlay();
					backspace.x = backspace.y = -25;
					backspace.scaleX = backspace.scaleY = 1.5625;

					addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, Keyboard.BACKSPACE, Keyboard.BACKSPACE));
					});
				} else if (str == 'NUM') {
					addChild(calculator);
					calculator.transform.colorTransform = new Hexlay();
					calculator.x = calculator.y = -25;
					calculator.scaleX = calculator.scaleY = 1.5625;
	
					addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						e.stopImmediatePropagation();
						InWheel(parent).Reload(new Array('0','1','2','3','4','5','6','7','8','9',',','.','+','-','*','/','%','(',')','='));
					});
				} else if (str == 'SPC') {
					addChild(paragraph);
					paragraph.transform.colorTransform = new Hexlay();
					paragraph.x = paragraph.y = -25;
					paragraph.scaleX = paragraph.scaleY = 1.5625;

					addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						e.stopImmediatePropagation();
						InWheel(parent).Reload(new Array('_','.',',',';',':','?','!','@','$','&','~','^','\\','|','<','>','[',']','{','}'));
					});
				} else if (str == 'WSP') {
					addChild(space);
					space.transform.colorTransform = new Hexlay();
					space.x = space.y = -25;
					space.scaleX = space.scaleY = 1.5625;

					addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
						stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, Keyboard.SPACE, Keyboard.SPACE));
					});
				}
			} else {
				txt = new Hexagram(str, 100);
				addChild(txt);
				txt.mouseEnabled = false;
				txt.width = 100;
				txt.x = -47;
				txt.y = -65;

				var chr:uint = str.charCodeAt(0);
				addEventListener(MouseEvent.CLICK, function (e:MouseEvent):void {
					stage.dispatchEvent(new KeyboardEvent(KeyboardEvent.KEY_DOWN, true, false, chr, chr));
				});
			}
		}
	}
}
