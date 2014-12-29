package ui
{
	import flash.display.Sprite;
	import flash.events.Event;

	public class ScoreBox extends Sprite
	{
		private var _Score:int=0
		private var _Scoremc:SListMc

		public function ScoreBox()
		{
			addEventListener(Event.ADDED_TO_STAGE, init)
		}

		private function init(evt:Event):void
		{
			_Scoremc=new SListMc()
			addChild(_Scoremc)
			_Scoremc.x=stage.stageWidth
		}
//		public function get Score():int
//		{
//			return _Score;
//		}
//		public function set Score(value:int):void
//		{
//			_Score = value;
//			ShowScore()
//		}
//		private function ShowScore():void
//		{
//			_Scoremc.txt.text=String(_Score)			
//		}
//		
	}
}