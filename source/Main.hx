package;

import flixel.FlxGame;
import openfl.Assets;
import openfl.Lib;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.events.Event;
import openfl.Lib;
import openfl.display.StageScaleMode;

typedef GameJson = {
    gameWidth:Int,
	gameHeight:Int,
	initialState:String,
	updateFramerate:Int,
	drawFramerate:Int,
	skipSplash:Bool,
	startFullscreen:Bool
}

class Main extends Sprite {
	var game:GameJson;
	
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
		createGameData();
		game = haxe.Json.parse(File.getContent(SUtil.getPath('game.json')));

        /*
		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1) {
			var ratioX:Float = stageWidth / game.gameWidth;
			var ratioY:Float = stageHeight / game.gameHeight;
			game.zoom = Math.min(ratioX, ratioY);
			game.gameWidth = Math.ceil(stageWidth / game.zoom);
			game.gameHeight = Math.ceil(stageHeight / game.zoom);
		}
		*/

		addChild(new FlxGame(
			game.gameWidth,
			game.gameHeight,
			FlxState,
			game.updateFramerate,
			game.drawFramerate,
			game.skipSplash,
			game.startFullscreen
		));
		FlxG.switchState(new FlxCustomState(game.initialState));

		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end
	}

	function createGameData():Void {
		if (!FileSystem.exists(SUtil.getPath('game.json'))) {
			var games:GameJson = {
			    gameWidth: 1080,
				gameHeight: 270,
				initialState: 'game',
				updateFramerate: 60,
				drawFramerate: 60,
				skipSplash: true,
			    startFullscreen: false
			}
			var gameData:String = haxe.Json.stringify(games, '\t');
			File.saveContent(SUtil.getPath('game.json'), gameData.trim());
		}
	}
}
