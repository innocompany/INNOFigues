package api
/**
 * 此类用来生成奖池，按照一定时间重新设置一次奖池，无限循环。每天按12小时开机时间算
 * 0无奖
 * 1百丽宫影券  每天150个
 * 2礼阁仕50元超市券 每天40个
 * 3星巴克咖啡券 每天400个
 * 4购物袋 每天500个
 */
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.utils.Timer;

	public class Kudo extends Sprite
	{
		private var timerOut:int=60 // 每60分钟重置一次奖池
		private var extent:int=12 * 60 //每天工作时长   分钟
		private var contLose:int=40//尝试加入的空奖项。。。。。。。额，整体奖池数据超过120个。。。。一个小时。。。
		private var timer:Timer
		private var dat:Array=Data.kudoList

		public function Kudo()
		{
			addEventListener(Event.ADDED_TO_STAGE, init)
		}

		private function init(evt:Event):void
		{
			timer=new Timer(1000 * timerOut * 60)
			timer.addEventListener(TimerEvent.TIMER, setKudos)
			timer.start()
			setKudo()
		}
		
		protected function setKudos(event:TimerEvent):void
		{
			setKudo()
		}
		
		public function setKudo():void
		{
			trace("重新配置奖池")
			Data.kudoList=[]
			//1
			trace("生成1:" + Math.floor(timerOut / extent * 150))
			for (var i:int=0; i < Math.floor(timerOut / extent * 150); i++)
			{
				dat.push(1)
			}
			//2.
			trace("生成2:" + Math.floor(timerOut / extent * 40))
			for (var j:int=0; j < Math.floor(timerOut / extent * 40); j++)
			{
				dat.push(2)
			}
			//3
			trace("生成3:" + Math.floor(timerOut / extent * 400))
			for (var k:int=0; k < Math.floor(timerOut / extent * 400); k++)
			{
				dat.push(3)
			}
			//4
			trace("生成4:" + Math.floor(timerOut / extent * 500))
			for (var g:int=0; g < Math.floor(timerOut / extent * 500); g++)
			{
				dat.push(4)
			}
			//0
			for (var t:int=0; t < contLose; t++)
			{
				dat.push(0)
			}
			dat.sort(sortF);
//			Data.kudoList=dat
			trace(dat.length,dat)	
		}
		private function sortF(a,b):int {
			return Math.floor(Math.random()*contLose-1);
		}
		
	
	}
}
