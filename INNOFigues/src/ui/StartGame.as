package ui
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Matrix;
	import flash.geom.Point;

	public class StartGame extends Sprite
	{
		public var _startView:StartMc
		private static var bmpd1:BitmapData;
		private static var bmpd2:BitmapData;
		private var id:int=0

		public function StartGame()
		{
			_startView=new StartMc()
			addChild(_startView)
			this.visible=false
			bmpd1=new BitmapData(1366, 768, true, 0);
			bmpd2=bmpd1.clone()
		}
		public function init():void
		{
			this.visible=true
			addEventListener(Event.ENTER_FRAME, checkStartuser)
		}
		protected function checkStartuser(event:Event):void
		{
			if (Data.user)
			{
				removeEventListener(Event.ENTER_FRAME, checkStartuser)
				dispatchEvent(new Event("StartGame", true))
			}
		}
		protected function checkStart(event:Event):void
		{
//			trace("checkstart")
			id++
			if (id == 3)
			{
				if (HitCheckMc(_startView.Manhit, _startView.hit1) && HitCheckMc(_startView.Manhit, _startView.hit2))
				{

					trace("gamestart")
					dispatchEvent(new Event("StartGame", true))
					removeEventListener(Event.ENTER_FRAME, checkStart)

				}
				id=0
			}

		}

		public function addbitMap(evt:Bitmap):void
		{

			_startView.Manhit.addChild(evt)
		}


		public function HitCheckMc(mc1:MovieClip, mc2:MovieClip):Boolean
		{

			var _bool:Boolean=false
			bmpd1.fillRect(bmpd1.rect, 0);
			bmpd2.fillRect(bmpd2.rect, 0);
			bmpd1.draw(mc1, new Matrix(1, 0, 0, 1, mc1.x, mc1.y));
			bmpd2.draw(mc2, new Matrix(1, 0, 0, 1, mc2.x, mc2.y));
			addChild(new Bitmap(bmpd1))
			addChild(new Bitmap(bmpd2))
			if (bmpd1.hitTest(new Point(), 255, bmpd2, new Point(), 255))
			{
				_bool=true
			}
			return _bool
		}
	}
}
