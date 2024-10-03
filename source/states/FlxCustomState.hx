package states;

class FlxCustomState extends FlxState {
    var hscript:HScript;

    public function new(stateName:String) {
        super();

        if (FileSystem(Paths.getPath('states/stateName.hx'))) {
            hscript = new HScript(Paths.getPath('states/$stateName.hx'));
        } else {
            FlxG.switchState(new PlayState());
        }

		hscript.variables.set('game', this);
        hscript.variables.set('add', this.add);
        hscript.variables.set('remove', this.remove);
        hscript.variables.set('insert', this.insert);
        hscript.variables.set('members', this.members);
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