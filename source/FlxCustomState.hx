package;

class FlxCustomState extends FlxState {
    var stateName:String = '';
    public var instance:FlxCustomState;

    public function new(state:String) {
        instance = this;
        this.stateName = state;
    }

    override function create() {
        call('onCreate', [stateName]);
        super.create();
        call('onCreatePost', [stateName]);
    }

    override function update(elapsed:Float) {
        call('onUpdate', [stateName, elapsed]);
        super.update(elapsed);
        call('onUpdatePost', [stateName, elapsed]);
    }

    public function call(name:String, args:Array<Dynamic>) {
        var ret:Dynamic = null;
        for (hx in PlayState.instance.hxArray) {
            ret = hx.call(name, args);
        }
        return ret;
    }
}