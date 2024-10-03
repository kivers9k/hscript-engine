package states.substates;

class FlxCustomSubState extends FlxSubState {
    var hscript:HScript;
    var static instance:FlxCustomSubState;

    public function new(subStateName:String) {
        instance = this;
        
        if (FileSystem.exists(Paths.getPath('subStates/&subStateName.hx')) && subStateName != null) {
            hscript = new HScript(Paths.getPath('subStates/$subStateName.hx'));
        } else {
            close();
        }

		hscript.variables.set('game', instance);
        hscript.variables.set('add', instance.add);
        hscript.variables.set('remove', instance.remove);
        hscript.variables.set('insert', instance.insert);
        hscript.variables.set('members', instance.members);
        hscript.variables.set('close', instance.close);

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