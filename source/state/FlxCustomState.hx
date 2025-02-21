package state;

class FlxCustomState extends GameState {
	private var statePath:String;

	public function new(stateName:String) {
		super();
		statePath = stateName;
	}

	override function create() {
		if (Paths.exists('states/$statePath.hx')) {
	        hscript = new HScript(Paths.getPath('states/$statePath.hx'));
		} else {
			//SUtil.alert('Error on loading state', "couldn't" + ' load state $statePath');
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