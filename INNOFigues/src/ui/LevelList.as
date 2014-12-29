package ui
{
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class LevelList extends Sprite
	{
		private var _levellistMc:leveltmc
		private var ListSrc:String

		public function LevelList()
		{
			
			addEventListener(Event.ADDED_TO_STAGE, init)
		}

		private function init(evt:Event):void
		{
		
			_levellistMc=new leveltmc()
			this.addChild(_levellistMc)

			var _timer:Timer=new Timer(1000);
			_timer.addEventListener(TimerEvent.TIMER, onTimer);
			_timer.start()
		

		}
		private function onTimer(evt:TimerEvent):void{
		
			ShowLevel()
		}
		

		public function ShowLevel():void
		{
			_levellistMc.life.gotoAndStop(Data.life+1)
			_levellistMc.level.text=String(Data.level)

			ListSrc=""
			for (var i:int=0; i < Data.ScoreList.length; i++)
			{
				if (Data.ScoreList[i] == 1)
				{
					ListSrc+="O"
				}
				else
				{
					ListSrc+="X"
				}
			}
			_levellistMc.levellist.text=ListSrc

		}
	}
}
