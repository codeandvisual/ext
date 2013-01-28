package com.codeandvisual.ext {
	public class Numbers {
		static public var pDynamicId:int=0;
		public static function getDynamicId():int {
			var myId:int=pDynamicId;
			pDynamicId++;
			return myId;
		}
		public static function resetDynamicId():void {
			pDynamicId=0;
		}
		public static function roundTo(thisNumber:Number, thisPrecision:int):Number {
			thisNumber*=Math.pow(10,thisPrecision);
			thisNumber=Math.round(thisNumber);
			thisNumber/=Math.pow(10,thisPrecision);
			return thisNumber;
		}
		public static function getRandInRange(thisMin:Number, thisMax:Number):Number {
			var myRange:Number = thisMax - thisMin
			var myRandom:Number = thisMin + Math.random() * myRange
			return myRandom
		}
		public static function getRandIntInRange(thisMin:int, thisMax:int):int {
			var myRange:Number = thisMax - thisMin
			var myRandom:int = Math.round(thisMin + Math.random() * myRange)
			return myRandom
		}
		public static function clamp(thisNumber:Number, thisMin:Number = NaN, thisMax:Number = NaN):Number {
			thisNumber = isNaN(thisMin)?thisNumber:Math.max(thisNumber, thisMin)
			thisNumber = isNaN(thisMax)?thisNumber:Math.min(thisNumber, thisMax)
			return thisNumber
		}
		public static function upperPowerOfTwo(num:uint):uint { 
			//if (num == 1) return 2; 
			
			num--; 
			num |= num >> 1; 
			num |= num >> 2; 
			num |= num >> 4; 
			num |= num >> 8; 
			num |= num >> 16; 
		 
			num++; 
		 
			return num; 
		} 
		public static function getRandDivisions(thisDivisionCount:int = 10, thisStart:Number = 0, thisEnd:Number = 1, thisIncludeStart:Boolean = false, thisIncludeEnd:Boolean = true):Array {
		
			
			// won't implement include start and include and just yet
			var myResults:Array = []
			var myRange:Number = thisEnd-thisStart
			var myAmountPerDivision:Number = myRange / thisDivisionCount
			var myVariationRatio:Number = .9
			var myCurrentPoint:Number = thisStart
			for (var i:int = 0; i < thisDivisionCount; i++) {
				myRange = thisEnd-myCurrentPoint
				myAmountPerDivision = myRange / (thisDivisionCount - i);
				var myVariationMinimum:Number = myAmountPerDivision - (myAmountPerDivision * myVariationRatio)
				var myVariationMax:Number = myAmountPerDivision * (1 + myVariationRatio)
				var myVariationRange:Number = myVariationMax - myVariationMinimum
				var myAmount:Number = myRange==myAmountPerDivision?myRange:myVariationMinimum + (myVariationRange * Math.random())
				myCurrentPoint += myAmount
				myResults.push(myCurrentPoint)
				
			}
			return myResults
			
		}
	}
}