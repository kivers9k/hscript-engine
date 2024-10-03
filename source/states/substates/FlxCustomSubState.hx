package states.substates;

class FlxCustomSubState extends FlxSubState {
    var hscript:HScript;
    public static var instance:FlxCustomSubState;

    public function new(subStateName:String) {
        instance = this;
        
        if (FileSystem.exists(Paths.getPath('subStates/$subStateName.hx')) && subStateName != null) {
            hscript = new HScript(Paths.getPath('subStates/$subStateName.hx'));
        } else {
            close();
        }

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