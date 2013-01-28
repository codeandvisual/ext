package com.codeandvisual.ext {
	import com.codeandvisual.Tools.EventManager;
	import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IEventDispatcher;
	import flash.events.MouseEvent;
	public class Listen {
		//
		//
		//***************************************************************************
		//
		//
		// Remove
		//
		//
		//***************************************************************************
		public static var default_button_over:Function
		public static var default_button_out:Function
		//
		public static function killAllListeners(thisDispatcher:*):void {
			if (thisDispatcher!=null && thisDispatcher is IEventDispatcher) {
				EventManager.removeAllListeners(thisDispatcher)
			}else {
				trace("MISC - NOT AN EVENT dispatCHer, COULD NOT REMOVE EVENTS")
			}
		}
		public static function killListeners(thisClip:DisplayObjectContainer, thisSelf:Boolean = true,thisChildren:Boolean = true, thisRecursive:Boolean = true):void {
			try {
				if (thisChildren) {
					var myNumChildren:int = thisClip.numChildren;
					for (var i:int = myNumChildren - 1; i >= 0; i--) {
						var myChild:DisplayObject = thisClip.getChildAt(i);
						if (myChild is EventDispatcher) {
							EventManager.removeAllListeners(myChild);
						}
						if (thisRecursive&&myChild is DisplayObjectContainer) {
							killListeners(myChild as DisplayObjectContainer, thisSelf,thisChildren, thisRecursive);
						}
					}
				}
			}catch (e:Error) {
				// Could catch a sandbox error
			}
			if (thisSelf) {
				EventManager.removeAllListeners(thisClip);
			}
		}
	
		public static function removeListener(thisClip:IEventDispatcher, thisType:String, thisFunction:Function):void {
			if(thisClip!=null){
				EventManager.removeEventListener(thisClip, thisType, thisFunction)
			}
		}
		static public function killListener(thisEvent:Event, thisCallee:Function):void {
			if(thisEvent!=null){
				var myTarget:IEventDispatcher = IEventDispatcher(thisEvent.currentTarget)
				var myType:String = thisEvent.type
				var myListener:Function = thisCallee
				EventManager.removeEventListener(myTarget, myType, myListener) 
			}
		}
		//
		//
		//***************************************************************************
		//
		//
		// Listeners
		//
		//
		//***************************************************************************
		public static function addCycle(thisClip:*, thisFunction:Function, thisSendEvent:Boolean=true):void {
			// thisSendEvent not used yet, but could be incoporated if the Misc class could create a 
			// unique dedicated monitor per enterframe
			EventManager.addEventListener(thisClip, Event.ENTER_FRAME, thisFunction);
		}
		public static function killCycle(thisClip:*, thisFunction:Function):void {
			// thisSendEvent not used yet, but could be incoporated if the Misc class could create a 
			// unique dedicated monitor per enterframe
			EventManager.removeEventListener(thisClip, Event.ENTER_FRAME, thisFunction);
		}
		public static function listen(thisClip:IEventDispatcher, thisID:String, thisFunction:Function):void {
			EventManager.addEventListener(thisClip, thisID, thisFunction)
		}

		//
		//
		//***************************************************************************
		//
		//
		// Buttons
		//
		//
		//***************************************************************************
		public static function addActions(thisClip:*, thisClick:Function=null, thisOver:Function=null, thisOut:Function = null, thisUpNotClick:Boolean=false):void {
			if (thisClick != null) {
				if (thisUpNotClick) {
					addUp(thisClip, thisClick);
				}else{
					addClick(thisClip, thisClick);
				}
			}
			thisOver = thisOver!=null?thisOver:default_button_over||doSimpleOver
			thisOut = thisOut!=null?thisOut:default_button_out||doSimpleOut
			if (thisOver!=null) {
				addOver(thisClip, thisOver);
			}
			if (thisOut!=null) {
				addOut(thisClip, thisOut);
			}
		}
		public static function doSimpleOver(e:MouseEvent):void {
			var myClip:MovieClip = MovieClip(e.currentTarget)
			if(myClip.totalFrames>1){
				myClip.gotoAndStop(2)
			}else {
				myClip.alpha = .7
			}
		}
		public static function doSimpleOut(e:MouseEvent):void {
			var myClip:DisplayObject = DisplayObject(e.currentTarget)
			if(myClip is MovieClip && MovieClip(myClip).totalFrames>1){
				MovieClip(myClip).gotoAndStop(1)
			}else {
				myClip.alpha = 1
			}
		}
		public static function addClick(thisClip:*, thisFunction:Function, thisChildren:Boolean=false, thisUseHandCursor:Boolean=true, thisUseCapture:Boolean=false, thisPriority:int=0):void {
			makeButton(thisClip,thisChildren, thisUseHandCursor);
			EventManager.addEventListener(thisClip,MouseEvent.CLICK,thisFunction, thisUseCapture,thisPriority);
			//thisClip.addEventListener(MouseEvent.MOUSE_UP,thisFunction, thisUseCapture,thisPriority)
		}
		public static function addUp(thisClip:*, thisFunction:Function, thisChildren:Boolean=false, thisUseHandCursor:Boolean=true, thisUseCapture:Boolean=false, thisPriority:int=0):void {
			makeButton(thisClip,thisChildren, thisUseHandCursor);
			EventManager.addEventListener(thisClip,MouseEvent.MOUSE_UP,thisFunction, thisUseCapture,thisPriority);
			//thisClip.addEventListener(MouseEvent.MOUSE_UP,thisFunction, thisUseCapture,thisPriority)
		}
		public static function addDown(thisClip:*, thisFunction:Function, thisChildren:Boolean=false, thisUseHandCursor:Boolean=true, thisUseCapture:Boolean=false, thisPriority:int=0):void {
			makeButton(thisClip,thisChildren, thisUseHandCursor);
			EventManager.addEventListener(thisClip,MouseEvent.MOUSE_DOWN,thisFunction, thisUseCapture,thisPriority);
			//thisClip.addEventListener(MouseEvent.MOUSE_DOWN,thisFunction, thisUseCapture,thisPriority)
		}
		public static function addOver(thisClip:*, thisFunction:Function, thisChildren:Boolean=false, thisUseHandCursor:Boolean=true, thisUseCapture:Boolean=false, thisPriority:int=0):void {
			makeButton(thisClip,thisChildren, thisUseHandCursor);
			EventManager.addEventListener(thisClip,MouseEvent.MOUSE_OVER,thisFunction, thisUseCapture,thisPriority);
			//thisClip.addEventListener(MouseEvent.MOUSE_OVER,thisFunction)
		}
		public static function addOut(thisClip:*, thisFunction:Function, thisChildren:Boolean=false, thisUseHandCursor:Boolean=true, thisUseCapture:Boolean=false, thisPriority:int=0):void {
			makeButton(thisClip,thisChildren, thisUseHandCursor);
			EventManager.addEventListener(thisClip,MouseEvent.MOUSE_OUT,thisFunction, thisUseCapture,thisPriority);
			//thisClip.addEventListener(MouseEvent.MOUSE_OUT,thisFunction)
		}
		public static function makeButton(thisClip:*, thisChildren:Boolean = false, thisUseHandCursor:Boolean = true):void {
			try{
				thisClip.mouseEnabled = true
			}catch (e:Error) {
				
			}
			if (thisClip.hasOwnProperty("buttonMode")) {
				thisClip.buttonMode=true;
			}
			if (thisClip.hasOwnProperty("useHandCursor")) {
				thisClip.useHandCursor=thisUseHandCursor;
			}
			if (thisClip.hasOwnProperty("mouseChildren")) {
				thisClip.mouseChildren=thisChildren;
			}
		}
		public static function addMouseAbsorb(thisClip:*,thisUseHandCursor:Boolean=false):void {
			addClick(thisClip,absorbMouse, false, thisUseHandCursor);
		}
		public static function absorbMouse(evt:MouseEvent):void {
			evt.stopPropagation();
		}
		public static function callDestroy(thisObject:*):void {
			if (thisObject != null&& thisObject.hasOwnProperty("destroy")) {
				thisObject.destroy()
			}
		}
		//
		//
		//***************************************************************************
		//
		//
		// Destroy
		//
		//
		//***************************************************************************
		/**/public static function destroy(thisObject:*, thisRecursive:Boolean = true,thisNullify:Boolean = true):void {
			if (thisObject != null) {
				killAllListeners(thisObject)
				if (thisObject is DisplayObjectContainer&&thisRecursive) {
					try {
						var myCount:int = DisplayObjectContainer(thisObject).numChildren
						for (var i:int = myCount - 1; i >= 0; i--) {
							var myChild:DisplayObject = thisObject.getChildAt(i)
							destroy(myChild)
						}
					}catch (e:Error) {
						// Could be a sandbox issue
					}	
				}
				Animate.killAllTweens(thisObject)
				if (thisObject is MovieClip) {
					MovieClip(thisObject).stop()
					
				}
				if (thisObject is DisplayObject) {
					var myParent:DisplayObjectContainer = thisObject.parent
					
					Clip.remove(thisObject)
					if (myParent != null && myParent is MovieClip) {
						try{
							MovieClip(myParent)[thisObject.name] = null;
						}catch (e:Error) {
							// might be trying to take something off the root? Not sure why this is a problem
						}
					}
				}
				if (thisNullify) {
					thisObject = null
				}
			}
		}

	}
}