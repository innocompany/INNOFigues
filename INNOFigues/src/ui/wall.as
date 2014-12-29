package ui
{
	import com.greensock.TweenLite;
	import com.greensock.TweenMax;
	import com.greensock.easing.Cubic;
	
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.BlendMode;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.geom.ColorTransform;
	import flash.geom.Matrix;
	import flash.geom.Point;
	import flash.utils.setTimeout;

	public class wall extends Sprite
	{
		private var ID:int=1
		private var time:int=5
		public var _WallMc:wallmc
		private var _ren:wallren
		private var _ID:int=1
		private var _ManMc:ManMc
		//选中的人体模型
		private var bmpd1:BitmapData;
		private var bmpd2:BitmapData;
		private var _timeOut:uint
		public var tween:TweenLite
		private var startID:int=1

		public function wall()
		{
			addEventListener(Event.ADDED_TO_STAGE, stageInit)

		}

		protected function stageInit(event:Event):void
		{
			_WallMc=new wallmc()
			addChild(_WallMc)
			_WallMc.x=685
			_WallMc.y=392
			_WallMc.wallmove2.pic.pic.visible=false
			_WallMc.wallmove2.pic.pickuang.visible=false
			
			//this.visible=false
		}

		public function init():void
		{
			trace("墙壁初始化")
			//this.visible=false
			Data.level=1
			Data.Score=0
			Data.ScoreList=[]
			Data.life=3
			_WallMc.wallmove.Manhit.visible=true
			_ID=startID
			bmpd1=new BitmapData(1366, 768, true, 0);
			bmpd2=bmpd1.clone()
			try{tween.pause()}catch(e){}
			_WallMc.wallmove2.pic.pic.visible=false
			_WallMc.wallmove2.pic.pickuang.visible=false
			_WallMc.y=392
			_WallMc.z=0
			_WallMc.wallmove2.gotoAndStop(1)	
			_WallMc.wallmove.gotoAndStop(1)	
		}
		public function Move():void
		{
//			Data.life--
			_WallMc.wallmove.Manhit.visible=true
			
			//this.visible=true
			
			if (_ID >= Data.levelMax+1)
			{
				_ID=startID+1
			}
			
			_WallMc.wallmove.pic.pic.gotoAndStop(1)
			_WallMc.wallmove2.pic.pic.gotoAndStop(1)
			_WallMc.wallmove.wallhit.gotoAndStop(_ID)
			_WallMc.wallmove.wallhit2.gotoAndStop(_ID)
//			_WallMc.wallpic.gotoAndStop(_ID)
			_WallMc.wallmove.gotoAndPlay(2)
			_WallMc.wallmove2.gotoAndPlay(2)	
				
			_WallMc.wallmove.pic.pic.gotoAndStop(_ID+1)
			_WallMc.wallmove2.pic.pic.gotoAndStop(_ID+1)	
			_WallMc.wallmove2.pic.pic.visible=true
			_WallMc.wallmove2.pic.pickuang.visible=true
				
			_WallMc.y=392
			_WallMc.z=20
			tween=TweenLite.to(_WallMc, 6, {z: -660, y:415 ,ease: Cubic.easeIn,delay:2, onComplete: MoveEnd});

		}

		public function stopTween():void
		{
			tween.pause()
		}

		public function playTween():void
		{
			if(Data.gameIn=="GAME"){
			tween.resume()
			}
		}

		private function MoveEnd():void
		{
			if (Data.user)
			{
				if(_WallMc.wallmove.Manhit.width<200 || _WallMc.wallmove.Manhit.height<300)
				{
					Data.life--
					dispatchEvent(new Event("GameLose", true))
					Data.oneScore=0
					Data.ScoreList.push(0)
				
				}else{
				
				
				
				if (HitCheckMc(_WallMc.wallmove.wallhit, _WallMc.wallmove.Manhit))
				{
					if (HitCheckMc(_WallMc.wallmove.wallhit2, _WallMc.wallmove.Manhit))
					{
						    Data.life--
							dispatchEvent(new Event("GameLose", true))
							Data.oneScore=0
							Data.ScoreList[_ID-1]=0
						
							//_WallMc.wallmove.Manhit.transform.colorTransform=new ColorTransform(0x00CC33); 
					}
					else
					{
						Data.oneScore=2000 + Math.floor(Math.random() * 1000)
						dispatchEvent(new Event("GameGeneral", true))
						Data.ScoreList[_ID-1]=1
						_ID++
							Data.level++
							//_WallMc.wallmove.Manhit.transform.colorTransform=new ColorTransform(0x00CC33); 
					}
				}
				else
				{
					Data.ScoreList[_ID-1]=1
					Data.oneScore=3000 + Math.floor(Math.random() * 1000)
					dispatchEvent(new Event("GameWin", true))
					_ID++
						Data.level++
						//_WallMc.wallmove.Manhit.transform.colorTransform=new ColorTransform(0xFF0000);  
				}
				
				
				
				}
				Data.Score+=Data.oneScore
			}
//			dispatchEvent(new Event("wallMovEnd", true))


		}

		public function HitCheckMc(mc1:MovieClip, mc2:MovieClip):Boolean
		{

			var _bool:Boolean=false
			//先清空bitmapData中的数据，准备一个完全透明的黑"底板"。
			bmpd1.fillRect(bmpd1.rect, 0);
			bmpd2.fillRect(bmpd2.rect, 0);
			bmpd1.draw(mc1, new Matrix(1, 0, 0, 1, mc1.x, mc1.y));
			bmpd2.draw(mc2, new Matrix(1, 0, 0, 1, mc2.x, mc2.y));
//			addChild(new Bitmap(bmpd1))
//			addChild(new Bitmap(bmpd2))
			if (bmpd1.hitTest(new Point(), 255, bmpd2, new Point(), 255))
			{
				trace("碰撞")
				_bool=true
			}
			else
			{
				trace("通过")
			}
			return _bool
		}
	}
}
