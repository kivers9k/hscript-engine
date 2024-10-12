package state;

class InitialState extends FlxState {
    override function create() {
        var stateName:String = File.getContent(SUtil.getPath('initialState.txt'));
		FlxG.switchState(new FlxCustomState(stateName.split('\n')[0].trim()));
	}
}