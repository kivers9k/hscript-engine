package

class FlxCustomState extends FlxState {
    var stateName:String = '';
    public var instance:FlxCustomState;

    public function new(state:String) {
        this.stateName = state;
    }

    override function create() {
        instance = this;
        super.create();
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
    }
}