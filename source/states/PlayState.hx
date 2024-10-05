package states;

class PlayState extends FlxState {
	public var scriptPaths:String = Paths.getPath('scripts/');
	public var hxArray:Array<HScript> = [];
	public var camHUD:FlxCamera;
	public static var instance:PlayState;

	override function create() {
		instance = this;
		
		for (file in FileSystem.readDirectory(scriptPaths)) {
			if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD, false);

		callOnHx('create', []);
	}

	override function update(elapsed:Float) {
		callOnHx('update', [elapsed]);
	}
	
	override function destroy() {
		for (hscript in hxArray) {
			if (hscript != null) {
				hscript.call('destroy', []);
				hscript.stop();
				hscript = null;
			}
		}
		super.destroy();
	}

	public function callOnHx(name:String, args:Array<Dynamic>):Dynamic {
		var result:Dynamic = null;
		for (hscript in hxArray) {
			result = hscript.call(name, args);
		}
		return result;
	}
}