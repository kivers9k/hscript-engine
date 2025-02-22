package;

import flixel.FlxGame;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.StageScaleMode;

using StringTools;

class Main extends Sprite {
	var game = {
		gameWidth: 1280,
		gameHeight: 720,
		initialState: state.InitialState,
        updateFramerate: 60,
		drawFramerate: 60,
		skipSplash: true,
		startFullscreen: false
	}

	// You can pretty much ignore everything from here on - your code should go in your states.
	public static function main():Void {
		Lib.current.addChild(new Main());
	}

	public function new() {
		#if android
	    //SUtil.permissionCheck();
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
		addChild(new FlxGame(
	        game.gameWidth,
			game.gameHeight,
			game.initialState,
		    #if (flixel < "5.0.0") 1.0, #end
            game.updateFramerate,
			game.drawFramerate,
			game.skipSplash,
			game.startFullscreen
		));
        
		var fps:FPS = new FPS();
		addChild(fps);

		FlxG.fixedTimestep = false; //prevent from lag

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end
	}
}
