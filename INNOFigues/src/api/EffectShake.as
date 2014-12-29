package api
{
	import flash.display.*;
	import flash.utils.Timer;
	import flash.utils.Dictionary;
	import flash.events.*;

	public class EffectShake
	{
		private var timer:Timer;
		private var deley:Number;
		private var startX:Number;
		private var startY:Number;
		private var para:Number; //震动的参数   
		private var m_contain:Dictionary;
		private var currentID:String;

		public function EffectShake(deley:Number=100, para:Number=30)
		{
			m_contain=new Dictionary(true);

			this.deley=deley;
			this.para=para;

			timer=new Timer(deley);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}

		/* 添加列表
		*
		*/

		public function addList(id:String, obj:*):void
		{
			m_contain[id]=obj;
		}

		private function onTimer(event:TimerEvent):void
		{
			moveBy();
		}

		public function start(id:String):void
		{
			startX=getObject(id).x;
			startY=getObject(id).y;
			currentID=id;
			timer.start();
		}

		private function getObject(id:String):*
		{
			return m_contain[id];
		}

		public function stop():void
		{
			timer.stop();
			getObject(currentID).x=startX;
			getObject(currentID).y=startY;
			getObject(currentID).rotation=0
		}

		public function destory():void
		{
			timer.removeEventListener(TimerEvent.TIMER, onTimer);
		}

		public function reStart():void
		{
			timer=new Timer(deley);
			timer.addEventListener(TimerEvent.TIMER, onTimer);
		}

		private function moveBy():void
		{
			getObject(currentID).x=startX + Math.random() * para;
			getObject(currentID).y=startY + Math.random() * para;
//			getObject(currentID).rotation=Math.floor(Math.random() * 10) - 5;
		}
	}
}

