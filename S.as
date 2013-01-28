package com.codeandvisual.ext {
	import com.codeandvisual.Tools.Sounds;
	import flash.display.Stage;
	import flash.media.Sound;
	import flash.media.SoundMixer;
	import flash.media.SoundTransform;
	import flash.text.TextField;
	
	/**
	 * ...
	 * @author james@codeandvisual.com
	 */
	public class S {
		private static const _sounds:Sounds = new Sounds()
		public static var muted:Boolean
		public static var mute_loops:Boolean
		public static var mute_events:Boolean
		
		public static function play(thisId:String, thisVolume:Number = .8, thisPan:Number = 0):void {
			if(!mute_events){
				_sounds.playEvent(thisId, thisVolume, thisPan)
			}
		}
		
		public static function loop(thisId:String, thisVolume:Number = .8, thisAutoKill:Boolean = false):void {
			if(!mute_loops){
				_sounds.playLoop(thisId, thisVolume, thisAutoKill)
			}
		}
		
		public static function add(thisSound:Class, thisType:String = "event", thisName:String = ""):void {
			_sounds.initSound(thisSound, thisType, thisName)
		}
		public static function stopEvents():void {
			_sounds.stopEvents()
		}
		public static function stop(thisId:String):void {
			_sounds.killPlayingLoops()
		}
		public static function stopSound(thisId:String):void{
			_sounds.seekTo(thisId,0,"absolute")
			_sounds.pauseSound(thisId)
		}
		public static function pauseSound(thisId:String):void {
			_sounds.pauseSound(thisId)
		}
		public static function unpauseSound(thisId:String):void {
			_sounds.unpauseSound(thisId)
		}
		public static function toggleSound(thisId:String):void {
			_sounds.togglePlay(thisId)
		}
		public static function setPlayState(thisId:String, thisPlayState:Boolean = true):void {
			if (thisPlayState) {
				unpauseSound(thisId)
			}else {
				pauseSound(thisId)
			}
		}
		public static function getPercent(thisName:String):Number{
			return _sounds.getSoundPercent(thisName)
		}
		public static function getPosition(thisName:String):Number{
			return _sounds.getSoundPosition(thisName)
		}
		public static function getLength(thisName:String):Number{
			return _sounds.getSoundLength(thisName)
		}
		public static function fadeOn(thisId:String, thisLength:Number = .75, thisVolume:Number = .75):void {
			if(!mute_events){
				play(thisId, 0)
				fadeTo(thisId, thisVolume, thisLength)
			}
		}
		public static function fadeOff(thisId:String, thisLength:Number = .75):void {
			_sounds.fadeLoop(thisId, 0, null, thisLength)
		}
		
		public static function fadeTo(thisId:String, thisVolume:Number = .75, thisLength:Number = .75, thisType:String = "loop"):void {
			switch(thisType) {
				case "loop":
					_sounds.fadeEvent(thisId,thisVolume,null,thisLength)
					break
				case "event":
					_sounds.fadeLoop(thisId, thisVolume, null, thisLength)
					break
			}
			
		}
		
		public static function toggleMute():void {
			muted = !muted
			setMute(muted)
		}
		
		public static function setMute(thisState:Boolean):void {
			muted = thisState
			var volumeAdjust:SoundTransform = new SoundTransform();
			
			if (muted) {
				SoundMixer.soundTransform = new SoundTransform(0)
			} else {
				SoundMixer.soundTransform = new SoundTransform(1)
			}
		}
		public static function toggleMuteLoop():void {
			mute_loops = !mute_loops
		}
		public static function setMuteLoop(thisState:Boolean):void {
			mute_loops = thisState
		}
		public static function toggleMuteEvent():void {
			mute_events = !mute_events
		}
		public static function setMuteEvent(thisState:Boolean):void {
			mute_events = thisState
			if (mute_events) {
				_sounds.killPlayingLoops()
			}
		}
		
		public static function setMasterVol(thisVol:Number):void {
			SoundMixer.soundTransform = new SoundTransform(thisVol)
		}
	}

}