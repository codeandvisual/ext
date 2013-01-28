// **********************************
//
// Tools Package 
// © 2008 - James McNess
// http://www.codeandvisual.com
//
// **********************************

package com.codeandvisual.ext{
	import com.codeandvisual.Tools.Color;
	import com.codeandvisual.Tools.ColorMatrix;
	import flash.display.*
	import flash.filters.ColorMatrixFilter;
	import flash.geom.*


	public class Colours {
		public var pGradient:Object;
		public var pGradientMap:Array;
		//
		//
		//---------------------------------------------
		// Create Colour References (Maybe I could add thes to Tools)
		// With one argument that allows you to feed the alpha
		//---------------------------------------------
		public var myAlpha:Number =255//220;
		public var myLighten:Number = 0//100
		public var g220Orange:Object;
		public var g190Orange:Object;
		public var g160Orange:Object;
		public var g130Orange:Object;
		public var g120Orange:Object;
		public var g105:Object;
		public var g112:Object;
		public var g100:Object;
		public var g100A:Object;
		public var g160:Object;
		public var g160A:Object;
		public var g190:Object;
		public var g190A:Object;
		public var g220:Object;
		public var g220A:Object;
		public var Black:Object;
		public var White:Object;
		public var RedA:Object;
		public var Red:Object;
		public var Yellow:Object;
		public var Green:Object;
		public var GreenA:Object;
		public var Aqua:Object;
		public var Blue:Object;
		public var BlueA:Object;
		public var Magenta:Object;
		public var MagentaA:Object;
		public var Blank:Object
		//
		public function Colours():void {
			//createColours(myAlpha, myLighten);
		}
		//
		public static function adjustData(thisData:BitmapData, thisBrightness:Number, thisContrast:Number = 0, thisSaturation:Number = 0, thisHue:Number = 0):void {
			var myCm:ColorMatrix = new ColorMatrix();
			myCm.adjustColor( thisBrightness,  thisContrast, thisSaturation, thisHue);
			var myFilter:ColorMatrixFilter = new ColorMatrixFilter(myCm)
			var myPoint:Point = new Point(0,0)
			thisData.applyFilter(thisData, thisData.rect, myPoint , myFilter )
		}
		//
		public function createColours(thisAlpha:Number, thisLighten:Number):void {
			g220Orange = {pRed:220,pGreen:210,pBlue:210,pAlpha:thisAlpha};
			g190Orange = {pRed:190,pGreen:190,pBlue:190,pAlpha:thisAlpha};
			g160Orange = {pRed:160,pGreen:150,pBlue:150,pAlpha:thisAlpha};
			g120Orange = {pRed:120,pGreen:90,pBlue:90,pAlpha:thisAlpha};
			g130Orange = {pRed:130,pGreen:95,pBlue:95,pAlpha:thisAlpha};
			g105 = {pRed:105,pGreen:75,pBlue:75,pAlpha:thisAlpha};
			g112= {pRed:110,pGreen:80,pBlue:65,pAlpha:thisAlpha};
			g100 = {pRed:100,pGreen:100,pBlue:100,pAlpha:thisAlpha};
			g100A = {pRed:100,pGreen:100,pBlue:100,pAlpha:1};
			g160 = {pRed:160,pGreen:160,pBlue:160,pAlpha:thisAlpha};
			g160A = {pRed:160,pGreen:160,pBlue:160,pAlpha:1};
			g190 = {pRed:190,pGreen:190,pBlue:190,pAlpha:thisAlpha};
			g190A = {pRed:190,pGreen:190,pBlue:190,pAlpha:1};
			g220 = {pRed:220,pGreen:220,pBlue:220,pAlpha:thisAlpha};
			g220A = {pRed:220,pGreen:220,pBlue:220,pAlpha:1};
			Black = {pRed:0,pGreen:0,pBlue:0,pAlpha:thisAlpha};
			White = {pRed:255,pGreen:255,pBlue:255,pAlpha:thisAlpha};
			RedA = {pRed:255,pGreen:thisLighten,pBlue:thisLighten,pAlpha:1};
			Red = {pRed:255,pGreen:thisLighten,pBlue:thisLighten,pAlpha:thisAlpha};
			Yellow = {pRed:255,pGreen:255,pBlue:thisLighten,pAlpha:thisAlpha};
			Green = {pRed:thisLighten,pGreen:255,pBlue:thisLighten,pAlpha:thisAlpha};
			GreenA = {pRed:thisLighten,pGreen:255,pBlue:thisLighten,pAlpha:1};
			Aqua =  {pRed:thisLighten,pGreen:255,pBlue:255,pAlpha:thisAlpha};
			Blue= {pRed:thisLighten,pGreen:thisLighten,pBlue:255,pAlpha:thisAlpha};
			BlueA= {pRed:thisLighten,pGreen:thisLighten,pBlue:255,pAlpha:1};
			Magenta = {pRed:255,pGreen:thisLighten,pBlue:255,pAlpha:thisAlpha};
			MagentaA = {pRed:255,pGreen:thisLighten,pBlue:255,pAlpha:1};
			Blank = {pRed:0,pGreen:0,pBlue:0,pAlpha:1};
			
		}
		//
		public function getColourFromName(thisName:String):* {
			if (this.hasOwnProperty(thisName)) {
				var myHex:Number = argbToHex(this[thisName]);
				return convert8DigitHexToString(myHex)
			} else {
				return false;
			}
		}
		public  static function convertHexColoursToMap(thisColourArray:Array):Array {
			for (var i:String in thisColourArray) {
				thisColourArray[i] = hexToArgb(thisColourArray[i]);
			}
			var myGradientObject:Object = createEvenGradient(thisColourArray);
			var myMap:Array =  createMap(myGradientObject);
			return myMap;
		}
		public  function convertColoursToMap(thisColourArray:Array):Array {
			var myGradientObject:Object = createEvenGradient(thisColourArray);
			var myMap:Array =  createMap(myGradientObject);
			return myMap;
		}
		public static function convert8DigitHexToString(thisHex:Number):String {
			var myString:String;
			var myTempString:String;
			var myAlpha:Number = seperateHexChannel(thisHex,"alpha");
			myTempString = convert2DigitHexToString(myAlpha);
			myString=myTempString;
			var myRed:Number = seperateHexChannel(thisHex,"red");
			myTempString = convert2DigitHexToString(myRed);
			myString+=myTempString;
			var myGreen:Number = seperateHexChannel(thisHex,"green");
			myTempString = convert2DigitHexToString(myGreen);
			myString+=myTempString;
			var myBlue:Number = seperateHexChannel(thisHex,"blue");
			myTempString = convert2DigitHexToString(myBlue);
			myString+=myTempString;
			return myString;
		}
		public static function convert2DigitHexToString(thisHex:Number):String {
			var myString:String = thisHex.toString(16);
			myString = myString.length<2?"0"+myString:myString;
			return myString;
		}
		//
		public static  function createMap(thisGradient:Object):Array {
			//
			//---------------------------------------------------------------
			// Create an ordered array of the colour sample points
			// this is used because an object (as the gradient is supplied)
			// cannot be interated in any reliable order
			//---------------------------------------------------------------
			var mySamplePoints:Array = new Array();
			for (var j:String in thisGradient) {
				mySamplePoints.push(Number(j));
			}
			mySamplePoints.sort(16);
			//
			//---------------------------------------------------------------
			// Create a single array of 256 hexidecimal colours from the provided samples points in thisGradient
			// myGradient is a temporary storage location for colour values before converting to hex (not really needed)
			//---------------------------------------------------------------
			var myGradient:Object = {a:new Array(256), r:new Array(256), g:new Array(256), b:new Array(256)};
			var myGradientMap:Array = new Array(256);
			for (var k:int = 0; k<(mySamplePoints.length-1); k++) {
				var myPercent:int = mySamplePoints[k];
				var myNextPercent:int = mySamplePoints[k+1];
				//
				var myHexPoint:int = Math.round(myPercent/100*256);
				var myNextHexPoint:int = Math.round(myNextPercent/100*256);
				var mySteps:int = myNextHexPoint - myHexPoint;
				//
				var myLastColour:Object = thisGradient[myPercent];
				var myNextColour:Object = thisGradient[myNextPercent];
				//
				var myRedStart:int = myLastColour.pRed;
				var myGreenStart:int = myLastColour.pGreen;
				var myBlueStart:int =myLastColour.pBlue;
				var myAlphaStart:int = isNaN(myLastColour.pAlpha)?255:myLastColour.pAlpha;
				//
				var myRedEnd:int =myNextColour.pRed;
				var myGreenEnd:int =myNextColour.pGreen;
				var myBlueEnd:int = myNextColour.pBlue;
				var myAlphaEnd:int = isNaN(myNextColour.pAlpha)?255:myNextColour.pAlpha;
				//
				var myRedStep:Number = (myRedEnd-myRedStart)/mySteps;
				var myGreenStep:Number = (myGreenEnd-myGreenStart)/mySteps;
				var myBlueStep:Number = (myBlueEnd-myBlueStart)/mySteps;
				var myAlphaStep:Number = (myAlphaEnd-myAlphaStart)/mySteps;
				//
				var myCurrentStep:int = 0;
				for (var l:Number = myHexPoint; l<myNextHexPoint; l++) {
					myGradient["r"][l]=Math.round(myRedStart+(myRedStep*myCurrentStep));
					myGradient["g"][l]=Math.round(myGreenStart+(myGreenStep*myCurrentStep));
					myGradient["b"][l]=Math.round(myBlueStart+(myBlueStep*myCurrentStep));
					myGradient["a"][l]=Math.round(myAlphaStart+(myAlphaStep*myCurrentStep));
					myGradientMap[l] = argbToHex({pRed:myGradient["r"][l],pGreen:myGradient["g"][l],pBlue:myGradient["b"][l],pAlpha:myGradient["a"][l]});
					myCurrentStep++;
				}

			}
			return myGradientMap;
		}
		//
		//
		//---------------------------------------------
		// Create Palette Spectrum gradient
		//---------------------------------------------
		public static function createEvenGradient(thisColourArray:Array):Object {
			var myObject:Object = new Object();
			var myLength:int = thisColourArray.length;
			var myDivision:Number = 100/(myLength-1);
			for (var i:int = 0; i<myLength; i++) {
				var myPercent:Number = i*myDivision;
				myPercent= Math.round(myPercent);
				myObject[myPercent] = thisColourArray[i];
			}
			return myObject;
		}
		public static function createGradientFillObject(thisGradientArray:Array, thisWidth:int, thisHeight:int, thisX:int, thisY:int):Object {
			var myGradientFillObject:Object = new Object();
			myGradientFillObject.pFillType = GradientType.LINEAR;
			myGradientFillObject.pColours = new Array();
			myGradientFillObject.pAlphas = new Array();
			myGradientFillObject.pRatios = new Array();
			myGradientFillObject.pMatrix = new Matrix();
			myGradientFillObject.pMatrix.createGradientBox(thisWidth, thisHeight, 0, thisX, thisY);
			myGradientFillObject.pSpreadMethod = SpreadMethod.PAD;
			var myUnitsPerColour:Number = 255/(thisGradientArray.length-1);
			for (var i:int = 0; i<thisGradientArray.length; i++) {
				//
				// (!) have to add a search for named colours
				var myColour:Number = thisGradientArray[i];
				var myRatioPoint:Number = Math.round(i*myUnitsPerColour);
				var myRatioPointHex:Number = Number("0x"+myRatioPoint.toString(16));
				var mySeperatedElements:Object =  seperateAlphaAndColourFromHex(myColour);
				var myAlpha:Number = mySeperatedElements.pAlpha.toString(10);
				var myPercent:Number = Number(myAlpha)/255;
				myGradientFillObject.pAlphas.push(myPercent);
				myGradientFillObject.pColours.push(mySeperatedElements.pColour);
				myGradientFillObject.pRatios.push(myRatioPointHex);
			}
			return myGradientFillObject;
		}
		//
		public function getColourAtPercent(thisPercent:int,  thisTrace:Boolean=false):Object {
			var myGradientPoint:Number = Math.round(thisPercent/100*256);
			var myHexValue:Number = pGradientMap[myGradientPoint];
			var myColor:Object = hexToArgb(myHexValue);
			if (thisTrace) {
				trace("**********************************");
				trace("INFO ABOUT GRADIENT MAP");
				trace("**********************************");
				trace("Percent Point = "+thisPercent);
				trace("Gradient Point = "+myGradientPoint);
				trace("HEX: "+myHexValue);
				trace("ALPHA: "+myColor.pAlpha);
				trace("RED: "+myColor.pRed);
				trace("GREEN: "+myColor.pGreen);
				trace("BLUE: "+myColor.pBlue);
				trace("");
			}
			return myColor;
		}
		public function getMappedColourAtGreyValue(thisGreyValue:int,  thisTrace:Boolean=false):Object {
			var myPercent:Number = thisGreyValue/256*100;
			var myHexValue:Number = pGradientMap[thisGreyValue];
			var myColor:Object =hexToArgb(myHexValue);
			if (thisTrace) {
				trace("**********************************");
				trace("INFO ABOUT GRADIENT MAP");
				trace("**********************************");
				trace("Grey Value = "+thisGreyValue);
				trace("Percentage Point = "+myPercent);
				trace("Gradient Point = "+thisGreyValue);
				trace("HEX: "+myHexValue);
				trace("ALPHA: "+myColor.pAlpha);
				trace("RED: "+myColor.pRed);
				trace("GREEN: "+myColor.pGreen);
				trace("BLUE: "+myColor.pBlue);
				trace("");
			}
			return myColor;
		}
		public static function blend(thisStart:Number, thisTint:Number, thisAmount:Number = 1):Number {
			var myGradientRGB:Array = convertHexColoursToMap([thisStart, thisTint] )
			var myIndex:int = (myGradientRGB.length-1) * Math.min(1, thisAmount)
			return myGradientRGB[myIndex]
		}
		//
		//
		//***************************************************************************
		//
		//
		// COLOUR CONVERSION
		//
		//
		//***************************************************************************
		public static function hexToRgb(thisHex:Number):Object {
			var myRed:int=seperateHexChannel(thisHex,"red");
			var myGreen:int=seperateHexChannel(thisHex,"green");
			var myBlue:int=seperateHexChannel(thisHex,"blue");
			var myObject:Object=new Object;
			myObject.pRed=myRed;
			myObject.pGreen=myGreen;
			myObject.pBlue=myBlue;
			return myObject;
		}
		public static function hexToArgb(thisHex:Number):Object {
			var myAlpha:int=seperateHexChannel(thisHex,"alpha");
			var myRed:int=seperateHexChannel(thisHex,"red");
			var myGreen:int=seperateHexChannel(thisHex,"green");
			var myBlue:int=seperateHexChannel(thisHex,"blue");
			var myObject:Object=new Object;
			myObject.pAlpha=myAlpha;
			myObject.pRed=myRed;
			myObject.pGreen=myGreen;
			myObject.pBlue=myBlue;
			return myObject;
		}
		public static function seperateHexChannel(thisColour:Number,thisChannel:String):int {
			var myChannel:int;
			var myComparer:Number;
			switch (thisChannel) {
				case "alpha" :
					myComparer=0xff000000;
					myChannel=thisColour & myComparer;
					myChannel>>>= 24;
					break;
				case "red" :
					myComparer=0x00ff0000;
					myChannel=thisColour & myComparer;
					myChannel>>>= 16;
					break;
				case "green" :
					myComparer=0x0000ff00;
					myChannel=thisColour & myComparer;
					myChannel>>>= 8;
					break;
				case "blue" :
					myComparer=0x000000ff;
					myChannel=thisColour & myComparer;
					break;
			}
			return myChannel;
		}
		public static function rgbToHex(thisRgbObject:Object):Number {
			var myRedHex:Number=Number("0x" + thisRgbObject.pRed.toString(16));
			myRedHex<<= 16;
			var myGreenHex:Number=Number("0x" + thisRgbObject.pGreen.toString(16));
			myGreenHex<<= 8;
			var myBlueHex:Number=Number("0x" + thisRgbObject.pBlue.toString(16));
			var myStartHex:Number=0x000000;
			myStartHex|= myRedHex;
			myStartHex|= myGreenHex;
			myStartHex|= myBlueHex;
			return myStartHex;
		}
		public static function argbToHex(thisArgbObject:Object):Number {
			var myRed:Number = thisArgbObject.pRed;
			var myGreen:Number = thisArgbObject.pGreen;
			var myBlue:Number = thisArgbObject.pBlue;
			var myAlpha:Number = isNaN(thisArgbObject.pAlpha)?255:thisArgbObject.pAlpha;
			//
			var myAlphaHex:Number=Number("0x" + myAlpha.toString(16));
			myAlphaHex<<= 24;
			var myRedHex:Number=Number("0x" + myRed.toString(16));
			myRedHex<<= 16;
			var myGreenHex:Number=Number("0x" + myGreen.toString(16));
			myGreenHex <<=8;
			var myBlueHex:Number=Number("0x" + myBlue.toString(16));
			//
			var myStartHex:Number=0x00000000;
			myStartHex |= myAlphaHex;
			myStartHex|= myRedHex;
			myStartHex|= myGreenHex;
			myStartHex|= myBlueHex;


			return myStartHex;
		}
		public static function getAlphaFromHex(thisHex:Number):Number {
			var myAlpha:Number = seperateHexChannel(thisHex,"alpha");
			return myAlpha;
		}
		public static function stripAlphaFromHex(thisHex:Number):Number {
			var myColours:Object = hexToRgb(thisHex);
			var myNewHex:Number = rgbToHex(myColours);
			return myNewHex;
		}
		public static function seperateAlphaAndColourFromHex(thisHex:Number):Object {
			var myObject:Object = {pAlpha:0x00,pColour:0x00};
			myObject.alpha = getAlphaFromHex(thisHex);
			myObject.colour = stripAlphaFromHex(thisHex);
			return myObject;
		}
		public static function tintTransform(thisColour:Number, thisAmount:Number):ColorTransform{
			var myTint:Color = new Color();
			myTint.setTint(thisColour, thisAmount);
			var myTransform:ColorTransform = new ColorTransform()
			myTransform.concat(myTint)
			return myTransform
		}
		public static function tintClip(thisClip:DisplayObject,thisColour:Number=NaN, thisAmount:Number =1):void{
			if(thisClip!=null){
				var myTransform:ColorTransform = isNaN(thisColour)?tintTransform(0x000000,0):tintTransform(thisColour, thisAmount)
				thisClip.transform.colorTransform = myTransform
			}
		}
		public static function tintData(thisData:BitmapData, thisColour:Number, thisAmount:Number = 1):BitmapData {
				var myTransform:ColorTransform = tintTransform(thisColour,thisAmount)
				thisData.colorTransform(thisData.rect, myTransform)
				return thisData
		}

	}
}