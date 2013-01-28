package com.codeandvisual.ext {
	import com.codeandvisual.game2d.sprites.scripts.SpriteScript;
	import com.codeandvisual.Tools.Trig;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.CapsStyle;
	import flash.display.DisplayObjectContainer;
	import flash.display.Graphics;
	import flash.display.InteractiveObject;
	import flash.display.JointStyle;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.StageQuality;
	import flash.events.Event;
	import flash.geom.ColorTransform;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	public class Create {
		public static function circle(thisColour:Number = 0xffffff, thisRadius:Number = 50, thisAlpha:Number = 1, thisStrokeColour:Number = -1, thisType:String = "Sprite", thisCentred:Boolean = false):*{
			var myShape:* = thisType=="Sprite"?new Sprite():new MovieClip()
			if (thisStrokeColour != -1) {
				myShape.graphics.lineStyle(1,thisStrokeColour,1,false,"normal",null,JointStyle.ROUND)
			}
			myShape.graphics.beginFill(thisColour,thisAlpha);
			myShape.graphics.drawCircle(thisCentred?0:thisRadius, thisCentred?0:thisRadius,thisRadius);
			myShape.graphics.endFill();
			return myShape
		}
		public static function circleCentred(thisColour:Number = 0xffffff, thisRadius:Number = 50, thisAlpha:Number = 1, thisStrokeColour:Number = -1, thisType:String = "Sprite"):* {
			return circle(thisColour , thisRadius, thisAlpha, thisStrokeColour, thisType, true)
		}
		public static function square_mc(thisColour:Number = 0xffffff, thisWidth:Number = 100, thisHeight:Number = 100, thisAlpha:Number=1, thisStrokeColour:Number = -1,thisStrokeThickness:Number = 1, thisStrokeAlpha:Number = 1):MovieClip {
			var mySquare:MovieClip  = square(thisColour, thisWidth, thisHeight, thisAlpha, thisStrokeColour,thisStrokeThickness,thisStrokeAlpha, "MovieClip") as MovieClip
			return mySquare
		}
		public static function square(thisColour:Number = 0xffffff, thisWidth:Number = 100, thisHeight:Number = 100, thisAlpha:Number = 1, thisStrokeColour:Number = -1, thisStrokeThickness:Number = 1, thisStrokeAlpha:Number = 1 , thisType:String = "Sprite"):* {
			var mySquare:* = thisType=="Sprite"?new Sprite():new MovieClip()
			if (thisStrokeColour != -1) {
				mySquare.graphics.lineStyle(thisStrokeThickness,thisStrokeColour,thisStrokeAlpha,true,"normal",null,JointStyle.MITER)
			}
			mySquare.graphics.beginFill(thisColour,thisAlpha);
			mySquare.graphics.drawRect(0,0,thisWidth,thisHeight);
			mySquare.graphics.endFill();
			return mySquare
		}
		public static function triangle(thisColour:Number = 0xffffff, thisWidth:Number = 100, thisHeight:Number = 100, thisAlpha:Number = 1, thisStrokeColour:Number = -1, thisStrokeThickness:Number = 1, thisStrokeAlpha:Number = 1 ,thisType:String = "Sprite"):* {
			var myTriangle:* = thisType == "Sprite"?new Sprite():new MovieClip()
			var g:Graphics = myTriangle.graphics
			if (thisStrokeColour != -1) {
				myTriangle.graphics.lineStyle(thisStrokeThickness,thisStrokeColour,thisStrokeAlpha,true,"normal",null,JointStyle.MITER)
			}
			g.beginFill(thisColour,thisAlpha);
			g.moveTo( -thisWidth / 2, 0)
			g.lineTo(0, -thisHeight)
			g.lineTo(thisWidth / 2, 0)
			g.lineTo(-thisWidth/2,0)
			g.endFill();
			return myTriangle
		}
		
		public static function preloader(thisShowPercent:Boolean = true, thisShowRing:Boolean = true, thisRadius:Number = 18,thisMargin:Number=5,thisThickness:Number = 2.75,thisColour:Number = 0x888888,thisSpinSpeed:Number = 8,thisTitle:String = "LOADING", thisDegrees:Number = 360, thisCount:Number =80,thisColourText:Number = NaN ):MovieClip {
			
			var myLoader:MovieClip = new MovieClip()
			myLoader.name = "mc_preloader"
			myLoader.id = Numbers.getDynamicId()
			//
			var myRing:Sprite = new Sprite()
			myRing.name = "mc_ring"
			var myThicknessMultiplier:Number = 5//5//0
			var myCount:int = thisCount
			var mySegmentSize:Number = thisDegrees / myCount
			var mySize:Number = (thisRadius + thisThickness) * 2
			
			for (var i:int = 0; i < myCount; i++) {
				var myX:Number = Trig.soh(i*-mySegmentSize, NaN, thisRadius)
				var myY:Number = Trig.cah(i * -mySegmentSize, NaN, thisRadius)
			//	if (i == 0) {
					var myCircle:Sprite = Create.circle(thisColour, thisThickness * myThicknessMultiplier, 1, -1, "Sprite", true)
				
					Clip.scale(myCircle, 1 / myThicknessMultiplier)
					myCircle.alpha = i / myCount
					
					myCircle.x = myX
					myCircle.y = myY
					myRing.addChild(myCircle)
					
			/*	}else{
				//
					myRing.graphics.lineStyle(5,thisColour,i/myCount,false,"normal",CapsStyle.NONE,JointStyle.MITER)
					myRing.graphics.moveTo(myX, myY)
					var myNewPoint:Point = Trig.extendAlongAngle(i* mySegmentSize, myX, myY, 2)
					myRing.graphics.lineTo(myNewPoint.x, myNewPoint.y)
				}*/
			}
			var myTextColour:Number = isNaN(thisColourText)?thisColour:thisColourText
			//
			myRing.y = -(thisRadius+thisMargin)
			myLoader.addChild(myRing)
			myLoader.ring = myRing
			var mySpeed:Number = thisSpinSpeed
			//
			myLoader.draw = function (e:Event):void { 
				myRing.rotation += mySpeed
				//trace("LOADER DRAW "+myLoader.id)
			};
			Listen.addCycle(myLoader, myLoader.draw)
			//
			var myFormat:TextFormat = new TextFormat()
			myFormat.font = "Arial"
			myFormat.size = 12
			myFormat.align = "center"
			myFormat.color  = myTextColour
			//
			var myTitle:TextField = new TextField()
			myTitle.width = 100
			myTitle.defaultTextFormat  = myFormat
			myTitle.autoSize = "center"
			myTitle.text = thisTitle
			myTitle.x = -myTitle.width / 2
			myTitle.name = "txt_text"
			myTitle.height = myTitle.textHeight * 1.1
			myLoader.myText = myTitle
			
			//
			var myPercent:TextField = new TextField()
			myPercent.width = 200
			myFormat.size = 9
			myPercent.defaultTextFormat = myFormat
			myPercent.text = "0%"
			myPercent.x = -myPercent.width / 2
			myPercent.y = -(thisMargin+thisRadius+(thisThickness/2)+(myPercent.textHeight/2))
			myPercent.name = "txt_percent"
			myPercent.height = myPercent.textHeight * 2//1.1
			myPercent.visible  = thisShowPercent
			myLoader.myPercent = myPercent
			
			//
			myLoader.addChild(myTitle)
			myLoader.addChild(myPercent)
			//
			myLoader.update = function(thisPercent:Number):void { var myField:TextField  = TextField(this.getChildByName("txt_percent")); myField.text = thisPercent + "%"; };
			//
			return myLoader
		}
		public static function circleSegmentMask(thisTarget:Sprite,thisRadius:Number, thisRatio:Number=1, thisColour:Number = 0x000000, thisClear:Boolean = true):void {
			var myGraphics:Graphics = thisTarget.graphics;
			if(thisClear){
				myGraphics.clear();
			}
			var myAngle:Number = 360*thisRatio
			var myArcX:Number = Trig.cah(myAngle-90, NaN, thisRadius);
			var myArcY:Number = Trig.soh(myAngle-90, NaN, thisRadius);
			if(thisClear){
				myGraphics.clear();
			}
			myGraphics.beginFill(thisColour);
			myGraphics.moveTo(0,-thisRadius);
			myGraphics.lineTo(0,0);
			myGraphics.lineTo(myArcX,myArcY);
			if (myAngle>270) {
				myGraphics.lineTo(-thisRadius,-thisRadius);
				myGraphics.lineTo(-thisRadius,0);
			}
			if (myAngle>180) {
				myGraphics.lineTo(-thisRadius,thisRadius);
				myGraphics.lineTo(0,thisRadius);
			}
			if (myAngle>90) {
				myGraphics.lineTo(thisRadius,thisRadius);
				myGraphics.lineTo(thisRadius,0);
			}
			myGraphics.lineTo(thisRadius,-thisRadius);
			myGraphics.lineTo(0,-thisRadius);
			myGraphics.endFill();
		}
		public static function drawCircularWipe(thisSprite:Sprite, thisPercent:Number,thisColour:Number = 0x000000, thisRadius:Number = 300,thisX:Number = 0, thisY:Number = 0,thisAlpha:Number = 1):void {
			var myGraphics:Graphics = thisSprite.graphics;
			var myAngle:Number = 360*thisPercent
			var myArcX:Number = Trig.cah(myAngle-90, NaN, thisRadius);
			var myArcY:Number = Trig.soh(myAngle-90, NaN, thisRadius);
			myGraphics.beginFill(thisColour,thisAlpha);
			myGraphics.moveTo(thisX,thisY-thisRadius);
			myGraphics.lineTo(thisX,thisY);
			myGraphics.lineTo(thisX+myArcX,thisY+myArcY);
			if (myAngle>270) {
				myGraphics.lineTo(thisX-thisRadius,thisY-thisRadius);
				myGraphics.lineTo(thisX-thisRadius,thisY);
			}
			if (myAngle>180) {
				myGraphics.lineTo(thisX-thisRadius,thisY+thisRadius);
				myGraphics.lineTo(thisX,thisY+thisRadius);
			}
			if (myAngle>90) {
				myGraphics.lineTo(thisX+thisRadius,thisY+thisRadius);
				myGraphics.lineTo(thisX+thisRadius,thisY);
			}
			myGraphics.lineTo(thisX+thisRadius,thisY-thisRadius);
			myGraphics.lineTo(thisX,thisY-thisRadius);
			myGraphics.endFill();
		}
		public static function input(thisText:String,thisWidth:Number=300, thisHeight:Number=300, thisSize:Number = 18,thisColour:Number=0x000000,thisFont:String = "Arial",thisEmbed:Boolean=false):TextField {
			var myField:TextField =  new TextField()
			myField.width = thisWidth
			myField.height =  thisHeight
			var myFormat:TextFormat = new TextFormat(thisFont, thisSize)
			myField.defaultTextFormat = myFormat
			myField.autoSize = "none"
			myField.wordWrap = false
			myField.type = "input"
			myField.textColor = thisColour
			myField.text = thisText
			myField.selectable = true
			myField.embedFonts = thisEmbed
			//myField.autoSize = "left"
			return myField
		}
		public static function field(thisText:String, thisSize:Number = 18,thisColour:Number=0x000000,thisAlign:String = TextFormatAlign.LEFT,thisWidth:Number=NaN, thisHeight:Number=NaN,thisFont:String = "Arial",thisEmbed:Boolean=false):TextField {
			var myField:TextField =  new TextField()
			if(!thisWidth!=thisWidth){
				myField.width = thisWidth
			}
			if(!thisHeight!=thisHeight){
				myField.height =  thisHeight
			}
			var myFormat:TextFormat = new TextFormat(thisFont, thisSize)
			myFormat.align = thisAlign
			myField.defaultTextFormat = myFormat
			if (thisWidth != thisWidth && thisHeight != thisHeight) {
				myField.autoSize = "left"
			}else {
				myField.autoSize = "none"
			}
			myField.wordWrap = true
			myField.type = "dynamic"
			myField.textColor = thisColour
			myField.text = thisText
			myField.selectable = false
			myField.embedFonts = thisEmbed
			myField.autoSize = "left"
			return myField
		}
		public static function text(thisText:String,thisSize:Number = 18,thisColour:Number=0x000000,thisFont:String = "Arial",thisEmbed:Boolean=false):TextField {
			var myField:TextField =  new TextField()
			myField.width = 5
			var myFormat:TextFormat = new TextFormat(thisFont, thisSize)
			myField.defaultTextFormat = myFormat
			myField.autoSize = "left"
			myField.wordWrap = false
			myField.type = "dynamic"
			myField.textColor = thisColour
			myField.text = thisText
			myField.selectable = false
			myField.embedFonts = thisEmbed
			return myField
		}
		public static function htmlText(thisText:String,thisSize:Number = 18,thisColour:Number=0x000000,thisFont:String = "Arial",thisEmbed:Boolean=false):TextField {
			var myField:TextField =  new TextField()
			var myFormat:TextFormat = new TextFormat(thisFont, thisSize)
			myField.defaultTextFormat = myFormat
			myField.autoSize = "left"
			myField.wordWrap = false
			myField.multiline = true
			myField.type = "dynamic"
			myField.textColor = thisColour
			myField.selectable = false
			myField.embedFonts = thisEmbed
			myField.htmlText = thisText
			return myField
		}
		public static function button(thisText:String, thisFontSize:Number = 18, thisColourText:Number = 0x000000, thisFont:String = "Arial", thisColourBG:Number = 0xcccccc, thisEmbed:Boolean = false, thisType:String = "Sprite", thisWidthMin:Number =0):DisplayObjectContainer{
			var myField:TextField = text(thisText, thisFontSize, thisColourText, thisFont, thisEmbed)
			myField.name = "txt_name"
			Clip.noMouse(myField)
			var myMargin:Number = 5
			var myClip:DisplayObjectContainer
			if(thisType=="Sprite"){
				myClip = new Sprite()
			}else if (thisType == "MovieClip") {
				myClip = new MovieClip()
			}else {
				trace("unknown type: "+thisType)
			}
			var myBase:Sprite = square(thisColourBG, Math.max(thisWidthMin,myField.width + (myMargin * 2)), myField.height + (myMargin * 2))
			myBase.name = "sp_bg"
			myClip.addChild(myBase)
			myField.x = (myBase.width-myField.width)/2
			myField.y = myMargin
			myClip.addChild(myField)
			myClip.name = "sp_"+thisText
			return myClip
		}
		public static function check(thisBackgroundColour:Number = 0xcccccc, thisUncheckedColour:Number = 0xbbbbbb, thisCheckedColour:Number = 0x25ee25, thisBGSize:Number = 20, thisCheckSize:Number = 14,thisBackgroundStroke:Number = 0x999999, thisCheckStroke:Number = NaN):MovieClip {
			var myClip:MovieClip = new MovieClip()
			var myStrokeWidth:Number = 1
			var myBackground:Sprite = square(thisBackgroundColour, thisBGSize, thisBGSize, 1,thisBackgroundStroke,myStrokeWidth)
			myBackground.name = "mc_background"
			var myCheckBG:Sprite = square(thisUncheckedColour, thisCheckSize, thisCheckSize)
			myCheckBG.name = "mc_check_background"
			var myCheck:Sprite = square(thisCheckedColour, thisCheckSize, thisCheckSize)
			myCheck.name = "mc_check"
			myCheck.alpha = 0
			//
			var myMargin:Number = (thisBGSize-thisCheckSize) / 2
			myCheckBG.x = myCheckBG.y = myCheck.x = myCheck.y = myMargin +(myStrokeWidth/2)//+1 //stroke width
			//
			myClip.addChild(myBackground)
			myClip.addChild(myCheckBG)
			myClip.addChild(myCheck)
			//
			return myClip
		}
		public static function buttonClip(thisText:String, thisFontSize:Number = 18, thisColourText:Number = 0x000000, thisFont:String = "Arial", thisColourBG:Number = 0xcccccc, thisEmbed:Boolean = false, thisWidthMin:Number =0):MovieClip {
			return button(thisText, thisFontSize , thisColourText, thisFont, thisColourBG, thisEmbed, "MovieClip",thisWidthMin) as MovieClip
		}
		public static function scrollbar(thisHandleColour:Number = NaN, thisTrackColour:Number = NaN, thisThickness:Number = NaN, thisArrowSize:Number =NaN):MovieClip {
			thisHandleColour = isNaN(thisHandleColour)?0xcccccc:thisHandleColour
			thisTrackColour = isNaN(thisTrackColour)?0x333333:thisTrackColour
			thisThickness = isNaN(thisThickness)?16:thisThickness
			thisArrowSize  = isNaN(thisArrowSize)?16:thisArrowSize
			var myClip:MovieClip = new MovieClip()
			var myTrack:MovieClip = square(thisTrackColour, thisThickness, 100, 1, -1, 0,0,"MovieClip") 
			myTrack.name = "myTrack"
			myClip.myTrack = myTrack
			myClip.addChild(myTrack)
			//
			var myDragBar:MovieClip = square(thisHandleColour, thisThickness, 25, 1, -1,0,0, "MovieClip") 
			myDragBar.name = "myDragBar"
			myClip.myDragBar = myDragBar
			myClip.addChild(myDragBar)
			//
			var myArrowUp:MovieClip = square(thisHandleColour, thisThickness, thisArrowSize, 1, -1, 0,0,"MovieClip") 
			myArrowUp.name = "myArrowUp"
			myClip.myArrowUp = myArrowUp
			myClip.addChild(myArrowUp)
			//
			var myArrowDown:MovieClip = square(thisHandleColour, thisThickness, thisArrowSize, 1, -1,0,0, "MovieClip") 
			myArrowDown.name = "myArrowDown"
			myClip.myArrowDown = myArrowDown
			myClip.addChild(myArrowDown)
			//
			return myClip
		}
	}
}