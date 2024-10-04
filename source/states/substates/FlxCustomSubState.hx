package states.substates;

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
		if (FileSystem.exists(Paths.getPath('subStates/$substatePath.hx')) && substatePath != null) {
			hscript = new HScript(Paths.getPath('subStates/$substatePath.hx'));
		} else {
			close();
		}

		hscript.call('onCreate', []);
		
		super.create();
		
		hscript.call('onCreatePost', []);
	}
	
	override function update(elapsed:Float) {
		hscript.call('onUpdate', [elapsed]);
		
		super.update(elapsed);
		
		hscript.call('onUpdatePost', [elapsed]);
	}
	
	override function destroy() {
		if (hscript != null) {
			hscript.call('onDestroy', []);
			hscript.stop();
			hscript = null;
		}
		
		super.destroy();
	}
}