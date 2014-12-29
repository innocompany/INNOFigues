package {
    import flash.display.BitmapData;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    import flash.events.MouseEvent;
    import flash.filters.GlowFilter;
    import flash.geom.Matrix;
    import flash.geom.Point;
    public class BitmapCollision extends Sprite {
        private var bmpd1:BitmapData;
        private var bmpd2:BitmapData;
        private var star1:wallbgm;
        private var star2:Star;
        public function BitmapCollision() {
            stage.align=StageAlign.TOP_LEFT;
            stage.scaleMode=StageScaleMode.NO_SCALE;            
            star1=new wallbgm();
           // addChild(star1);
            star2=new Star();
            star2.x=200;
            star2.y=200;
            //addChild(star2);            
            bmpd1=new BitmapData(stage.stageWidth,stage.stageHeight,true,0);
            bmpd2=bmpd1.clone();
            stage.addEventListener(MouseEvent.MOUSE_MOVE, onMouseMoving);
            //注：这里bmpd1,bmpd2都没被转成bitmap，更没有加入到舞台中.
        }
        private function onMouseMoving(event:MouseEvent):void {
             
            star2.x=mouseX;
            star2.y=mouseY;
            //先清空bitmapData中的数据，准备一个完全透明的黑"底板"。
            bmpd1.fillRect(bmpd1.rect, 0);
            bmpd2.fillRect(bmpd2.rect, 0);
            //再把要检测的(movieclip或sprite)对象，画到里面.
            bmpd1.draw(star1, new Matrix(1, 0, 0, 1, star1.x, star1.y));
            bmpd2.draw(star2, new Matrix(1, 0, 0, 1, star2.x, star2.y));
            //碰撞检测
            //注意：因为bmpd1,bmpd2都没被加入到舞台上，所以默认都在同样的0坐标位置，因此下面的坐标，直接用默认的Point对象实例即可.
            if (bmpd1.hitTest(new Point(), 255, bmpd2, new Point(), 255)) {
                star1.filters = [new GlowFilter()];
                star2.filters = [new GlowFilter()];
            } else {
                star1.filters=[];
                star2.filters=[];
            }
        }
    }
}