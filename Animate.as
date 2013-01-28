package com.codeandvisual.ext {
	//
	//-------------------------------------------------------------------
	// Requires the Tweener package for AS3: http://code.google.com/p/tweener/
	//-------------------------------------------------------------------
	import caurina.transitions.Tweener;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	public class Animate {
		public static function killAllTweens(thisClip:*, thisSelf:Boolean = true,thisChildren:Boolean = true, thisRecursive:Boolean = true):void {
			try {
				if (thisChildren&&thisClip is DisplayObjectContainer) {
					var myNumChildren:int=thisClip.numChildren;
					for (var i:int = myNumChildren - 1; i >= 0; i--) {
						var myChild:DisplayObject=thisClip.getChildAt(i);
						if (thisRecursive) {
							killAllTweens(myChild, thisSelf,thisChildren, thisRecursive);
						}
						// the following should be considerred a seperate task. (explicitly use a seperate call to killListeners)
						/*if (myChild is EventDispatcher) {
							EventManager.removeAllListeners(myChild);
						}*/
					}
				}
			}catch (e:Error) {
				// Could catch a sandbox error
			}
			if (thisSelf) {
				Tweener.removeTweens(thisClip);
			}
		}
		public  static function fade(thisClip:DisplayObject, thisAlpha:Number = 0, thisComplete:Function = null , thisTime:Number = .75, thisEase:String = "linear", thisAutoVisible:Boolean = true):void {
			var myComplete:Function = thisComplete == null && thisAutoVisible?autoVisible:thisComplete
			var myCompleteParams:Array = myComplete == autoVisible?[thisClip, thisAlpha]:[]
			var myStart:Function = myComplete == autoVisible?autoVisible:null
			var myStartParams:Array = myComplete == autoVisible?[thisClip, 1]:[]
			Tweener.addTween(thisClip, {alpha:thisAlpha, onComplete:myComplete, time:thisTime, transition:thisEase, onCompleteParams:myCompleteParams, onStart:myStart, onStartParams:myStartParams});
		}
		public  static function blur(thisClip:DisplayObject, thisAmount:Number = 0, thisComplete:Function = null , thisTime:Number = .75, thisEase:String = "linear"):void {
			// need to init filters in your app first to use this: FilterShortcuts.init()
			var myComplete:Function = thisComplete 
			Tweener.addTween(thisClip, {_Blur_blurX:thisAmount, _Blur_blurY:thisAmount, onComplete:myComplete, time:thisTime, transition:thisEase });
		}
		
		
		public static function autoVisible(thisClip:DisplayObject, thisTarget:Number):void {
			thisClip.visible = thisTarget >0
		}
		public static function rotate(thisClip:DisplayObject, thisRotation:Number = 0,thisComplete:Function = null , thisTime:Number = .75, thisEase:String = "linear"):void {
		Tweener.addTween(thisClip, {rotation:thisRotation, onComplete:thisComplete, time:thisTime, transition:thisEase});
		}
		public static function slide(thisClip:DisplayObject,thisTarget:Number, thisProperty:String="x", thisComplete:Function = null , thisTime:Number = .75, thisEase:String = "easeInOutCubic"):void {
			var myTweenObject:Object={onComplete:thisComplete,time:thisTime,transition:thisEase};
			myTweenObject[thisProperty]=thisTarget;
			Tweener.addTween(thisClip,myTweenObject);
		}
		public static function scale(thisClip:DisplayObject,thisTargetX:Number=1, thisTargetY:Number = NaN, thisComplete:Function = null , thisTime:Number = .75, thisEase:String = "easeInOutCubic"):void {
			
			var myY:Number = thisTargetY!=thisTargetY?thisTargetX:thisTargetY
			var myTweenObject:Object={onComplete:thisComplete,time:thisTime,transition:thisEase};
			myTweenObject.scaleX=thisTargetX;
			myTweenObject.scaleY=myY;
			Tweener.addTween(thisClip,myTweenObject);
		}
		public static function move(thisClip:DisplayObject, thisX:Number, thisY:Number,thisComplete:Function = null , thisTime:Number = .75, thisEase:String = "easeInOutCubic"):void {
			Tweener.addTween(thisClip, {x:thisX, y:thisY, onComplete:thisComplete, time:thisTime, transition:thisEase});
		}


		public static function tweenProp(thisObject:*, thisProp:String,thisTarget:Number,thisFunctions:* = null , thisTime:Number = .75, thisEase:String = "easeInOutCubic"):void {
			var myTweenProps:Object = new Object()
			myTweenProps[thisProp]=thisTarget
			//myTweenProps.onComplete = thisComplete
			if(thisFunctions is Function){
				myTweenProps.onComplete = thisFunctions
			}else if(thisFunctions is Object){
				myTweenProps = Objects.mergeObjects(myTweenProps,thisFunctions)
			}
			myTweenProps.time =thisTime
			myTweenProps.transition = thisEase
			Tweener.addTween(thisObject, myTweenProps);
		}
		public static function tween(thisClip:*, thisProps:Object, thisTime:Number = .75, thisEase:String = "easeInOutCubic"):void {
			var myProps:Object = {time:thisTime,transition:thisEase}
			for(var i:String in thisProps){
				myProps[i]  = thisProps[i]
			}
			Tweener.addTween(thisClip,myProps)
		}
		public static function tweenFrames(thisClip:MovieClip, thisEndFrame:int, thisComplete:Function, thisStartFrame:Number = NaN):void {
			if (!isNaN(thisStartFrame)) {
				thisClip.gotoAndStop(thisStartFrame)
			}
			var myTime:int = thisEndFrame - thisClip.currentFrame
			Tweener.addTween(thisClip, { _frame:thisEndFrame, useFrames:true, time:myTime, onComplete:thisComplete } )
		}
		public static function killWait(thisObject:*):void {
			if (thisObject != null) {
				//tween(thisObject, { x:1, onComplete:null }, .025)
				killTweens(thisObject)
			}
		}
		public static function wait(thisComplete:Function, thisTime:Number = 1,thisObject:*=null):Object{
			var myObject:* = thisObject==null?{x:0}:thisObject
			tween(myObject,{x:1,onComplete:thisComplete},thisTime)
			return myObject
		}
		public static function killTweens(thisObject:*= null):void {
			if(thisObject==null){
				Tweener.removeAllTweens()
				trace("****************************\n*  RED ALERT - kill tweens called with a null argument - deleting tweens from entire application\n****************************")
			}else {
				Tweener.removeTweens(thisObject)
			}
		}
	}
}