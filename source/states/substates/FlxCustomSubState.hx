package states.substates;

class FlxCustomSubState extends FlxSubState {
    var hscript:HScript;

    function new(subStateName:String) {
        super();

        hscript = new HScript(Paths.getPath('subStates/$subStateName.hx'));
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
        hscript.call('onDestroy', []);
        hscript.close();
        hscript = null;

        super.destroy();
    }
}