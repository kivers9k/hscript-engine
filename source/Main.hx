package;

import flixel.FlxGame;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.StageScaleMode;

class Main extends Sprite {
	// You can pretty much ignore everything from here on - your code should go in your states.
	public static function main():Void {
		Lib.current.addChild(new Main());
	}

	public function new() {
		#if android
		SUtil.permissionCheck();
		#end
		
		super();

		#if android
		SUtil.createDirectory();
		SUtil.errorCheck();
		#end

		if (stage != null) {
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void {
		if (hasEventListener(Event.ADDED_TO_STAGE)) {
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		setupGame();
	}

	private function setupGame():Void {
		addChild(new FlxGame(1280, 720, state.InitialState, 1, 60, 60, true, false));
 
		var fps:FPS = new FPS();
		addChild(fps);

		FlxG.fixedTimestep = false; //prevent from lag
		FlxG.camera.antialiasing = true;

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end
	}
}
