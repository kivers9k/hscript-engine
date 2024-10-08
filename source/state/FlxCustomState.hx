package state;

class FlxCustomState extends FlxState {
	public var hxArray:Array<HScript> = [];
	private var statePath:String;
	public static var instance:FlxCustomState;

	public function new(stateName:String) {
		instance = this;
		statePath = stateName;
        super();
	}

	override function create() {
		if (FileSystem.exists(Paths.getPath('states/$statePath.hx'))) {
			hxArray.push(new HScript(Paths.getPath('states/$statePath.hx')));
		} else {
			SUtil.alert('Error on loading state', "couldn't load state $statePath");
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

    public callOnHx(name:String, args:Array<Dynamic>):Dynamic {
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