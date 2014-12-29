package manager
{

	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;

	public class KeyEvent extends Sprite
	{
		private var _view:Object
		private var _mouseState:Boolean=true;

		public function KeyEvent(evt:Object)
		{
			_view=evt
			_view.stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE
			_view.stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
		}

		/**
		 *  Esc        27
		 PageUp     33
		 F5         116
		 PageDown   34
		 b          66

		 Vol+       175
		 Vol-       174
		 *  1.  F5 - 重新获取默认图片（用来找像素不同的区域）
		 2.  pageUp - 阈值（Threshold）拖动条往左移动一个单位（对不同更敏感）
		 3.  pageDown - 阈值（Threshold）拖动条往右移动一个单位（对不同更迟钝）
		 4. b - 切换全屏 默认为带键盘输入的全屏
		 5. Vol+ - 切换鼠标显示/隐藏 初始值为隐藏
		 熊拖泥 23:35:46
		 6. Vol- - 切换debug模式（带有摄像头画面和设置界面）
		 * @param e
		 *
		 */
		protected function __onKeyDown(e:KeyboardEvent):void
		{
			// TODO Auto-generated method stub
			trace(e.keyCode)
			if (e.keyCode == Keyboard.PAGE_DOWN)
			{

			}
			else if (e.keyCode == Keyboard.PAGE_UP)
			{

			}
			else if (e.keyCode == Keyboard.B )
			{
				_view.stage.displayState=stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE ? StageDisplayState.NORMAL : StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			else if (e.keyCode == 175) //+
			{
				_mouseState=_mouseState == true ? false : true;
				_mouseState == true ? Mouse.show() : Mouse.hide();
			}
			else if (e.keyCode == Keyboard.PAGE_DOWN) //-
			{
				_view._stat.visible=!_view._stat.visible
				_view._bit.visible=!_view._bit.visible

			}

			else if (e.keyCode == Keyboard.F5)
			{

			}
			
			else if (e.keyCode == 85)
			{
				Data.user=!Data.user
			}
			else if (e.keyCode == 190)
			{
				
				Data.users++
				checkin()
			}
			else if (e.keyCode == 188)
			{
				Data.users--
				checkin()
			}
			 if (e.keyCode == Keyboard.S )
			{
				//				trace("ssss")
				_view.kinectGameStart()
			}
			 if( e.keyCode==33){
				trace("ssss")
				_view.kinectGameStart()
			}
			
		}
		
		
		public function checkin():void{
			trace("Data.user:"+Data.user)
			if(Data.users<0){
			Data.users=0
			}
			if (Data.users > 0)
			{
				Data.user=true;
			}else{
				Data.user=false
			}
			//		trace(currentUserIdUint);
			if (Data.users > 1)
			{
				//				trace("人太多了")
				dispatchEvent(new Event("tooMuch", true))
			}
			if (Data.users < 1)
			{
				dispatchEvent(new Event("otherClear", true))
				dispatchEvent(new Event("userClear", true))
				Data.user=false
				//				Data.user=false
			}
			
			
			
			
			
		}
	}

}
