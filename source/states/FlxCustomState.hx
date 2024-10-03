package states;

class FlxCustomState extends FlxState {
    var hscript:HScript;
    public static var instance:FlxCustomState;

    public function new(stateName:String) {
        instance = this;

        if (FileSystem.exists(Paths.getPath('states/$stateName.hx')) && stateName != null)
            hscript = new HScript(Paths.getPath('states/$stateName.hx'));

        super();
    }

    override function create() {
        hscript.call('onCreate', []);

        super.create();

        hscript.call('onCreatePost', []);
    }

    override function update(elapsed:Float) {
        hscript.call('onUpdate', [elapsed]);

        super.update(elapsed);

        hscript.call('onUpdatePost', [elapsed]);
    }

    override function destroy() {
        if (hscript != null) {
            hscript.call('onDestroy', []);
            hscript.close();
            hscript = null;
        }

        super.destroy();
    }
}