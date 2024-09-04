package;

class FlxCustomState extends FlxState {
    public var onCreate:() -> Void;
    public var onCreatePost:() -> Void;
    public var onUpdate:(Float) -> Void;
    public var onUpdatePost:(Float) -> Void;

    public static var instance:FlxCustomState;

    public function new() {
        instance = this;
        super();
    }

    override function create() {
        if (onCreate != null) onCreate();
        super.create();
        if (onCreatePost != null) onCreatePost();
    }

    override function update(elapsed:Float) {
        if (onUpdate != null) onUpdate(elapsed);
        super.update(elapsed);
        if (onUpdatePost != null) onUpdatePost(elapsed);
    }
}