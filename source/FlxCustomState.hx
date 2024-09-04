package;

class FlxCustomState extends FlxState {
    public var onCreate:() -> Void;
    public var onCreatePost:() -> Void;

    public var onUpdate:(elapsed:Float) -> Void;
    public var onUpdatePost:(elapsed:Float) -> Void;

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