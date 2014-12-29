package
{

	import flash.display.Sprite;
	import flash.display.StageDisplayState;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.ui.Mouse;

	[SWF(width="1366", height="768", frameRate="60", backgroundColor="#ffffff")]
	public class INNOFigues extends Sprite
	{
		private var _view:View
		private var _mouseState:Boolean=true;

		public function INNOFigues()
		{
			_view=new View()
			addChild(_view)
			stage.displayState=StageDisplayState.FULL_SCREEN_INTERACTIVE
			stage.addEventListener(KeyboardEvent.KEY_DOWN, __onKeyDown);
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
			if (e.keyCode == Keyboard.PAGE_DOWN)
			{

			}
			else if (e.keyCode == Keyboard.PAGE_UP)
			{

			}
			else if (e.keyCode == Keyboard.B)
			{
				stage.displayState=stage.displayState == StageDisplayState.FULL_SCREEN_INTERACTIVE ? StageDisplayState.NORMAL : StageDisplayState.FULL_SCREEN_INTERACTIVE;
			}
			else if (e.keyCode == 175) //+
			{
				_mouseState=_mouseState == true ? false : true;
				_mouseState == true ? Mouse.show() : Mouse.hide();
			}
			else if (e.keyCode == 174 || e.keyCode == 85) //-
			{

			}

			else if (e.keyCode == Keyboard.F5)
			{

			}
		}
	}

}
