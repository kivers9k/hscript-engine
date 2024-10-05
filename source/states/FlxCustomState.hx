package states;

class FlxCustomState extends FlxState {
	var hscript:HScript;
	private var statePath:String;
	public static var instance:FlxCustomState;

	public function new(stateName:String) {
		instance = this;
		statePath = stateName;
        super();
	}

	override function create() {
		if (FileSystem.exists(Paths.getPath('states/$statePath.hx')) && statePath != null)
			hscript = new HScript(Paths.getPath('states/$statePath.hx'));
 
		hscript.call('create', []);
	}

	override function update(elapsed:Float) {
		hscript.call('update', [elapsed]);
	}

	override function destroy() {
		if (hscript != null) {
			hscript.call('destroy', []);
			hscript.stop();
			hscript = null;
		}
		super.destroy();
	}
}