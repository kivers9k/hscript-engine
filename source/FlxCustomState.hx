package;

class FlxCustomState extends FlxState {
    public static var onCreate:() -> Void;
    public static var onCreatePost:() -> Void;

    public static var onUpdate:(Float) -> Void;
    public static var onUpdatePost:(Float) -> Void;

    public var instance:FlxCustomState;

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