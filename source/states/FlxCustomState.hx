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
		if (FileSystem.exists(Paths.getPath('states/$statePath.hx')) && statePath != null) {
			hscript = new HScript(Paths.getPath('states/$statePath.hx'));
		} else {
			SUtil.alert('Error!', "couldn't load state '$statePath'");
		}
 
        super.create();

		hscript.call('create', []);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

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

	public function resetState():Void {
		FlxG.switchState(new FlxCustomState(statePath));
	}
}