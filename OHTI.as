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
			str = str.toLowerCase();

			var tri:Dictionary = new Dictionary();
			var a:String = str.length >= 2 ? str.charAt(str.length - 2) : '';
			var b:String = str.length >= 1 ? str.charAt(str.length - 1) : '';

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
			if (str.length > 1) {
				var last:uint = str.charCodeAt(str.length - 1);
				var ustr:String = new String(str.substr(0, str.length - 1) + String.fromCharCode(last + 1));
				q.text = "SELECT w,n FROM dic WHERE (w > '" + str + "') AND (w < '" + ustr + "') ORDER BY n DESC, w";
				q.execute();
				r = q.getResult();
				for each (var row:Object in r.data) {
					var chr:String = row['w'].charAt(str.length);
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

			var keys:Array = new Array();
			for (var k:String in nxt)
				keys.push({chr:k, idx:nxt[k]});

			keys.sortOn(['idx', 'chr'], [Array.DESCENDING | Array.NUMERIC, Array.CASEINSENSITIVE]);
			return keys;
		}

		public function nextChr(str:String, upper:Boolean = false):Array {
			var keys:Array = new Array();
			for each (var i:Object in next(str))
				keys.push(upper ? i['chr'].toUpperCase() : i['chr']);
			return keys;
		}
	}
}
