package com.codeandvisual.ext {
	public class Misc {
		static public var reg_email:RegExp=/^[A-Z0-9._%+-]+@(?:[A-Z0-9-]+\.)+[A-Z]{2,4}$/i;
		static public function isTrue(thisInput:*):Boolean {
			var myTrue:Boolean=thisInput=="1"||thisInput==1||String(thisInput).toLowerCase()=="true"||String(thisInput).toLowerCase()=="yes"||thisInput==true;
			return myTrue;
		}

		public static function isEmail(thisEmail:String):Boolean {
			var myValid:Boolean  =  Misc.reg_email.exec(thisEmail)
			return myValid
		}
	}
}