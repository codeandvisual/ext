package com.codeandvisual.ext {
	import flash.utils.ByteArray;
	public class Objects {
			public static function selectRandKey(thisObject:Object):String {
			var myArray:Array=buildKeyArray(thisObject);
			var myKey:String=Arrays.getRandItem(myArray);
			return myKey;
		}
		public static function buildKeyArray(thisObject:Object):Array {
			var myArray:Array=[];
			for (var i:String in thisObject) {
				myArray.push(i);
			}
			return myArray;
		}
		public static function traceItems(thisObject:*):void {
			if (thisObject == null) {
				trace( "ALERT - OBJECT WAS NULL - CAN'T TRACE ITEMS")
			}else{
				getObjectCount(thisObject, true)
			}
		}
		public static function getObjectCount(thisObject:*, thisTrace:Boolean = false):int {
			var myCount:int=0;
			for (var i:String in thisObject) {
				if (thisTrace){
					trace("item "+String(myCount)+": "+ i+" = "+thisObject[i])
				}
				myCount++;
				
			}
			return myCount;
		}
		public static function objectToString(thisObject:Object, thisPretty:Boolean = false,thisAlphabetical:Boolean = false):String {
			// works for single dimension objects
			var myString:String="";
			var myFirst:Boolean = true;
			var i:String
			if (thisAlphabetical) {
				var myOrder:Array = []
				for (i in thisObject) {
					myOrder.push(i)
				}
				myOrder.sort()
				
				for (var j:int = 0; j < myOrder.length; j++) {
					var myKey:String = myOrder[j]
					if (! myFirst && !thisPretty) {
						myString+=",";
					} else {
						myFirst=false;
					}
					myString+=myKey+(thisPretty?": ":":")+thisObject[myKey]+(thisPretty?"\n":"");
				}
			}else{
				for (i in thisObject) {
					if (! myFirst && !thisPretty) {
						myString+=",";
					} else {
						myFirst=false;
					}
					myString+=i+(thisPretty?": ":":")+thisObject[i]+(thisPretty?"\n":"");
				}
			}
			return myString;
		}
		public static function stringToObject(thisString:String):Object {
			// works for single dimension strings formatted - "myKey:myValue,myKey2:myValue2..."
			var myObject:Object = new Object();
			var myItems:Array=thisString.split(",");
			for (var i:String in myItems) {
				var myPair:Array=myItems[i].split(":");
				myObject[myPair[0]]=myPair[1];
			}
			return myObject;
		}
		//
		// Need to write this a little more thoroughly to make it recursive for reference items
		public static function duplicateObject(thisObject:Object):Object {
			var myObject:Object=new Object  ;
			for (var i:String in thisObject) {
				myObject[i]=thisObject[i];
			}
			return myObject;
		}
		//
		// This one supposedly does a deep clone
		public static function cloneObject(source:Object):* {
			var copier:ByteArray = new ByteArray();
			copier.writeObject(source);
			copier.position=0;
			return (copier.readObject());
		}
		
		//
		//Need to write this a little more thoroughly to make it recursive for reference items
		public static function mergeObjectsB(thisA:Object, thisB:Object):Object {
			var myNewA:Object=cloneObject(thisA);
			var myNewB:Object=cloneObject(thisB);
			for (var i:String in myNewB) {
				myNewA[i]=myNewB[i];
			}
			return myNewA;
		}
		//
		public static function mergeObjects(thisA:Object, thisB:Object):Object {
			var myNewObject:Object=duplicateObject(thisA);
			for (var i:String in thisB) {
				myNewObject[i]=thisB[i];
			}
			return myNewObject;
		}
		public static function addPropsToObject(thisObject:*, thisProps:Object):void {
			if(thisProps!=null){
				for(var i:String in thisProps){
					thisObject[i]=thisProps[i]
				}
			}
		}
		public static function addProps(thisObject:*, thisProps:Object):void {
			if(thisProps!=null){
				for(var i:String in thisProps){
					if(thisObject.hasOwnProperty(i)){
						thisObject[i]=thisProps[i]
					}
				}
			}
		}
		public static function traceArray(thisArray:Array):void {
			for (var i:int = 0; i < thisArray.length; i++) {
				trace(thisArray[i])
			}
		}
	}
}