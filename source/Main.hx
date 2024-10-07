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
    width:Int,
	height:Int,
	zoom:Float,
	framerate:Int,
	initialState:String,
	skipSplash:Bool,
	fullscreen:Bool
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
		gameData();
		game = haxe.Json.parse(File.getContent(SUtil.getPath('game.json')));

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1) {
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}

		addChild(new FlxGame(
			game.width,
			game.height,
			FlxState,
			game.zoom,
			game.framerate,
			game.framerate,
			game.skipSplash,
			game.fullscreen
		));
		FlxG.switchState(new FlxCustomState(game.initialState));

		Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;

		#if android
		FlxG.android.preventDefaultKeys = [BACK];
		#end
	}

	function gameData():Void {
		if (!FileSystem.exists(SUtil.getPath('game.json'))) {
			var games:GameJson = {
			    width: 270,
				height: 1080,
				zoom: -1.0,
				framerate: 60,
				initialState: 'game',
				skipSplash: true,
			    fullscreen: false
			}
			var gameData:String = haxe.Json.stringify(games, '\t');
			File.saveContent(SUtil.getPath('game.json'), gameData.trim());
		}
	}
}
