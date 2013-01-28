package com.codeandvisual.ext {
	
	//
	//***************************************************************
	//
	//
	// @author James McNess
	//
	//
	//***************************************************************
	public class Finance {
		public static function getTax(thisTaxableIncome:Number):Number {
			var myAmount:Number = 0
			var myRemainder:Number = 0
			var myBrackets:Array = [180000, 80000, 37000, 18200]
			
			if (thisTaxableIncome > myBrackets[0]) {
				myRemainder = thisTaxableIncome - myBrackets[0]
				myAmount = 54547 + (myRemainder * .45)
			} else if (thisTaxableIncome > myBrackets[1]) {
				myRemainder = thisTaxableIncome - myBrackets[1]
				myAmount = 17547 + (myRemainder * .37)
			} else if (thisTaxableIncome > myBrackets[2]) {
				myRemainder = thisTaxableIncome - myBrackets[2]
				myAmount = 3572 + (myRemainder * .325)
			} else if (thisTaxableIncome > myBrackets[3]) {
				myRemainder = thisTaxableIncome - myBrackets[3]
				myAmount = (myRemainder * .19)
			}
			return myAmount
		}
		
		public static function addInterest(thisAmount:Number, thisRate:Number):Number {
			return thisAmount + thisAmount * thisRate
		}
		
		public static function compoundInterest(thisAmount:Number, thisRate:Number, thisYears:Number, thisTrend:Number = 1):Number {
			var myAmount:Number = thisAmount
			var myRate:Number = thisRate
			for (var i:int = 0; i < thisYears; i++) {
				myAmount += (myAmount * myRate)
				myRate *= thisTrend
			}
			return myAmount
		}
		
		// this is for full doc
		public static function mortgageInsuranceRate(thisLoan:Number, thisValue:Number):Number {
			var myLVR:Number = lvr(thisLoan, thisValue)
			var myRate:Number = 0
			if (thisLoan <= 300000) {
				if (myLVR > .94) {
					myRate = .021
				} else if (myLVR > .92) {
					myRate = .0189
				} else if (myLVR > .9) {
					myRate = .0168
				} else if (myLVR > .88) {
					myRate = .0122
				} else if (myLVR > .86) {
					myRate = .0091
				} else if (myLVR > .84) {
					myRate = .0075
				} else if (myLVR > .82) {
					myRate = .0061
				} else if (myLVR > .80) {
					myRate = .0041
				}
			} else if (thisLoan <= 600000) {
				if (myLVR > .94) {
					myRate = .0274
				} else if (myLVR > .92) {
					myRate = .0247
				} else if (myLVR > .9) {
					myRate = .0220
				} else if (myLVR > .88) {
					myRate = .0160
				} else if (myLVR > .86) {
					myRate = .0118
				} else if (myLVR > .84) {
					myRate = .0099
				} else if (myLVR > .82) {
					myRate = .0078
				} else if (myLVR > .80) {
					myRate = .0052
				}
			} else {
				if (myLVR > .94) {
					myRate = .0376
				} else if (myLVR > .92) {
					myRate = .0356
				} else if (myLVR > .9) {
					myRate = .0331
				} else if (myLVR > .88) {
					myRate = .0202
				} else if (myLVR > .86) {
					myRate = .015
				} else if (myLVR > .84) {
					myRate = .0125
				} else if (myLVR > .82) {
					myRate = .0101
				} else if (myLVR > .80) {
					myRate = .0072
				}
			}
			return myRate
		}
		
		public static function lvr(thisLoan:Number, thisAmount:Number):Number {
			return thisLoan / thisAmount
		}
		
		public static function mortgageInsuranceAmount(thisLoan:Number, thisValue:Number):Number {
			return mortgageInsuranceRate(thisLoan, thisValue) * thisLoan
		}
		public static function discountedStampDuty(thisValue:Number):Number {
			var myDuty:Number = 0
			var myStartThreshold:Number = 550000
			var myEndThreshold:Number = 650000
			var myRange:Number = myEndThreshold - myStartThreshold
			if (thisValue > myStartThreshold) {
				myDuty = stampDuty(thisValue)
				if (thisValue < myEndThreshold) {
					var myDifference:Number = thisValue-myStartThreshold
					var myPercent:Number = myDifference / myRange
					myDuty *= myPercent
				}	
			}
			return myDuty
			
		}
		public static function stampDuty(thisValue:Number):Number {
			var myDuty:Number = 0
			var myRemainder:Number = 0
			var myBrackets:Array = [1000000, 300000, 80000, 30000, 14000]
			if (thisValue > myBrackets[0]) {
				myRemainder = thisValue - myBrackets[0]
				myDuty = 40490 + myRemainder * .055
			} else if (thisValue > myBrackets[1]) {
				myRemainder = thisValue - myBrackets[1]
				myDuty = 8990 + myRemainder * .045
			} else if (thisValue > myBrackets[2]) {
				myRemainder = thisValue - myBrackets[2]
				myDuty = 1290 + myRemainder * .035
			} else if (thisValue > myBrackets[3]) {
				myRemainder = thisValue - myBrackets[3]
				myDuty = 415 + myRemainder * .0175
			} else if (thisValue > myBrackets[4]) {
				myRemainder = thisValue - myBrackets[4]
				myDuty = 175 + myRemainder * .015
			} else {
				myDuty = thisValue * .0125
			}
			return myDuty
		}
		
		public static function mortgageDuty(thisLoanAmount:Number):Number {
			var myDuty:Number = 5
			var myRemainder:Number = 0
			if (thisLoanAmount > 16000) {
				myRemainder = thisLoanAmount - 16000
				myDuty += (myRemainder * .004)
			}
			return myDuty
		}
		public static function prettyNumber(thisNumber:Number):String {
			var myNegative:Boolean = thisNumber<0
			if (myNegative) {
				thisNumber*=-1
			}
			var string:String = Math.round(thisNumber).toString();
			var count:int = (string.length - 1) % 3;
			var formatted:String = "";
			for (var i:int = 0; i < string.length; i++) 
			{
				formatted += string.substr(i, 1);
				if ((i - count) % 3 == 0 && (i+1) != string.length) {
					formatted += ",";
				}			
			}
			if (myNegative) {
				formatted = "-"+formatted
			}
			return formatted;
		}
	}

}