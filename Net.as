package com.codeandvisual.ext {
	import com.codeandvisual.Tools.EventManager;
	import com.codeandvisual.Tools.SWFLoader;
	import flash.display.Loader;
	import flash.events.Event;
	import flash.events.IOErrorEvent;
	import flash.events.ProgressEvent;
	import flash.net.navigateToURL;
	import flash.net.sendToURL;
	import flash.net.URLLoader;
	import flash.net.URLRequest;
	import flash.net.URLVariables;
	import flash.system.LoaderContext;
	public class Net {
			public static function post(thisPath:String,thisData:Object=null, thisSuccess:Function=null ,thisError:Function = null, thisProgress:Function=null,thisHeaders:Array=null,thisRequest:URLRequest = null, thisLoader:URLLoader=null):URLLoader {
			//
			// -----------------------------------------------------------
			// Create Loader
			// -----------------------------------------------------------
			var myLoader:URLLoader = thisLoader||new URLLoader();
			var myRequest:URLRequest
			
			if (thisRequest == null) {
				myRequest = new URLRequest(thisPath);
				myRequest.method = "POST";
			}else {
				myRequest = thisRequest
			}
			if (thisHeaders != null) {
				myRequest.requestHeaders = thisHeaders
			}
			

			var myVariables:* = new URLVariables();
			if (thisData != null) {
				var myPairFound:Boolean
				for (var i:String in thisData) {
					myPairFound = true
					myVariables[i]=thisData[i];
				}
				myVariables = myPairFound?myVariables:thisData
			}
			myRequest.data=myVariables;
			//
			// -----------------------------------------------------------
			// Add Listeners
			// -----------------------------------------------------------
			if (thisError!=null) {
				EventManager.addEventListener(myLoader,IOErrorEvent.IO_ERROR, thisError);
			}
			if (thisProgress!=null) {
				EventManager.addEventListener(myLoader,ProgressEvent.PROGRESS, thisProgress);
			}
			if (thisSuccess!=null){
				EventManager.addEventListener(myLoader, Event.COMPLETE, thisSuccess);
			}
			//
			// -----------------------------------------------------------
			// Send Request
			// -----------------------------------------------------------
			myLoader.load(myRequest);
			return myLoader
		}
		public static function loadFromURL(thisPath:String, thisFunction:Function=null, thisError:Function=null, thisProgress:Function=null, thisCreateContext:Boolean = true):Loader {
			var myRequest:URLRequest=new URLRequest(thisPath);
			var myLoader:Loader = new Loader();
			if (thisError!=null) {
				EventManager.addEventListener(myLoader.contentLoaderInfo,IOErrorEvent.IO_ERROR, thisError);
			}
			if (thisProgress!=null) {
				EventManager.addEventListener(myLoader.contentLoaderInfo,ProgressEvent.PROGRESS, thisProgress);
			}
			if (thisFunction!=null){
				EventManager.addEventListener(myLoader.contentLoaderInfo, Event.COMPLETE, thisFunction); 
			}
		
			var myContext:LoaderContext
			if (thisCreateContext) {
				myContext	=new LoaderContext(true);
			}
			//myContext.applicationDomain = new ApplicationDomain(ApplicationDomain.currentDomain)
			myLoader.load(myRequest, myContext);
			return myLoader
		}

		public static function loadXML(thisPath:String, thisFunction:Function, thisError:Function=null, thisProgress:Function=null):void {
			var myXMLURL:URLRequest=new URLRequest(thisPath);
			var myLoader:URLLoader=new URLLoader();
			if (thisError!=null) {
				myLoader.addEventListener(IOErrorEvent.IO_ERROR, thisError);
			}
			if (thisProgress!=null) {
				myLoader.addEventListener(ProgressEvent.PROGRESS, thisProgress);
			}
			myLoader.addEventListener("complete", thisFunction);
			myLoader.load(myXMLURL)
		}
		public static function loadSWF(thisPath:String, thisFunction:Function, thisError:Function=null, thisProgress:Function=null):void {
			var myLoader:SWFLoader = new SWFLoader(thisPath, thisFunction , thisProgress, thisError)
		}
		public static function link(thisPath:String, thisWindow:String = "_blank"):void {
			navigateToURL(new URLRequest(thisPath),thisWindow)
		}
		public static function send(thisPath:String):void {
			var myRequest:URLRequest = new URLRequest(thisPath)
			myRequest.method = "GET"
		
			sendToURL(myRequest)
		}
		public static function canLink():Boolean {
			var myResult:Boolean
			try {
				sendToURL(new URLRequest("http://www.actionsprite.com"))
				myResult=true
			}
			catch (e:Error) {
				trace("I was not allowed to access actionsprite")
			}
			return myResult
		}
	}
}