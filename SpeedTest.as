package {
	
	import flash.display.*;
	import data.*;
	import flash.filters.*;
	import flash.utils.*;
	import flash.net.*;
	import flash.events.*;

	public class SpeedTest	extends Sprite{
	
public var speed:text;
public var status:text;
public var loader:Loader;
public var timer:Timer;
public var start_timer_over:Timer;
public var start_timer_out:Timer;
public var timerVal:int;
public var myShadow:DropShadowFilter;
public var start_banner:Sprite;
public var x_value:int;
public var start_sprite:Sprite;
public var start_text:text;	

		public function SpeedTest() {
			
			myShadow = new DropShadowFilter();
				myShadow.blurX = 5;
				myShadow.blurY = 5;
				myShadow.quality = 10;
				//myShadow.inner = true;
				
			var up_banner:Sprite = new Sprite();
			up_banner.graphics.beginFill(0xFFFFFF,1);
			up_banner.graphics.lineStyle(1);
			up_banner.graphics.drawRoundRect(0, 0, 310, 45, 20);
			up_banner.x = 20;
			up_banner.y = 25;
			up_banner.filters = [myShadow];
				addChild(up_banner);
				
				var up_banner_text:text = new text(70, 11, "ПРОКАЧАЙ СВОЙ ИНТЕРНЕТ", "2");
					up_banner.addChild(up_banner_text);
				
			start_banner = new Sprite();
			start_banner.graphics.beginFill(0xFFFFFF,1);
			start_banner.graphics.lineStyle(1);
			start_banner.graphics.drawRoundRect(110, 95, 135, 35, 14);
			start_banner.filters = [myShadow];
			//start_banner.addEventListener(MouseEvent.CLICK, startEvent);
				addChild(start_banner);
				
				start_text = new text(115, 100, "ЗАПУСК ПРОКАЧКИ", "1");
				//start.addEventListener(MouseEvent.CLICK, startEvent);
					addChild(start_text);
						
			start_sprite = new Sprite();
			start_sprite.graphics.beginFill(0x000000,0);
			//start_sprite.graphics.lineStyle(1);
			start_sprite.graphics.drawRoundRect(110, 95, 135, 35, 14);
			//start_sprite.filters = [myShadow];
			start_sprite.addEventListener(MouseEvent.CLICK, startEvent);
			start_sprite.addEventListener(MouseEvent.MOUSE_OVER, startOver);
			start_sprite.addEventListener(MouseEvent.MOUSE_OUT, startOut);
				addChild(start_sprite);
				
			speed = new text(300, 150, "0 Kbit", "1");
			addChild(speed);
			
			status = new text(100, 150, "--", "1");
			addChild(status);
			
			timer = new Timer(95, 0);
			timer.addEventListener(TimerEvent.TIMER, eTimerEvent);
			
			start_timer_over = new Timer(10, 0);
			start_timer_over.addEventListener(TimerEvent.TIMER, startTimerOverEvent);
			
			start_timer_out = new Timer(10, 0);
			start_timer_out.addEventListener(TimerEvent.TIMER, startTimerOutEvent);
		}
		
		public function startEvent(e:MouseEvent):void {
			start_sprite.removeEventListener(MouseEvent.CLICK, startEvent);
			start_text.setText("ПРОКАЧИВАНИЕ...");
			
			var time:Date = new Date();
			
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);	
			loader.load(new URLRequest("http://high.dih.ru/speedtest?" + time));
			//loader.load(new URLRequest("http://89.104.118.112/ati.run"));
			timer.start();
			timerVal = 0;
		}
		
		public function progressHandler(e:ProgressEvent):void {
			var loaded:uint = e.bytesLoaded;
			var total:uint = e.bytesTotal;
			
			if (loaded == total) {
				//loadedFiles += total;
				timer.stop();
				speed.setText("Скорость: " + String(Math.round((total/timerVal)*0.08))+" Кбит/c");
				start_sprite.addEventListener(MouseEvent.CLICK, startEvent);
				start_text.setText("ЗАПУСК ПРОКАЧКИ");
			}
			 
			
			var PersentLoaded:Number = Math.round((loaded/total)*100); 
			
			status.setText("Загрузка " + PersentLoaded + "% ");
			status.setText("Загрузка " + PersentLoaded + "% " + total + " " + timerVal);
		}
		
		public function eTimerEvent(e:TimerEvent):void {
			timerVal++;
			
		}
		
		public function startOver(e:MouseEvent):void {
			start_timer_over.start();
			start_timer_out.stop();
		}
		
		public function startOut(e:MouseEvent):void {
			start_timer_over.stop();
			start_timer_out.start();
		}
		
		public function startTimerOverEvent(e:TimerEvent):void {
			x_value += 10;
			
			removeChild(start_banner);
			start_banner = new Sprite();
			start_banner.graphics.beginFill(0xFFFFFF,1);
			start_banner.graphics.lineStyle(1);
			start_banner.graphics.drawRoundRect(110-x_value, 95, 135+x_value*2, 35, 14);
			start_banner.filters = [myShadow];
			addChildAt(start_banner, 1);
			//start_banner.width =+ 10;
			if (x_value > 50)
				start_timer_over.stop();
			
		}
		public function startTimerOutEvent(e:TimerEvent):void {
			x_value -=10;
			
			removeChild(start_banner);
			start_banner = new Sprite();
			start_banner.graphics.beginFill(0xFFFFFF,1);
			start_banner.graphics.lineStyle(1);
			start_banner.graphics.drawRoundRect(110-x_value, 95, 135+x_value*2, 35, 14);
			start_banner.filters = [myShadow];
			addChildAt(start_banner, 1);
			if (x_value == 0)
				start_timer_out.stop();
		}
	}
}