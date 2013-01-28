package com.codeandvisual.ext {
	import com.codeandvisual.ext.Colours;
	import com.codeandvisual.game.display.BitmapText;
	import com.codeandvisual.Tools.EventManager;
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.FrameLabel;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.PixelSnapping;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.display.StageQuality;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.geom.Rectangle;
	import flash.text.TextField;
	import flash.utils.getDefinitionByName;
	public class Clip {
			//
		//
		//***************************************************************************
		//
		//
		// MOVIE CLIPS
		//
		//
		//***************************************************************************
		public static function getChildren(thisClip:DisplayObjectContainer, thisType:Class=null,thisPrefix:String="",thisTrace:Boolean = false):Array {
			var myCount:int=thisClip.numChildren;
			var myArray:Array = new Array();
			for (var i :int =0; i<myCount; i++) {
				var myChild:DisplayObject=thisClip.getChildAt(i);
				//
				var myAdd:Boolean=true;
				if (thisType!=null&&!(myChild is thisType)) {
					myAdd=false;
				}
				var myName:String = myChild.name
				if (thisPrefix != "" && myName.split(thisPrefix)[1] == undefined) {
					myAdd=false;
				}
				if (myAdd) {
					myArray.push(myChild);
					if(thisTrace){
						trace(myChild.name + ": " + myChild)
					}
				}
			}
			return myArray;
		}
		public static function removeChildren(thisClip:DisplayObjectContainer, thisDestroy:Boolean = true):void {
			var myChildren:Array = getChildren(thisClip)
			for (var i:int = 0; i < myChildren.length; i++) {
				if(thisDestroy){
					Listen.destroy(myChildren[i])
				}else {
					remove(myChildren[i])
				}
			}
		}
		public static function getChildBounds(thisClip:DisplayObjectContainer, thisTrace:Boolean = true):Array {
			var myChildren:Array = getChildren(thisClip, null, "", false)
			var myArray:Array = []
			for (var i:int = 0; i < myChildren.length; i++) {
				var myChild:DisplayObject = myChildren[i]
				var myBounds:Rectangle = bounds(myChild)
				myArray.push(myBounds)
				if (thisTrace) {
					trace(myChild.name+" bounds = "+myBounds)
				}
			}
			return myArray
		}
		public static function getFrameByLabel(thisClip:MovieClip, thisLabel:String):int {
			var myLabels:Array = thisClip.currentLabels;
			var myFrame:int
			for (var i:int = 0; i < myLabels.length; i++) {
				var myLabel:FrameLabel = myLabels[i];
				if (myLabel.name == thisLabel) {
					myFrame = myLabel.frame
					break
				}
			}
			return myFrame
		}
		public static function depth(thisClip:DisplayObject):int {			
			var myDepth:int = -1
			if(thisClip.parent!=null){
				myDepth = thisClip.parent.getChildIndex(thisClip)
			}
			return myDepth
		}
		public static function setDepth(thisClip:DisplayObject,thisDepth:int):void {
			thisClip.parent.addChildAt(thisClip, thisDepth)
		}
		public static function addUnder(thisAddition:DisplayObject, thisExisiting:DisplayObject):void {
			var myDepth:int = depth(thisExisiting)
			thisExisiting.parent.addChildAt(thisAddition,myDepth)
		}
		public static function addOver(thisAddition:DisplayObject, thisExisiting:DisplayObject):void {
			trace("jimmy")
			addUnder(thisAddition,thisExisiting)
			addUnder(thisExisiting,thisAddition)
		}
		public static function bringToFront(thisClip:DisplayObject):int {
			var myChildren:int=thisClip.parent.numChildren;
			thisClip.parent.addChild(thisClip);
			return myChildren-1;
		}
		public static function noMouse(thisClip:InteractiveObject):void {
			if (thisClip is DisplayObjectContainer) {
				DisplayObjectContainer(thisClip).mouseChildren=false;
			}
			thisClip.mouseEnabled=false;
		}
		public static function bottom(thisClip:DisplayObject):Number {
			var myBounds:Rectangle = thisClip.getBounds(thisClip.parent)
			return myBounds.y+myBounds.height
		}
		public static function top(thisClip:DisplayObject):Number {
			var myBounds:Rectangle = thisClip.getBounds(thisClip.parent)
			return myBounds.y
		}
		public static function right(thisClip:DisplayObject):Number {
			var myBounds:Rectangle = thisClip.getBounds(thisClip.parent)
			return myBounds.x+myBounds.width
		}
		public static function left(thisClip:DisplayObject):Number {
			var myBounds:Rectangle = thisClip.getBounds(thisClip.parent)
			return myBounds.x
		}

	
		public static function getClass(thisClassName:String, thisSwf:MovieClip = null):Class {
			var myClass:Class
			if (thisSwf != null) {
				myClass	= thisSwf.loaderInfo.applicationDomain.getDefinition(thisClassName) as Class
			}else {
				myClass	=getDefinitionByName(thisClassName) as Class
			}
			return myClass
		}
		public static function makeInsance(thisClassName:String,thisSwf:MovieClip=null):*{
			var myClass:Class = getClass(thisClassName,thisSwf)
			return new myClass()
		}
		
		public static function cacheCopyAlpha(thisClip:DisplayObject, thisReplace:Boolean = true, thisBorderBuffer:Number = 20,thisSmoothing:Boolean = false, thisSnapping:String = "",thisAdjust:String =""):MovieClip {
			return cacheCopy(thisClip, thisReplace, thisBorderBuffer,thisSmoothing, thisSnapping,thisAdjust,true)
		}
		public static function cacheCopy(thisClip:DisplayObject, thisReplace:Boolean = true, thisBorderBuffer:Number = 20,thisSmoothing:Boolean = false, thisSnapping:String = "",thisAdjust:String ="",thisPreApplyAlpha:Boolean =  false):MovieClip {
			//
			// creates a cached clip that is prescaled, so the output displays at the same size, but with a scale of 1
			// the rotation however is not pre applied, so the existing clips rotation has to/can be applied to it
			// borderBuffer stops the antialias edges or live filter edges from being cropped due to not being calculated in getBounds
			//
			var myQuality:String = thisClip.stage?thisClip.stage.quality:""
			if (thisClip.stage) {
				thisClip.stage.quality = StageQuality.BEST
			}
			
			thisSnapping = thisSnapping==""?PixelSnapping.AUTO:thisSnapping
			var myBounds:Rectangle = thisClip.getBounds(thisClip)
			var myWidth:int = Math.abs(int(myBounds.width * thisClip.scaleX) + thisBorderBuffer)
			var myHeight:int =  Math.abs(int((myBounds.height*thisClip.scaleY)+thisBorderBuffer))
			var myData:BitmapData = new BitmapData(myWidth,myHeight, true, 0)
			var myClipMatrix:Matrix = thisClip.transform.matrix || new Matrix()
		
			//
			var myMatrix:Matrix = new Matrix(myClipMatrix.a, 0, 0, myClipMatrix.d, (-myBounds.x*thisClip.scaleX)+thisBorderBuffer/2, (-myBounds.y*thisClip.scaleY)+thisBorderBuffer/2)
			var myAlpha:Number = thisClip.alpha
			thisClip.alpha = 1
			if (thisPreApplyAlpha) {
				thisClip.alpha = myAlpha
				myAlpha = 1
			}
			myData.draw(thisClip, myMatrix, thisClip.transform.colorTransform,null,null,thisSmoothing)
			if (thisAdjust != "") {
				var myObject:Object = Objects.stringToObject(thisAdjust)
				Colours.adjustData(myData, myObject.b, myObject.c, myObject.s, myObject.h)
			}
			var myMap:Bitmap = new Bitmap(myData,thisSnapping,thisSmoothing)
			if ((myClipMatrix.a < 0 && myClipMatrix.d > 0)||(myClipMatrix.a > 0 && myClipMatrix.d < 0)) {	
				myMap.scaleY *= -1
				myMap.scaleX *= -1
				
			}

			myMap.x = ((myBounds.x*thisClip.scaleX*myMap.scaleX)-(thisBorderBuffer/2*myMap.scaleX))
			myMap.y = ((myBounds.y * thisClip.scaleY*myMap.scaleY)-(thisBorderBuffer/2*myMap.scaleY)) 
			
			myMap.smoothing = true
			var myClip:MovieClip = new MovieClip()
			myMap.name = "bitmap"
			myClip.addChild(myMap)
			thisClip.alpha = myAlpha
			//
			if (thisReplace) {
				myClip.x = thisClip.x
				myClip.y = thisClip.y
				myClip.rotation = thisClip.rotation
				myClip.name = thisClip.name

				myClip.alpha = myAlpha
				if (thisClip.parent!=null) {
					thisClip.parent.addChildAt(myClip, depth(thisClip))
					remove(thisClip)
				}
			}
			if (thisClip.stage) {
				thisClip.stage.quality = myQuality
			}
			return myClip
		}
		// NEWER VERSION OF CACHE COPY WITH SLGIHTLY DIFFERENT NAME. 
		public static function cachedCopy(thisClip:DisplayObject, thisReplace:Boolean = true, thisType:String = "flash.display.Sprite", thisBorderBuffer:Number = 20,thisSmoothing:Boolean = false, thisSnapping:String = "",thisAdjust:String =""):DisplayObject {
			//
			// creates a cached clip that is prescaled, so the output displays at the same size, but with a scale of 1
			// the rotation however is not pre applied, so the existing clips rotation has to/can be applied to it
			// borderBuffer stops the antialias edges or live filter edges from being cropped due to not being calculated in getBounds
			//
			var myType:Class = getDefinitionByName(thisType) as Class
			var myQuality:String = thisClip.stage?thisClip.stage.quality:""
			var myStage:Stage = thisClip.stage
			if (myStage) {
				myStage.quality = StageQuality.BEST
			}
			
			thisSnapping = thisSnapping==""?PixelSnapping.AUTO:thisSnapping
			var myBounds:Rectangle = thisClip.getBounds(thisClip)
			var myWidth:int = Math.abs(int(myBounds.width * thisClip.scaleX) + thisBorderBuffer)
			var myHeight:int =  Math.abs(int((myBounds.height*thisClip.scaleY)+thisBorderBuffer))
			var myData:BitmapData = new BitmapData(myWidth,myHeight, true, 0)
			var myClipMatrix:Matrix = thisClip.transform.matrix
			//
			var myMatrix:Matrix = new Matrix(myClipMatrix.a, 0, 0, myClipMatrix.d, (-myBounds.x*thisClip.scaleX)+thisBorderBuffer/2, (-myBounds.y*thisClip.scaleY)+thisBorderBuffer/2)
			var myAlpha:Number = thisClip.alpha
			thisClip.alpha=1
			myData.draw(thisClip, myMatrix, thisClip.transform.colorTransform,null,null,thisSmoothing)
			if (thisAdjust != "") {
				var myObject:Object = Objects.stringToObject(thisAdjust)
				Colours.adjustData(myData, myObject.b, myObject.c, myObject.s, myObject.h)
			}
			var myMap:Bitmap = new Bitmap(myData,thisSnapping,thisSmoothing)
			if ((myClipMatrix.a < 0 && myClipMatrix.d > 0)||(myClipMatrix.a > 0 && myClipMatrix.d < 0)) {	
				myMap.scaleY *= -1
				myMap.scaleX *= -1
				
			}

			myMap.x = ((myBounds.x*thisClip.scaleX*myMap.scaleX)-(thisBorderBuffer/2*myMap.scaleX))
			myMap.y = ((myBounds.y * thisClip.scaleY*myMap.scaleY)-(thisBorderBuffer/2*myMap.scaleY)) 
			
		//	myMap.smoothing = true
			var myClip:* = new myType()
			myMap.name = "bitmap"
			myClip.addChild(myMap)
			thisClip.alpha = myAlpha
			//
			if (thisReplace) {
				myClip.x = thisClip.x
				myClip.y = thisClip.y
				myClip.rotation = thisClip.rotation
				myClip.name = thisClip.name
				myClip.alpha = myAlpha
				if (thisClip.parent!=null) {
					thisClip.parent.addChildAt(myClip, depth(thisClip))
					var myParent:DisplayObjectContainer = thisClip.parent
					remove(thisClip)
					if (myParent && myParent is MovieClip) {
						myParent[thisClip.name] = null
					}
					thisClip = null
				}
			}
			
			if (myStage) {
				myStage.quality = myQuality
			}
			return myClip
		}
		public static  function rasterizeClipAndContent(thisClip:DisplayObject,thisDepth:int = 1, thisReplace:Boolean = true, thisTextFieldHandler:Function = null):Sprite{
			var mySprite:Sprite = new Sprite()
			var myParent:DisplayObjectContainer = thisClip.parent
			var myName:String = thisClip.name
			//
			if(thisClip is DisplayObjectContainer){
				var myChildren:Array = Clip.getChildren(DisplayObjectContainer(thisClip), null, "", false)
				if (thisDepth > 1) {
					for (var c:int = 0; c < myChildren.length; c++) {
						var myChildNest:DisplayObject = myChildren[c]
						mySprite.addChild(rasterizeClipAndContent(myChildNest,thisDepth-1, thisReplace, thisTextFieldHandler))
					}
				}else{
					for (var i:int = 0; i < myChildren.length; i++) {
						var myChild:DisplayObject = myChildren[i]
						if (myChild is MovieClip) {
							var myNew:Sprite = Clip.cachedCopy(myChild) as Sprite
							mySprite.addChild(myNew)
						}else if (myChild is TextField) {
							var myText:BitmapText  = thisTextFieldHandler!=null?thisTextFieldHandler(thisClip.name + "__" + myChild.name, myChild as TextField):new BitmapText(myChild as TextField)
							mySprite.addChild(myText.clip)
						}
					}
				}
			}else if (thisClip is TextField) {
				mySprite = (thisTextFieldHandler!=null?thisTextFieldHandler(thisClip.name + "__" + myChild.name, myChild as TextField):new BitmapText(myChild as TextField)).clip 
			}else{
				mySprite = Clip.cachedCopy(thisClip) as Sprite
			}
			//
			mySprite.name = myName
			mySprite.x = thisClip.x
			mySprite.y = thisClip.y
			//
			return mySprite
		}
		public static function cacheToBitmap(thisClip:DisplayObject, thisReplace:Boolean = true, thisBorderBuffer:Number = 20,thisSmoothing:Boolean = false, thisSnapping:String = "",thisAdjust:String =""):Bitmap {
			// EXPERIMENTAL
			// creates a cached clip that is prescaled, so the output displays at the same size, but with a scale of 1
			// the rotation however is not pre applied, so the existing clips rotation has to/can be applied to it
			// borderBuffer stops the antialias edges or live filter edges from being cropped due to not being calculated in getBounds
			//
			var myQuality:String = thisClip.stage?thisClip.stage.quality:""
			if (thisClip.stage) {
				thisClip.stage.quality = StageQuality.BEST
			}
			
			thisSnapping = thisSnapping==""?PixelSnapping.AUTO:thisSnapping
			var myBounds:Rectangle = thisClip.getBounds(thisClip)
			var myWidth:int = Math.abs(int(myBounds.width * thisClip.scaleX) + thisBorderBuffer)
			var myHeight:int =  Math.abs(int((myBounds.height*thisClip.scaleY)+thisBorderBuffer))
			var myData:BitmapData = new BitmapData(myWidth,myHeight, true, 0)
			var myClipMatrix:Matrix = thisClip.transform.matrix
			//
			var myMatrix:Matrix = new Matrix(myClipMatrix.a, 0, 0, myClipMatrix.d, (-myBounds.x*thisClip.scaleX)+thisBorderBuffer/2, (-myBounds.y*thisClip.scaleY)+thisBorderBuffer/2)
			var myAlpha:Number = thisClip.alpha
			thisClip.alpha=1
			myData.draw(thisClip, myMatrix, thisClip.transform.colorTransform,null,null,thisSmoothing)
			if (thisAdjust != "") {
				var myObject:Object = Objects.stringToObject(thisAdjust)
				Colours.adjustData(myData, myObject.b, myObject.c, myObject.s, myObject.h)
			}
			var myMap:Bitmap = new Bitmap(myData,thisSnapping,thisSmoothing)
			if ((myClipMatrix.a < 0 && myClipMatrix.d > 0)||(myClipMatrix.a > 0 && myClipMatrix.d < 0)) {	
				myMap.scaleY *= -1
				myMap.scaleX *= -1
				
			}
			if (thisClip.stage) {
				thisClip.stage.quality = myQuality
			}
			
			
			myMap.smoothing = true
			myMap.alpha = thisClip.alpha
			myMap.name = thisClip.name
			myMap.rotation = thisClip.rotation
			
			if (thisReplace&&thisClip.parent!=null) {
				myMap.x = thisClip.x+myBounds.x-thisBorderBuffer
				myMap.y = thisClip.y+myBounds.y-thisBorderBuffer
				thisClip.parent.addChildAt(myMap, depth(thisClip))
				remove(thisClip)
			}
		
			return myMap
		}
		public static function cache3d(thisClip:DisplayObject):void {
			try{
				thisClip.cacheAsBitmap = true
				thisClip["cacheAsBitmapMatrix"] = new Matrix()
			}catch (e:Error) {
						
			}
		}
		public static function 	width(thisClip:DisplayObject, thisWidth:Number):void {
			thisClip.width = thisWidth
			thisClip.scaleY = thisClip.scaleX
		}
		public static function 	height(thisClip:DisplayObject, thisHeight:Number):void {
			thisClip.height = thisHeight
			thisClip.scaleX =thisClip.scaleY
		}
		public static function scale(thisClip:DisplayObject, thisScaleX:Number = 1,thisScaleY:Number = NaN):void {
			thisClip.scaleX = thisScaleX
			thisClip.scaleY = thisScaleY!=thisScaleY?thisScaleX:thisScaleY
		}
		public static function scaleAgain(thisClip:DisplayObject,  thisScaleX:Number = 1, thisScaleY:Number = NaN):void {
			var myScaleX:Number = thisClip.scaleX * thisScaleX
			var myScaleY:Number = thisClip.scaleY * (thisScaleY != thisScaleY?thisScaleX:thisScaleY)
			scale(thisClip, myScaleX,myScaleY)
		}
		public static function getChildIfExists(thisParent:DisplayObjectContainer, thisNames:Array):DisplayObject {
			var myChild:DisplayObject
			for (var i:int = 0; i < thisNames.length;i++){
				myChild = thisParent.getChildByName(thisNames[i])
				if (myChild != null) {
					break
				}
			}
			return myChild
		}
		public static function isChild(thisChild:DisplayObject, thisParent:DisplayObjectContainer):Boolean {
			var isChild:Boolean
			if(thisChild!=null){
				var myParent:* = thisChild.parent
				while (myParent != null && !(myParent is Stage)) {
					if (myParent == thisParent) {
						isChild = true
						break
					}
					myParent = myParent.parent
				}
			}
			return isChild
		}
		public static function centreStage(thisClip:DisplayObject, thisUseRect:Boolean = false, thisAxis:String="",thisStage:Stage = null,thisParent:DisplayObjectContainer=null):void {
			var myStage:Stage = thisStage || thisClip.stage
			var myParent:DisplayObjectContainer = thisParent||thisClip.parent
		
			if (myStage) {
				var myStageCentre:Point = new Point(myStage.stageWidth / 2, myStage.stageHeight / 2)
				var myStageCentreParent:Point = myStageCentre.clone()
				var myX:Number = thisClip.x
				var myY:Number = thisClip.y
				if (myParent && myParent != myStage) {
					myStageCentreParent = myParent.globalToLocal(myStageCentreParent)
				}
				//
				if (thisUseRect) {
					var myBounds:Rectangle = boundsSelf(thisClip)
					myX = myStageCentreParent.x -(myBounds.width/2) - myBounds.x					
					myY = myStageCentreParent.y -(myBounds.height/2) - myBounds.y					
				}else {
					myX = myStageCentreParent.x
					myY = myStageCentreParent.y
				}
				thisClip.x = thisAxis=="x"||thisAxis==""?myX:thisClip.x
				thisClip.y = thisAxis=="y"||thisAxis==""?myY:thisClip.y
			}else {
				trace("ERROR - centreStage - no Stage specified")
			}
		}
		public static function centreRect(thisClip:DisplayObject, thisParent:DisplayObject = null, thisAxis:String = "", thisGlobal:Boolean = false):Point {
			return centre(thisClip, thisParent, thisAxis,true, thisGlobal)
		}
		public static function centre(thisClip:DisplayObject, thisParent:DisplayObject = null, thisAxis:String ="",thisUseRects:Boolean  = false, thisGlobal:Boolean = false):Point {
			var myParent:DisplayObject = thisParent == null?thisClip.parent:thisParent
			if (thisUseRects) {
				var myBoundsParent:Rectangle = myParent.getBounds(myParent)
				var myBoundsClip:Rectangle = thisClip.getBounds(thisClip)
				var myParentX:Number = myBoundsClip.x
				var myParentY:Number = myBoundsClip.y

				if (thisAxis == "x" || thisAxis == "") {
					var myParentOffsetX:Number = ((myBoundsParent.width * .5) + myBoundsParent.x)*myParent.scaleX
					var myClipOffsetX:Number = ((myBoundsClip.width * .5) + myBoundsClip.x)*thisClip.scaleX
					thisClip.x = myParentOffsetX-myClipOffsetX
				}
				if(thisAxis=="y"||thisAxis==""){
					var myParentOffsetY:Number = ((myBoundsParent.height * .5) + myBoundsParent.y)*myParent.scaleY
					var myClipOffsetY:Number = ((myBoundsClip.height * .5) + myBoundsClip.y) * thisClip.scaleY
					thisClip.y = myParentOffsetY - myClipOffsetY
					
				}
				if (thisGlobal && thisClip.stage != null && myParent.stage != null) {
					var myGlobal:Point = new Point(thisClip.x, thisClip.y)
					myGlobal = myParent.parent.localToGlobal(myGlobal)
					myGlobal = thisClip.parent.globalToLocal(myGlobal)
					
					if (thisAxis == "x" || thisAxis == "") {
						thisClip.x= myGlobal.x
					}
					
					if (thisAxis == "y" || thisAxis == "") {
						thisClip.y= myGlobal.y
					}
				}
			}else {
				var myParentWidth:Number = myParent is Stage?Stage(myParent).stageWidth:myParent.width
				var myParentHeight:Number = myParent is Stage?Stage(myParent).stageHeight:myParent.height
				if (thisAxis == "x" || thisAxis == "") {
					thisClip.x = (myParentWidth - thisClip.width) / 2
				}
				if(thisAxis=="y"||thisAxis==""){
					thisClip.y = (myParentHeight - thisClip.height) / 2
				}
			}
			return new Point(thisClip.x, thisClip.y)
		}
		public static function remove(thisClip:DisplayObject, thisDestroy:Boolean = false):void {
			if (thisClip != null && thisClip.parent != null) {
				try{
					thisClip.parent.removeChild(thisClip);
					if (thisDestroy) {
						Listen.destroy(thisClip)
					}
				}catch (e:Error) {
					// could be a recursion error
				}
			}
		}
		public static function withinBounds(thisClip:DisplayObject, thisCoordSpace:DisplayObject = null):Boolean {
			var myCoordSpace:DisplayObject = thisCoordSpace||thisClip
			var myBounds:Rectangle = thisClip.getBounds(myCoordSpace)
			return withinRect(myBounds, new Point(myCoordSpace.mouseX, myCoordSpace.mouseY))
			
		}
		public static function bounds(thisClip:DisplayObject,thisTrace:Boolean = false):Rectangle {
			var myRectangle:Rectangle
			var myScope:DisplayObject= thisClip.parent||thisClip
			myRectangle = thisClip.getBounds(myScope)
			if (thisTrace) {
				trace("Bounds = "+myRectangle)
			}
			return myRectangle
		}
		public static function boundsSelf(thisClip:DisplayObject,thisTrace:Boolean = false):Rectangle {
			var myRectangle:Rectangle
			var myScope:DisplayObject= thisClip
			myRectangle = thisClip.getBounds(myScope)
			if (thisTrace) {
				trace("Bounds = "+myRectangle)
			}
			return myRectangle
		}
		public static function withinRect(thisRect:Rectangle, thisPoint:Point):Boolean{
			var myWithin:Boolean 
			if(thisPoint.x>thisRect.x&&thisPoint.x<thisRect.x+thisRect.width&&thisPoint.y>thisRect.y&&thisPoint.y<thisRect.y+thisRect.height){
				myWithin = true
			}
			return myWithin
		}
				//
		// Really no idea if this wokrs - WOW, it does!
		public static function duplicateDisplayObject(source:DisplayObject,  autoAdd:Boolean = false ):DisplayObject{
			 // create duplicate
			 var sourceClass:Class = Object(source).constructor;
			 var duplicate:DisplayObject = new sourceClass();
			
			// duplicate properties
			 duplicate.transform = source.transform;
			 duplicate.filters = source.filters;
			 duplicate.cacheAsBitmap = source.cacheAsBitmap;
			 duplicate.opaqueBackground = source.opaqueBackground;

			 // add to source parent's display list
			 // if autoAdd was provided as true
			 if (autoAdd && source.parent) {
				 source.parent.addChild(duplicate);
			 }
			 return duplicate;
		 }   
		 public static function cacheToStage(thisDisplayObject:DisplayObject, thisStage:Stage, thisRecursion:int = -1):void {
			 // EXPERIMENTAL
			 if (thisRecursion!=0 && thisDisplayObject is DisplayObjectContainer && DisplayObjectContainer(thisDisplayObject).numChildren > 1) {
				 var myChildren:Array = getChildren(DisplayObjectContainer(thisDisplayObject),DisplayObject)
				 for (var i:int; i < myChildren.length; i++) {
					 var myChild:DisplayObject = myChildren[i]
					 cacheToStage(myChild, thisStage, thisRecursion-1)
				 }
			 }else {
				 var myCached:Sprite = cachedCopy(thisDisplayObject) as Sprite
				 var myLocation:Point = new Point(myCached.x, myCached.y)
				 if(myCached.parent){
					myLocation = myCached.parent.localToGlobal(myLocation)
				 }
				 myCached.x = myLocation.x
				 myCached.y = myLocation.y
				 thisStage.addChild(myCached)
			 }
		 }
		 public static function moveChildrenToStage(thisDisplayObject:DisplayObjectContainer, thisStage:Stage):void {
			 var myChildren:Array = getChildren(thisDisplayObject)
			 for (var i:int = 0; i < myChildren.length; i++) {
				 moveToStage(myChildren[i],thisStage)
			 }
		 }
		 public static function moveToStage(thisDisplayObject:DisplayObject, thisStage:Stage):void {
			  var myLocation:Point = new Point(thisDisplayObject.x, thisDisplayObject.y)
			 if(thisDisplayObject.parent){
				myLocation = thisDisplayObject.parent.localToGlobal(myLocation)
			 }
			 thisDisplayObject.x = myLocation.x
			 thisDisplayObject.y = myLocation.y
			 thisStage.addChild(thisDisplayObject)
		 }
		 public static function child(thisParent:DisplayObjectContainer, thisChildName:String):MovieClip {
			 return thisParent.getChildByName(thisChildName) as MovieClip
		 }
		 public static function field(thisParent:DisplayObjectContainer, thisChildName:String):TextField {
			 return thisParent.getChildByName(thisChildName) as TextField
		 }
		 public static function getLabelFrame(thisClip:MovieClip, thisName:String):int {
			var myLabels:Array = thisClip.currentLabels
			var myFrame:int = -1
			var myLabel:FrameLabel
			for (var i:int = 0; i < myLabels.length; i++) {
				myLabel = myLabels[i]
				if (myLabel.name == thisName) {
					myFrame = myLabel.frame
					break
				}
			}
			return myFrame
		}

	}
}