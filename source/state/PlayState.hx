package state;

class PlayState extends GameState {
	public var scriptPaths:String = Paths.getPath('scripts/');

	override function create() {
		for (file in FileSystem.readDirectory(scriptPaths)) {
			if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}

        super.create();
		
		callOnHx('create', []);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

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