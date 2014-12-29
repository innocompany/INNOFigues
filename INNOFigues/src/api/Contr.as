package api
{
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	    import flash.display.Sprite;
	    import flash.display.StageAlign;
	    import flash.display.StageScaleMode;
	    import flash.events.MouseEvent;
	    import flash.filters.GlowFilter;
	    import flash.geom.Matrix;
	    import flash.geom.Point;

	public class Contr
	{
		        private static var bmpd1:BitmapData;
		        private static var bmpd2:BitmapData;
	
		public function Contr() 
		{
		}

		public static function Removewhite(mc:MovieClip):BitmapData {
		
			var _bit:BitmapData
			return _bit
		}
		public static function HitCheckMc(mc1:MovieClip, mc2:MovieClip):Boolean
		{
			
			var _bool:Boolean=false
			//先清空bitmapData中的数据，准备一个完全透明的黑"底板"。
			trace(mc1.x, mc1.y, mc2.x, mc2.y)
			
			bmpd1.fillRect(bmpd1.rect, 0);
			bmpd2.fillRect(bmpd2.rect, 0);
			bmpd1.draw(mc1, new Matrix(1, 0, 0, 1, 0, 0));
			bmpd2.draw(mc2, new Matrix(1, 0, 0, 1, mc2.x, mc2.y));

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