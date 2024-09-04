package;

class FlxCustomState extends FlxState {
    public static var onCreate:() -> Void;
    public static var onCreatePost:() -> Void;

    public static var onUpdate:(elapsed:Float) -> Void;
    public static var onUpdatePost:(elapsed:Float) -> Void;

    public static var instance:FlxCustomState;

    public function new() {
        instance = this;
        super();
    }

    override function create() {
        onCreate();
        super.create();
        onCreatePost();
    }

    override function update(elapsed:Float) {
        onUpdate(elapsed);
        super.update(elapsed);
        onUpdatePost(elapsed);
    }
}