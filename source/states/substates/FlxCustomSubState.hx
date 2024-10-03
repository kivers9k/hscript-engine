package states.substates;

class FlxCustomSubState extends FlxSubState {
    var hscript:HScript;

    public function new(stateName:String) {
        if (FileSystem.exists(Paths.getPath('subStates/stateName.hx'))) {
            hscript = new HScript(Paths.getPath('subStates/$stateName.hx'));
        } else {
            close();
        }

		hscript.variables.set('game', this);
        hscript.variables.set('add', this.add);
        hscript.variables.set('remove', this.remove);
        hscript.variables.set('insert', this.insert);
        hscript.variables.set('members', this.members);
        hscript.variables.set('close', this.close);

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