package manager
{
	import com.as3nui.nativeExtensions.air.kinect.Kinect;
	import com.as3nui.nativeExtensions.air.kinect.KinectSettings;
	import com.as3nui.nativeExtensions.air.kinect.constants.CameraResolution;
	import com.as3nui.nativeExtensions.air.kinect.data.User;
	import com.as3nui.nativeExtensions.air.kinect.events.CameraImageEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.DeviceEvent;
	import com.as3nui.nativeExtensions.air.kinect.events.UserEvent;

	import flash.display.Bitmap;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.geom.Point;

	public class KinectDeviceManager extends Sprite
	{

		private static const TOP_LEFT:Point=new Point(0, 0);

		private var device:Kinect;
		private var userMasksBmp:Bitmap;
		private var currentUserIdUint:uint;
		private var _rgbBitMap:Bitmap

		private var userPositionPoint:Point;
		public var _mc:Object;
		private var _keys:Object
		private var _sprot:Object
		private var IDS:int=0
		private var oldIDS:int=0

		public function KinectDeviceManager(userMasksBmp:Bitmap, key:Object):void
		{
			_keys=key
			this.userMasksBmp=userMasksBmp;
			startDemoImplementation();
			addEventListener(Event.ENTER_FRAME, checkUsersEvent)
		}



		public function setRgbBitMap(evt:Bitmap, _spr:Object):void
		{
			_rgbBitMap=evt
			_sprot=_spr
		}

		protected function startDemoImplementation():void
		{
			trace("[UserMaskDemo] Start Demo");
			if (Kinect.isSupported())
			{
				trace("[UserMaskDemo] Start Kinect");

				device=Kinect.getDevice();

				device.addEventListener(DeviceEvent.STARTED, kinectStartedHandler, false, 0, true);
				device.addEventListener(DeviceEvent.STOPPED, kinectStoppedHandler, false, 0, true);
				device.addEventListener(UserEvent.USERS_ADDED, usersAddedHandler, false, 0, true);
				device.addEventListener(UserEvent.USERS_REMOVED, usersRemovedHandler, false, 0, true);

				device.addEventListener(UserEvent.USERS_MASK_IMAGE_UPDATE, usersMaskImageUpdateHandler, false, 0, true);
				device.addEventListener(CameraImageEvent.RGB_IMAGE_UPDATE, rgbImageUpdateHandler, false, 0, true);

				var settings:KinectSettings=new KinectSettings();
				settings.userMaskEnabled=true;
				settings.userMaskMirrored=true;
				settings.userMaskResolution=CameraResolution.RESOLUTION_640_480;
				settings.rgbEnabled=true;
				settings.rgbResolution=CameraResolution.RESOLUTION_640_480;
				device.start(settings);
			}
		}

		protected function usersAddedHandler(event:UserEvent):void
		{
//			Data.users=device.users.length
			if (currentUserIdUint == 0)
			{
				currentUserIdUint=event.users[0].userID;

			}
//			trace("有人进入："+device.users.length)
//			if (device.users.length > 0)
//			{
//				Data.user=true;
//			}
////		trace(currentUserIdUint);
//			if (device.users.length > 1)
//			{
////				trace("人太多了")
//				dispatchEvent(new Event("tooMuch", true))
//			}
//			checkUsers()

//			_keys.checkin()
		}

		protected function rgbImageUpdateHandler(event:CameraImageEvent):void
		{
//			
//			if (Data.gameIn == "START" && device.users.length<1)
//			{
//				_rgbBitMap.visible=true
//				_rgbBitMap.bitmapData=event.imageData;
//			}
//			
//			for each (var user:User in event.users)
//			{
//				
//				if (user.userID == currentUserIdUint)
//				{
//					currentUserIdUint=0;
////					user.head.position.depthRelative.length
//				}
//			}
//			checkUsers()

			if (Data.users > 0)
			{
				_sprot.visible=false
					//	Data.Score=Math.floor(device.users[0].head.position.world.z*1000)
					//trace(device.users[0].head.position.depthRelative.length)
			}
			if (Data.gameStats == "W" && Data.users < 1)
			{
				_sprot.visible=true
				_rgbBitMap.bitmapData=event.imageData;
			}
			if (Data.isDJS && Data.users < 1 && Data.isToo)
			{
				_sprot.visible=true
				_rgbBitMap.bitmapData=event.imageData;
			}


		}

		protected function checkUsersEvent(event:Event):void
		{
			checkUsers()
		}

		private function checkUsers():void
		{
			var IDS=0
			if (device)
			{
				for (var i:int=0; i < device.users.length; i++)
				{
					var checkLong=Math.floor(device.users[i].position.world.z);
					trace(i);
					trace("checkLong:" + checkLong);
					if (checkLong < 2200)
					{
						
						trace("IDS",IDS);
						IDS++
					}
					trace("");
				}
			}
			Data.users=IDS

			//---对比数据派发事件。

			if (oldIDS != IDS)
			{
				_keys.checkin()
				oldIDS=IDS
			}
//			trace("IDS:"+IDS)
		}


		protected function usersRemovedHandler(event:UserEvent):void
		{
//			checkUsers()

//			_keys.checkin()
//			if (device.users.length < 1)
//			{
//				dispatchEvent(new Event("otherClear", true))
//				dispatchEvent(new Event("userClear", true))
////				Data.user=false
//			}
			for each (var user:User in event.users)
			{

				if (user.userID == currentUserIdUint)
				{
					currentUserIdUint=0;
				}
			}
		}

		protected function kinectStartedHandler(event:DeviceEvent):void
		{
			trace("[UserMaskDemo] Kinect Started");
		}

		protected function kinectStoppedHandler(event:DeviceEvent):void
		{
			trace("[UserMaskDemo] Kinect Stopped");
		}

		protected function usersMaskImageUpdateHandler(event:UserEvent):void
		{
			for each (var user:User in event.users)
			{
				//trace(user.userID);,
				if (user.userID == currentUserIdUint)
				{
					userMasksBmp.bitmapData=user.userMaskData;
					userPositionPoint=user.position.depthRelative;
					Data.manX=userPositionPoint.x * 640 + 380 - 1366 / 2
//					_mc.y=userPositionPoint.y*480
				}
			}

		}

		protected function stopDemoImplementation():void
		{
			trace("Stop Demo");
			if (device != null)
			{
				currentUserIdUint=0;
				device.removeEventListener(DeviceEvent.STARTED, kinectStartedHandler);
				device.removeEventListener(DeviceEvent.STOPPED, kinectStoppedHandler);
				device.removeEventListener(UserEvent.USERS_MASK_IMAGE_UPDATE, usersMaskImageUpdateHandler);
				device.stop();
			}
		}
		public function stop():void
		{
			stopDemoImplementation();
		}
	}
}
