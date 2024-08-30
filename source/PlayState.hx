package;

import AndroidExtension as SUtil;
import HScript;

import sys.FileSystem;
import flixel.FlxState;

using StringTools;

class PlayState extends FlxState {
	var hxArray:Array<HScript> = [];
	var scriptPaths:String = SUtil.getPath() + 'assets/scripts/';
	var instance:PlayState;

	override function create() {
		instance = this;

		for (file in FileSystem.readDirectory(scriptPaths)) {
			if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}
		super.create();
		callOnHx('onCreatePost', []);
	}

	override function update(elapsed:Float) {
		callOnHx('onUpdate', [elapsed]);
		super.update(elapsed);
		callOnHx('onUpdatePost', [elapsed]);
	}
	
	public function callOnHx(name:String, args:Array<Dynamic>):Dynamic {
		var result:Dynamic = null;
		for (hscript in hxArray) {
			result = hscript.call(name, args);
		}
		return result;
	}
}
