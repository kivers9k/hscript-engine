package;

class FlxCustomState extends FlxState {
    public static var onCreate:Void -> Void;
    public static var onCreatePost:Void -> Void;

    public static var onUpdate:Void -> Void;
    public static var onUpdatePost:Void -> Void;
    
    var stateName:String = '';
    public var instance:FlxCustomState;

    public function new(state:String) {
        instance = this;
        this.stateName = state;
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