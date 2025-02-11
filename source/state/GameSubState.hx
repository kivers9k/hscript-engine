package state;

//another substate example
class GameSubState extends FlxSubState {
    public static var instance:GameSubState;
    public var hscript:HScript;

    public function new() {
        instance = this;
        super();
    }
}