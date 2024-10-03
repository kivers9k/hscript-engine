package states;

class PlayState extends FlxState {
	public var scriptPaths:String = Paths.getPath('scripts/');
	public var hxArray:Array<HScript> = [];
	public var canHUD:FlxCamera;

	function new() {
		super();
        
        for (file in FileSystem.readDirectory(scriptPaths)) {
		    if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}
		
        for (hscript in hxArray) {
			hscript.variables.set('game', this);
			hscript.variables.set('add', this.add);
		    hscript.variables.set('remove', this.remove);
			hscript.variables.set('insert', this.insert);
            hscript.variables.set('members', this.members);
		}
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