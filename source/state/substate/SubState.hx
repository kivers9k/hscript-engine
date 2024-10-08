package state.substate;

//another substate example
class SubState extends FlxSubState {
    public var hxArray:Array<HScript> = [];
    public static var instance:SubState;

    public function new() {
        instance = this;
        super();
    }
}