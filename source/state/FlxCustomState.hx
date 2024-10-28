package state;

class FlxCustomState extends GameState {
	private var statePath:String;

	public function new(stateName:String, args:Array<Dynamic>) {
		super();
        
		statePath = stateName;
		callOnHx('new' args);
	}

	override function create() {
		if (FileSystem.exists(Paths.getPath('states/$statePath.hx'))) {
			hxArray.push(new HScript(Paths.getPath('states/$statePath.hx')));
		} else {
			SUtil.alert('Error on loading state', "couldn't" + ' load state $statePath');
		}
 
        super.create();

		callOnHx('create', []);
	}

	override function update(elapsed:Float) {
		super.update(elapsed);

		callOnHx('update', [elapsed]);
	}

	override function destroy() {
		for (hx in hxArray) {
		    if (hx != null) {
		    	hx.call('destroy', []);
			    hx.stop();
			    hx = null;
		    }
		}
		super.destroy();
	}

    public function callOnHx(name:String, args:Array<Dynamic>):Dynamic {
        var result:Dynamic = null;
		for (hx in hxArray) {
			result = hx.call(name, args);
		}
		return result;
	}

	public function resetState():Void {
		FlxG.switchState(new FlxCustomState(statePath));
	}
}