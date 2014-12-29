package ui
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.TimerEvent;
	import flash.utils.Timer;
	import flash.utils.getDefinitionByName;

	public class Countdown extends Sprite
	{
		private var _timer:Timer
		private var _id:int=5
		private var _icon:MovieClip=null

		public function Countdown(callback:Function=null)
		{
			_timer=new Timer(1000, 5);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.addEventListener(TimerEvent.TIMER_COMPLETE, callback)
			setUi()
		}


		private function onTimer(event:TimerEvent):void
		{
			trace("on timer");
			setUi()
		}

		private function setUi():void
		{
			if (_icon != null)
			{
				removeChild(_icon)
			}
			var tmp:Class=getDefinitionByName("t" + _id) as Class
//			addChild(new tmp())

		}


	}
}
