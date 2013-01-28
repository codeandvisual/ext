package com.codeandvisual.ext {
	public class Time {
		//
		public static const SECOND:Number = 1000 * 60
		public static const MINUTE:Number = SECOND * 60
		public static const HOUR:Number = MINUTE * 60
		public static const DAY:Number = HOUR * 24
		public static const WEEK:Number = DAY * 7
		public static const MONTH:Number = DAY*30.416667 // Totally unreliable!
		public static const YEAR:Number = DAY * 365
		public static const QUARTER:Number = DAY * 4
		public static const WEEKS_IN_YEAR:Number = YEAR / WEEK
		
		
		//
		//
		//***************************************************************************
		//
		//
		// DATES 
		//
		//
		//***************************************************************************
		public static function addWeeks(date:Date, weeks:Number):Date {
			return addDays(date, weeks*7);
		}
		public static function addDays(date:Date, days:Number):Date {
			return addHours(date, days*24);
		}
		public static function addHours(date:Date, hrs:Number):Date {
			return addMinutes(date, hrs*60);
		}
		public static function addMinutes(date:Date, mins:Number):Date {
			return addSeconds(date, mins*60);
		}
		public static function addSeconds(date:Date, secs:Number):Date {
			var mSecs:Number=secs*1000;
			var sum:Number=mSecs+date.getTime();
			return new Date(sum);
		}
		//
		//
		//***************************************************************************
		//
		//
		// TIME 
		//
		//
		//***************************************************************************
		public static function timeToString(thisMilliSeconds:Number, thisResolution:String = "hours",thisDelimiter:String = ":",thisShowDeci:Boolean = false):String {
			// only truly working for a resolution of hours right now. Shouldn't be hard to get it working for other resolutions
			var myString:String
			var myMilliSeconds:Number = Math.round(thisMilliSeconds)
			var mySeconds:Number
			var myMinutes:Number
			var myHours:Number
			var myMinutesFloor:Number
			var mySecondsRemainder:Number
			var myMinutesRemainder:Number
			var myDeciRemainder:Number
			var mySecondString:String
			var myMinuteString:String
			var myHoursDivider:Number = 60 * 60 * 1000
			var myMinutesDivider:Number = 60 * 1000
			var mySecondsDivider:Number = 1000
			var myDeciDivider:Number = 10
			var myDeci:Number
			switch(thisResolution) {
				case "hours":
					myHours = int(myMilliSeconds / myHoursDivider)
					myMinutesRemainder = myMilliSeconds % myHoursDivider
					myMinutes = int(myMinutesRemainder / myMinutesDivider)
					mySecondsRemainder = myMinutesRemainder % myMinutesDivider
					mySeconds = int(mySecondsRemainder/mySecondsDivider)
					//myMinutesFloor = Math.floor(myMinutes)
					myDeciRemainder = mySecondsRemainder % mySecondsDivider
					myDeci = int(myDeciRemainder/myDeciDivider)
					
					
					//
					myString = numberString(myHours) + thisDelimiter + numberString(myMinutes) + thisDelimiter + numberString(mySeconds)
					if (thisShowDeci) {
						myString+=thisDelimiter+numberString(myDeci)
					}
					break
				case "minutes":
					myMinutes = int(myMilliSeconds / myMinutesDivider)
					mySecondsRemainder = myMilliSeconds % myMinutesDivider
					mySeconds = int(mySecondsRemainder/mySecondsDivider)
					myMinutesFloor = Math.floor(myMinutes)
					mySecondsRemainder = myMilliSeconds % 60*1000
					//
					myString = numberString(myMinutes)+thisDelimiter+numberString(mySeconds)
					break
			}
			return myString
		}
		public static function numberString(thisNumber:Number, thisDigits:int = 2):String {
			var myString:String = String(thisNumber)
			while (myString.length < thisDigits) {
				myString = "0"+myString
			}
			return myString
		}
}
}