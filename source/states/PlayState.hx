package states;

class PlayState extends FlxState {
	public var scriptPaths:String = Paths.getPath('scripts/');
	public var hxArray:Array<HScript> = [];

	public static var instance:PlayState;
	public var camHUD:FlxCamera;
	
	override function create() {
		instance = this;

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD, false);
        
		for (file in FileSystem.readDirectory(scriptPaths)) {
			if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}

        callOnHx('onCreate', []);

		super.create();
		
		callOnHx('onCreatePost', []);
	}

	override function update(elapsed:Float) {
		callOnHx('onUpdate', [elapsed]);

		super.update(elapsed);

		callOnHx('onUpdatePost', [elapsed]);
	}
	
	override function destroy() {
		for (hscript in hxArray) {
			hscript.call('onDestroy', []);
		    hscript.close();
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