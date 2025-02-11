package state;

// state example
class GameState extends FlxState { 
    public static var instance:GameState = this;
    public var hscript:HScript;
    public var camHUD:FlxCamera;

    override function create() {
        camHUD = new FlxCamera();
        camHUD.bgColor.alpha = 0;
        FlxG.cameras.add(camHUD, false);

        super.create();
    }
}