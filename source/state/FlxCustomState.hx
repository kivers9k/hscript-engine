package state;

class FlxCustomState extends GameState {
	private var statePath:String;

	public function new(stateName:String, ?args:Array<Dynamic>) {
		super();

		statePath = stateName;

		if (Paths.exists('states/$statePath.hx')) {
		    hscript = new HScript(Paths.getPath('states/$statePath.hx'), null, true);
		} else {
			SUtil.alert('Error on loading state', "couldn't" + ' load state $statePath');
		}
		hscript.call('new', args == null ? [] : args);
	}

	override function create() {
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

class GameState extends FlxState { 
	public static var instance:GameState;
	public var hscript:HScript;

	public function new() {
		instance = this;
		super();
	}
}