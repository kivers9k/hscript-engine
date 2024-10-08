package state;

// state example
class GameState extends FlxState {
    public var hxArray:Array<HScript> = [];
    public static var instance:State;
    public var camHUD:FlxCamera;

    public function new() {
        instance = this;
        super();
    }

    override function create() {
        camHUD = new FlxCamera();
        camHUD.bgColor.alpha = 0;
        FlxG.cameras.add(camHUD, false);

        super.create();
    }
}