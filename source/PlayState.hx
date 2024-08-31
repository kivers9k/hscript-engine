package;

class PlayState extends FlxState {
	#if (haxe >= "4.0.0")
	public var variables:Map<String, Dynamic> = new Map();
	#else
	public var variables:Map<String, Dynamic> = new Map<String, Dynamic>();
	#end

	public var scriptPaths:String = Paths.getPath('scripts/');
	public var hxArray:Array<HScript> = [];

	public static var instance:PlayState;
	public var camHUD:FlxCamera;

	override function create() {
		instance = this;

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD, false);

		for (file in FileSystem.readDirectory(scriptPaths)) {
			if (file.endsWith('.hx')) {
				hxArray.push(new HScript(scriptPaths + file));
			}
		}
		super.create();
		callOnHx('onCreatePost', []);
	}

	override function update(elapsed:Float) {
		callOnHx('onUpdate', [elapsed]);
		super.update(elapsed);
		callOnHx('onUpdatePost', [elapsed]);
	}
	
	public function callOnHx(name:String, args:Array<Dynamic>):Dynamic {
		var result:Dynamic = null;
		for (hscript in hxArray) {
			result = hscript.call(name, args);
		}
		return result;
	}
}
