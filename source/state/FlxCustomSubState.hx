package state;

class FlxCustomSubState extends GameSubState {
	private var substatePath:String;
	
	public function new(subStateName:String) {
		super();
		substatePath = subStateName;
	}

	override function create() {
		if (FileSystem.exists(Paths.getPath('substates/$substatePath.hx'))) {
			hscript = new HScript(Paths.getPath('substates/$substatePath.hx'));
		} else {
			SUtil.alert('Error on loading substate', "couldn't" + ' load substate $substatePath');
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