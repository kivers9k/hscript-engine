package states;

class FlxCustomState extends FlxState {
    var hscript:HScript;
    public static var instance:FlxCustomState;

    function new(stateName:String) {
        instance = this;

        if (FileSystem.exists(Paths.getPath('states/$stateName.hx')) && stateName != null)
            hscript = new HScript(Paths.getPath('states/$stateName.hx'));

		hscript.variables.set('game', instance);
        hscript.variables.set('add', instance.add);
        hscript.variables.set('remove', instance.remove);
        hscript.variables.set('insert', instance.insert);
        hscript.variables.set('members', instance.members);

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
        hscript.call('onDestroy', []);
        hscript.close();
        hscript = null;

        super.destroy();
    }
}