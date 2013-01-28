package com.codeandvisual.ext {
	public class Arrays {
		//
		//
		//***************************************************************************
		//
		//
		// ARRAYS
		//
		//
		//***************************************************************************
		public static function getRandItem(thisArray:*, thisDelete:Boolean=false):* {
			var myItem:*=null;
			if (thisArray) {
				var myLength:int=thisArray.length;
				if (myLength>0) {
					var myIndex:int=getRandomIndex(thisArray);
					if (myIndex!=-1) {
						if (thisDelete) {
							myItem=thisArray.splice(myIndex,1)[0];
						} else {
							myItem=thisArray[myIndex];
						}
					}
				}
			}
			return myItem;
		}
		public static function getRandItems(thisArray:*,thisCount:int,thisDelete:Boolean=false,thisRepeat:Boolean = false):Array {	
			var myReturn:Array = []
			if (thisArray) {
				var myIndexes:Array = buildIndexArray(thisArray.length)
				for (var i:int = 0; i < thisCount; i++) {
					var myItem:*= null;
					var myLength:int = thisArray.length;
					if (myLength>0) {
						var myIndex:int = thisRepeat || thisDelete? getRandomIndex(thisArray):getRandItem(myIndexes, true);
						if (myIndex!=-1) {
							if (thisDelete) {
								myItem=thisArray.splice(myIndex,1)[0];
							} else {
								myItem = thisArray[myIndex];
							}
							myReturn.push(myItem)
						}
					}
				}
			}
			return myReturn;
		}
		public static function getRandIndexes(thisArray:*,thisCount:int,thisRepeat:Boolean = false):Array {	
			var myReturn:Array = []
			if (thisArray) {
				var myIndexes:Array = buildIndexArray(thisArray.length)
				for (var i:int = 0; i < thisCount; i++) {
					var myLength:int = myIndexes.length;
					if (myLength>0) {
						var myIndex:int = thisRepeat? getRandomIndex(myIndexes):getRandItem(myIndexes, true);
						if (myIndex!=-1) {
							myReturn.push(myIndex)
						}
					}
				}
			}
			return myReturn;
		}
		public static function buildIndexArray(thisCount:int):Array {
			var myArray:Array = []
			for (var i:int = 0; i < thisCount; i++) {
				myArray.push(i)
			}
			return myArray
		}
		public static function getRandomIndex(thisArray:*):int {
			var myIndex:int=-1;
			if (thisArray) {
				var myLength:int=thisArray.length;
				if (myLength>0) {
					myIndex =	getRandInt(myLength);
				}
			}
			return myIndex;
		}
		public static function getRandInt(thisMax:int=100, thisZero:Boolean=true):int {
			var myInt:int = thisZero?Math.floor(Math.random() * thisMax):Math.ceil(Math.random() * thisMax);
			return myInt
		}
		public static function duplicateArray(thisArray:Array):Array {
			// single level only
			var myOutput:Array=[];
			for (var i:String in thisArray) {
				myOutput[i]=thisArray[i];
			}
			return myOutput;
		}
		public static function last(thisObject:*):* {
			var myValue:*
			if (thisObject is Array) {
				myValue  = thisObject[thisObject.length-1]
			}
			return myValue
		}
	}
}