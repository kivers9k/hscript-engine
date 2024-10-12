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
		#if mobile
		#if android
		SUtil.permissionCheck(); 
		#end
		Sys.setCwd(SUtil.getPath());
		#end
		
		super();

		#if android
		SUtil.gameCrashCheck();
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
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1) {
			var ratioX:Float = stageWidth / game.gameWidth;
			var ratioY:Float = stageHeight / game.gameHeight;
			game.zoom = Math.min(ratioX, ratioY);
			game.gameWidth = Math.ceil(stageWidth / game.zoom);
			game.gameHeight = Math.ceil(stageHeight / game.zoom);
		}

		addChild(new FlxGame(1280, 720, state.InitialState, 60, 60, true, false));

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end
	}
}
