package com.codeandvisual.ext {
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.MouseEvent;
	import flash.geom.Rectangle;
	public class Drag {
		//
		static protected var pDragClip:Sprite;
		static protected var pDragCentre:Boolean;
		static protected var pDrag:Rectangle;
		static protected var pDragMonitor:Function
		static protected var pDragReleased:Function
		static protected var pDragBounds:Rectangle
		//
		//
		//***************************************************************************
		//
		//
		// DRAG/DROP
		//
		//
		//***************************************************************************

		public static function doDrag(thisClip:Sprite, thisSnap:Boolean = false, thisBounds:Rectangle = null, thisMonitor:Function = null, thisReleased:Function = null, thisStage:Stage = null):void {
			pDragClip=thisClip;
			pDragClip.startDrag(thisSnap, thisBounds);
			pDragMonitor = thisMonitor
			pDragReleased = thisReleased
			var myStage:Stage = thisStage || pDragClip.stage
			if (pDragMonitor != null) {
				Listen.listen(myStage, MouseEvent.MOUSE_MOVE,pDragMonitor)
			}
			Listen.addUp(myStage, stopDrag);
		}
		public static function setDrag(evt:MouseEvent):void {
			pDragClip.startDrag(pDragCentre, pDragBounds);
			Listen.addUp(pDragClip.stage, stopDrag);
		}
		public static function stopDrag(evt:MouseEvent=null):void {
			if (pDragClip) {
				if(pDragClip.stage){
					Listen.removeListener(pDragClip.stage, MouseEvent.MOUSE_UP, stopDrag);
					if(pDragMonitor!=null){
						Listen.removeListener(pDragClip.stage, MouseEvent.MOUSE_MOVE, pDragMonitor)
					}
					pDragClip.stage.mouseChildren = true;
				}
				pDragClip.stopDrag();
			}
			if (pDragReleased != null) {
				pDragReleased()
			}
			pDragReleased = null
			pDragClip = null
			pDragMonitor = null
			pDragBounds = null
		}
	

	}
}