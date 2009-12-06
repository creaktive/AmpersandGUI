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
	import flash.data.*;
	import flash.utils.*;
	import flash.display.*;
	import flash.events.*;
	import flash.filesystem.*;
	import flash.net.*;

	public class OHTI {
		private var sql:SQLConnection = new SQLConnection();
		private var alf:Array = new Array();

		private var lstr:String = null;
		private var keys:Array = new Array();

		public function OHTI() {
			sql.open(File.applicationDirectory.resolvePath('ptbr.sqlite'), SQLMode.READ);

			var q:SQLStatement = new SQLStatement();
			q.sqlConnection = sql;
			q.text = "SELECT c FROM tri WHERE (p = 1) ORDER BY n DESC";
			q.execute();
			var r:SQLResult = q.getResult();
			for each (var row:Object in r.data)
				alf.push(row['c']);
		}

		public function next(str:String):Array {
			if (str == lstr)
				return keys;

			lstr = new String(str.toLowerCase());

			var tri:Dictionary = new Dictionary();
			var a:String = lstr.length >= 2 ? lstr.charAt(lstr.length - 2) : '';
			var b:String = lstr.length >= 1 ? lstr.charAt(lstr.length - 1) : '';

			var q:SQLStatement = new SQLStatement();
			q.sqlConnection = sql;
			q.text = "SELECT a,b,c,p,n FROM tri WHERE (a = '" + a + "' OR a IS NULL) AND (b = '" + b + "' OR b IS NULL) ORDER BY p DESC, n DESC";
			q.execute();
			var r:SQLResult = q.getResult();

			var lp:uint = 0;
			var trisum:uint = 0;
			for each (var row:Object in r.data) {
				if (!lp)
					lp = row['p'];

				if (row['p'] != lp)
					break;

				tri[row['c']] = row['n'];
				trisum += row['n'];
			}

			var dic:Dictionary = new Dictionary();
			var dicsum:uint = 0;
			if (lstr.length > 1) {
				var last:uint = lstr.charCodeAt(lstr.length - 1);
				var ustr:String = new String(lstr.substr(0, lstr.length - 1) + String.fromCharCode(last + 1));
				q.text = "SELECT w,n FROM dic WHERE (w > '" + lstr + "') AND (w < '" + ustr + "') ORDER BY n DESC, w";
				q.execute();
				r = q.getResult();
				for each (var row:Object in r.data) {
					var chr:String = row['w'].charAt(lstr.length);
					if (dic[chr] == undefined)
						dic[chr] = row['n'];
					else
						dic[chr] += row['n'];
					dicsum += row['n'];
				}
			}

			var nxt:Dictionary = new Dictionary();
			for each (var chr:String in alf)
				nxt[chr] = 0.0;

			for (var chr:String in tri)
				nxt[chr] = tri[chr] / trisum;

			for (var chr:String in dic)
				nxt[chr] += dic[chr] / dicsum;

			keys.splice(0);
			for (var k:String in nxt)
				keys.push({chr:k, idx:nxt[k]});

			keys.sortOn(['idx', 'chr'], [Array.DESCENDING | Array.NUMERIC, Array.CASEINSENSITIVE]);
			return keys;
		}

		public function nextChr(str:String, upper:Boolean = false):Array {
			var chrs:Array = new Array();
			for each (var i:Object in next(str))
				chrs.push(upper ? i['chr'].toUpperCase() : i['chr']);
			return chrs;
		}
	}
}
