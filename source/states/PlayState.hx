package states;

class PlayState extends FlxState {
	public var scriptPaths:String = Paths.getPath('scripts/');
	public var hxArray:Array<HScript> = [];
	public var camHUD:FlxCamera;
    public var instance:PlayState;

	function new() {
		instance = this;
        
        for (file in FileSystem.readDirectory(scriptPaths)) {
		    if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}

        for (hscript in hxArray) {
			hscript.variables.set('game', instance);
			hscript.variables.set('add', instance.add);
		    hscript.variables.set('remove', instance.remove);
			hscript.variables.set('insert', instance.insert);
            hscript.variables.set('members', instance.members);
		}

		super();
	}

	override function create() {
		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD, false);

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
			hscript = null;
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