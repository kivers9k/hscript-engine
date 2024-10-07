package state.substate;

class FlxCustomSubState extends FlxSubState {
	var hscript:HScript;
	private var substatePath:String;
	public static var instance:FlxCustomSubState;
	
	public function new(subStateName:String) {
		instance = this;
		substatePath = subStateName;
		super();
	}

	override function create() {
		if (FileSystem.exists(Paths.getPath('substates/$substatePath.hx')) && substatePath != null) {
			hscript = new HScript(Paths.getPath('substates/$substatePath.hx'));
		} else {
			close();
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
}