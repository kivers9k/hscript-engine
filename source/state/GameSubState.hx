package state;

//another substate example
class GameSubState extends FlxSubState {
    public static var instance:GameSubState = this;
    public var hscript:HScript;
}