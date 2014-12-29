package
{
	import flash.display.MovieClip;

	public class Data
	{

		public static var kudoList:Array=[]  //奖池
		public static var KudoId:int=-1//奖ID
		public static var KudoShow:Boolean=true//是否提供奖品机制
		public static var Score:int=0
		public static var oneScore:int=0
		public static var ScoreList:Array=[]
		public static var level:int=0
		public static var user:Boolean=false
		public static var life:int=3
		public static var levelMax:int=8
		public static var userWeit:Boolean=false //当前是否用户等待
		public static var gameStats:String="W" ///  "W" "DJS" "GAME" "WDJS"  当前状态
		public static var gameIn:String="START" //当前是在等待还是在游戏状态
		public static var gameShowMc:MovieClip=null //当前正在触发的提示画面
		public static var manX:Number=0
		public static var users:int=0
		public static var isDJS:Boolean=true//临时加入，用来记录倒计时.
		public static var isToo:Boolean=false//临时加入，用来记录双人恢复
		public function Data()
		{

		}

		public function init():void
		{

		}
	}
}
