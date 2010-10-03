package {
	
	import flash.display.*;
	import data.*;

	import flash.utils.*;
	import flash.net.*;
	import flash.events.*;

	public class SpeedTest	extends Sprite{
	
public var speed:text;
public var status:text;
public var loader:Loader;
public var timer:Timer;
public var timerVal:int;
	
		public function SpeedTest() {
			
			var start:text = new text(100, 100, "старт", "1");
			start.addEventListener(MouseEvent.CLICK, startEvent);
			addChild(start);	
			
			speed = new text(100, 150, "0 Kbit", "1");
			addChild(speed);
			
			status = new text(100, 200, "--", "1");
			addChild(status);
			
			timer = new Timer(10, 0);
			timer.addEventListener(TimerEvent.TIMER, eTimerEvent);
		}
		
		public function startEvent(e:MouseEvent):void {
			loader = new Loader();
			loader.contentLoaderInfo.addEventListener(ProgressEvent.PROGRESS, progressHandler);	
			loader.load(new URLRequest("http://high.dih.ru/speedtest"));
			timer.start();
			timerVal = 0;
		}
		
		public function progressHandler(e:ProgressEvent):void {
			var loaded:uint = e.bytesLoaded;
			var total:uint = e.bytesTotal;
			
			if (loaded == total) {
				//loadedFiles += total;
				timer.stop();
				speed.setText(String(Math.round((total/10/timerVal))*8)+" Кбит/c");
			}
			 
			
			var PersentLoaded:Number = Math.round((loaded/total)*100); 
			
			status.setText("Загрузка " + PersentLoaded + "% ");
			status.setText("Загрузка " + PersentLoaded + "% " + total + " " + timerVal);
		}
		
		public function eTimerEvent(e:TimerEvent):void {
			timerVal++;
			
		}
	}
}