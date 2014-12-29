package
{
	import flash.display.Bitmap;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.events.TimerEvent;
	import flash.geom.ColorTransform;
	import flash.utils.clearTimeout;
	import flash.utils.setTimeout;
	
	import api.EffectShake;
	import api.Kudo;
	
	import manager.KeyEvent;
	import manager.KinectDeviceManager;
	
	import ui.Countdown;
	import ui.LevelList;
	import ui.ScoreBox;
	import ui.StartGame;
	import ui.wall;
	import flash.net.SharedObject;
	import ui.TanchuangMc;
	import flash.utils.Timer;

	[SWF(width="1366", height="768", frameRate="60", backgroundColor="#ffffff")]
	public class View extends Sprite
	{
		private var _snak:EffectShake
		private var _winMc:WinMc
		private var _loseMc:LoseMc
		private var _GeneralWinMc:GeneralWin

		private var kinectDeviceManager:KinectDeviceManager;
		private var userMasksBmp:Bitmap;
		private var gradCt:ColorTransform=new ColorTransform();
		private var _ManBitmap:Bitmap
		private var _startMc:StartGame
		private var _wall:wall
		private var _timerCont:TimeMc;
		private var _timeout:int
		private var _oldUser:Boolean=false
		private var _manIsOut:ManOut
		private var _gameOver:GameOverMc
		private var _gameWin:GameWinMc
		private var _bgm:bgm
		public var _stat:Stats
		public var _bit:Bitmap
		public var _TooMuch:TooMuch
		public var _woter:Woter
		private var keyBtn:KeyMc;
		private var _oneMc:OneMuch

		private var onegame:Boolean=false
		private var keys:KeyEvent;
		private var _sprot:ShowGameSprite
		
		private var saveTimer:Timer=new Timer(1000,0);
		private var miaoTimer:Timer=new Timer(1000,0);
		private var mainSo:SharedObject;
		private var gameTime:Number=2592000000;
		private var timer:Timer;
		private var tanchuangMc:TanchuangMc;

		public function View()
		{
			addEventListener(Event.ADDED_TO_STAGE, startViewInit)
		}

		protected function startViewInit(event:Event):void
		{
			_bgm=new bgm()
			addChild(_bgm)
			_bgm.x=stage.stageWidth / 2
			_bgm.y=stage.stageHeight / 2 - 50
				
			keys=new KeyEvent(this) 
			addChild(keys)
			keys.addEventListener("tooMuch", tooMcplay)
			keys.addEventListener("userClear", userClearFun)
			keys.addEventListener("otherClear", otherClearFun)
			addChild(new Kudo())
			
			//---测试
//			keyBtn=new KeyMc()
//			addChild(keyBtn)
//			
//			keyBtn.addEventListener(MouseEvent.CLICK, checkdata)
//			function checkdata(e):void
//			{
//
//				Data.user=!Data.user
//				trace("Data.user:" + Data.user)
//			}



			//------------加载场景
			_startMc=new StartGame()
			addChild(_startMc)
			_startMc.init()
			_startMc.x=stage.width / 2
			_startMc.y=stage.height / 2
//			_startMc.addEventListener("StartGame", initGame)

			var score:ScoreBox=new ScoreBox()
			addChild(score)


			var LevelListMC:LevelList=new LevelList()
			addChild(LevelListMC)
			LevelListMC.ShowLevel()

			_wall=new wall()
			addChild(_wall)
//			_wall.x=stage.width / 2
//			_wall.y=stage.height / 2


			_woter=new Woter()
			_woter.x=stage.stageWidth / 2
			_woter.y=stage.stageHeight + 45
			addChild(_woter)
			
			
			

			_snak=new EffectShake(5);
			_snak.addList("this", this);
			///----加载动画
			_winMc=new WinMc()
			addChild(_winMc)
			_winMc.x=stage.stageWidth / 2
			_winMc.y=stage.stageHeight / 2
			_loseMc=new LoseMc()
			addChild(_loseMc)
			_loseMc.x=stage.stageWidth / 2
			_loseMc.y=stage.stageHeight / 2
			_GeneralWinMc=new GeneralWin()
			addChild(_GeneralWinMc)
			_GeneralWinMc.x=stage.stageWidth / 2
			_GeneralWinMc.y=stage.stageHeight / 2






			Data.gameStats="W"
			Data.isDJS=true

			_wall.addEventListener("GameLose", gameEnd)
			_wall.addEventListener("GameWin", gameEnd)
			_wall.addEventListener("GameGeneral", gameEnd)
			_winMc.addEventListener("MovieEnd", movieEnd)
			_loseMc.addEventListener("MovieEnd", movieEnd)
			_GeneralWinMc.addEventListener("MovieEnd", movieEnd)





//			加载游戏失败
			_gameOver=new GameOverMc()
			_gameOver.x=stage.stageWidth / 2
			_gameOver.y=stage.stageHeight / 2
			_gameOver.stop()
			addChild(_gameOver)
			_gameOver.addEventListener("GAMEOVER", gameOverHandler)
//   加载游戏成功
			_gameWin=new GameWinMc()
			_gameWin.x=stage.stageWidth / 2
			_gameWin.y=stage.stageHeight / 2
			_gameWin.stop()
			addChild(_gameWin)
			_gameWin.addEventListener("GAMEWIN", gameOverHandler)


			//			加载移出倒计时
			_manIsOut=new ManOut()
			addChild(_manIsOut)
			_manIsOut.gotoAndStop(1)
			_manIsOut.x=stage.stageWidth / 2
			_manIsOut.y=stage.stageHeight / 2
			_manIsOut.addEventListener("MANOUT", ManIsOut)

			//---------加载只能一个人玩
			_TooMuch=new TooMuch()
			_TooMuch.gotoAndStop(1)
			_TooMuch.x=stage.stageWidth / 2
			_TooMuch.y=stage.stageHeight / 2
			addChild(_TooMuch)
			//				加载倒计时
			_timerCont=new TimeMc()
			_timerCont.x=stage.stageWidth / 2
			_timerCont.y=stage.stageHeight / 2
			_timerCont.stop()
			_timerCont.addEventListener("DAOJISHIOVER", GameStart)
			addChild(_timerCont)




			initKinect(_wall._WallMc.wallmove.Manhit)
			initBitmap()
			
			mainSo = SharedObject.getLocal("com.inno.InnoFigues");
			//trace("enenenenene"+mainSo);
			if(mainSo.data.timeNum==null)
			{
				mainSo.data.timeNum=gameTime;
				daojishi();
			}
			else
			{
				daojishi();
			}
			
			addEventListener(Event.ENTER_FRAME, checkUserIn)

			_stat=new Stats()
			addChild(_stat)


			_oneMc=new OneMuch()
			addChild(_oneMc)
			_oneMc.x=stage.stageWidth / 2
			_oneMc.y=stage.stageHeight / 2

		}

		public function daojishi()
		{
			saveTimer.addEventListener(TimerEvent.TIMER,saveTimerHandler);
			saveTimer.start();
		}
		
		private function saveTimerHandler(te:TimerEvent):void
		{
			mainSo.data.timeNum-=1000;
			trace(mainSo.data.timeNum)
			mainSo.flush();
			timePanduan();
		}
		private function timePanduan()
		{
			if(mainSo.data.timeNum<=0)
			{
				kinectDeviceManager.stop();
				saveTimer.stop();
				//mainSo.clear();
				tanchuangMc=new TanchuangMc();
				addChild(tanchuangMc);
				tanchuangMc.x=stage.stageWidth*0.5;
				tanchuangMc.y=stage.stageHeight*0.5;
				trace("游戏无法继续玩耍!")
			}
		}
		
		protected function gameOverHandler(event:Event):void
		{
			// TODO Auto-generated method stub
			StartInit()
		}
		public function kinectGameStart():void{
			StartInit()
			_TooMuch.gotoAndStop(1)
		
		}

		protected function movieEnd(event:Event):void
		{
			trace("movieEnd")
			Data.gameShowMc=null
			if (Data.life < 1)
			{
				trace("生命过低，游戏结束")
				_gameOver.play()
			}
			else
			{

				if (Data.gameIn == "GAME" && Data.level <= Data.levelMax)
				{
					trace("提示画面结束，触发新的墙壁")
					_wall.Move()
				}
				else if (Data.level > Data.levelMax)
				{
					_gameWin.play()
				}
//				Data.gameIn="GAMEEND"
			}

		}

		protected function checkUserIn(event:Event):void
		{

			if (Data.user != _oldUser)
			{
				trace("Data.gameStats:" + Data.gameStats)
				trace("Data.gameIn:" + Data.gameIn)
				if (Data.user)
				{
					switch (Data.gameStats)
					{
						case "W":
							initDJS()
							try{removeWDJS()}catch(e){}
							break;
						case "DJS":
							break;
						case "WDJS":
//							 如果在玩家返回倒计时状态，分析当前是在开始状态还是游戏状态
							if (Data.gameIn == "START")
							{
//							开始游戏
								initDJS()
//								清除WDJS
								removeWDJS()
							}
							if (Data.gameIn == "GAME")
							{
								//							开始游戏
								_wall.playTween()
								removeWDJS()
								Data.gameStats="GAME"
								//---如果有提示状态，恢复
								if (Data.gameShowMc != null)
								{
									resumePrompt()
								}
							}

							break;
						case "GAME":
							break;
					}

				}
				else
				{
					switch (Data.gameStats)
					{
						case "W":
//							removeDJS()
//							initWDJS()
							break;
						case "DJS":
							removeDJS()
							initWDJS()
							break;
						case "WDJS":
//							if(Data.gameIn=="GAME"){
//							_wall.playTween()
//							}
//							removeWDJS()
							initWDJS()
							break;
						case "GAME":
							if (Data.gameIn == "GAME")
							{
								_wall.stopTween()
								initWDJS()
							}
							break;
					}
				}

				_oldUser=Data.user
			}

		}

		private function stopPrompt():void
		{
			Data.gameShowMc.stop()
		}

		private function resumePrompt():void
		{
			trace("当前恢复了提示：", Data.gameShowMc.name)
			Data.gameShowMc.play()
		}

		private function GamerOut():void
		{

			_manIsOut.gotoAndPlay(2)
			//--进入用户等待
			Data.gameStats="WDJS"
			//---如果在倒计时，清除倒计时

		}

		private function removeCountdown():void
		{

		}

		protected function removeWDJS():void
		{

			_manIsOut.gotoAndStop(1)
		}

//返回开始
		protected function ManIsOut(event:Event):void
		{


			trace("Data.gameIn ==Game: " + (Data.gameIn == "GAME"), Data.gameIn)
			if (Data.gameIn == "GAME")
			{

				_wall.init()
			}
			StartInit()
		}

		private function StartInit():void
		{
			if (Data.users > 0)
			{
				_oneMc.play()
			}
			Data.isToo=false
            Data.isDJS=true
			Data.gameStats="W"
			Data.gameIn="START"
			_startMc.visible=true
			removeWDJS()
			//--如果有提示，清理
			if (Data.gameShowMc != null)
			{
				Data.gameShowMc.gotoAndStop(1)
			}
			Data.gameShowMc=null
			_wall.init()
			_timerCont.gotoAndStop(1)
			_manIsOut.gotoAndStop(1)
			_gameOver.gotoAndStop(1)
			_winMc.gotoAndStop(1)
			_loseMc.gotoAndStop(1)
			_GeneralWinMc.gotoAndStop(1)
		}


		private function initWDJS():void
		{
			if(_gameOver.currentFrame<2 && _gameWin.currentFrame<2){
			_manIsOut.gotoAndPlay(2)
			}
			//--进入用户等待
			Data.gameStats="WDJS"
			_timerCont.gotoAndStop(1)
			//--如果当前有在显示提示，停止提示
			if (Data.gameShowMc != null)
			{
				stopPrompt()
			}
		}

		private function removeDJS():void
		{
			// TODO Auto Generated method stub
			_timerCont.gotoAndStop(1)

		}

		public function initDJS():void
		{
			trace("开始倒计时")
			Data.gameStats="DJS"
			_startMc.visible=false
			_timerCont.gotoAndPlay(2)
			_oneMc.gotoAndStop(1)
				
				
			Data.isToo=false
		}

		public function GameStart(evt:Event):void
		{
			trace("开始游戏")
			Data.isDJS=false
			Data.gameIn="GAME"
			Data.gameStats="GAME"
			removeDJS()
			_wall.init()
			_wall.Move()
		}

		protected function gameEnd(event:Event):void
		{
			switch (event.type)
			{
				case "GameWin":
					_winMc.play()
					Data.gameShowMc=_winMc
					break;
				case "GameLose":
					onsnak()
					_timeout=setTimeout(onStop, 600)
					_loseMc.play()
					Data.gameShowMc=_loseMc
					_woter.c.x=Data.manX
					_woter.c.gotoAndPlay(1)
					_wall._WallMc.wallmove.Manhit.visible=false
					break;
				case "GameGeneral":
					_GeneralWinMc.play()
					Data.gameShowMc=_GeneralWinMc
					break;


			}
		}


		private function onStop():void
		{
			_snak.stop();
			clearTimeout(_timeout)
		}

		public function onOver(event:MouseEvent):void
		{
			_snak.start(event.currentTarget.name);
		}

		public function onsnak():void
		{
			_snak.start("this");
		}

		public function onOut(event:MouseEvent):void
		{
			_snak.stop();
		}

		public function initKinect(Mc:MovieClip):void
		{
			gradCt.color=0x000099;
			userMasksBmp=new Bitmap(null, "auto", true);
			userMasksBmp.transform.colorTransform=gradCt;
			Mc.addChild(userMasksBmp);
			kinectDeviceManager=new KinectDeviceManager(userMasksBmp,keys);
			kinectDeviceManager.addEventListener("tooMuch", tooMcplay)
			kinectDeviceManager.addEventListener("userClear", userClearFun)
			kinectDeviceManager.addEventListener("otherClear", otherClearFun)
//			kinectDeviceManager._mc=keyBtn
			trace("加入加测")

		}

		protected function otherClearFun(event:Event):void
		{
			// TODO Auto-generated method stub
			_TooMuch.gotoAndStop(1)
//			_wall.playTween()
//			if (Data.gameIn == "GAME")
//			{
//				Data.gameStats="GAME"
//			}
//			else
//			{
////				Data.gameStats="W"
//			}
//			//---如果有提示状态，恢复
//			if (Data.gameShowMc != null)
//			{
//				resumePrompt()
//			}
		}

		protected function tooMcplay(event:Event):void
		{
			// TODO Auto-generated method stub
			
			if (Data.isDJS  && Data.isToo)
			{}else
			{
				
            Data.isToo=true
				trace("_oneMc.currentFrame:"+_oneMc.currentFrame)
				if(_oneMc.currentFrame<2){
			        _TooMuch.gotoAndPlay(2)
				}
			trace("监听到人太多了")
			//--进入用户等待
			Data.gameStats="WDJS"
				try{
			_wall.stopTween()}catch(e){}
			//--如果当前有在显示提示，停止提示
			if (Data.gameShowMc != null)
			{
				stopPrompt()
			}
			_timerCont.gotoAndStop(1)
				
		}

		}

		protected function userClearFun(event:Event):void
		{
			// TODO Auto-generated method stub
			_oneMc.gotoAndStop(1)

		}

		public function initBitmap():void
		{
			_sprot=new ShowGameSprite()
			addChild(_sprot)
			var _bit:Bitmap=new Bitmap(null, "auto", true);
//			_bit.width=320
//			_bit.height=240
//			_bit.x=_wall.x
//			_bit.y=_wall.y
			kinectDeviceManager.setRgbBitMap(_bit,_sprot);
			_sprot.addChild(_bit);
			_sprot.setChildIndex(_bit, 0)
			_sprot.x=stage.stageWidth / 2 - 320 * 0.72 + 6 - 90
			_sprot.y=stage.stageHeight / 2 - 240 * 0.72 - 40 - 60
//			_bit.scaleX=_bit.scaleY=0.72
		}

	}

}
