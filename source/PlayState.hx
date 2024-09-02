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
	private var printTextGrp:FlxTypedGroup<PrintText>;

	override function create() {
		instance = this;

		camHUD = new FlxCamera();
		camHUD.bgColor.alpha = 0;
		FlxG.cameras.add(camHUD, false);

        printTextGrp = new FlxTypedGroup<PrintText>();
        printTextGrp.cameras = [camHUD];
		add(printTextGrp);
        
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

	public function print(text:String, ?color:Int = 0xffffffff) {
		printTextGrp.forEachAlive(function(txt:PrintText) {
			txt.y += 24;
		});

		if (printTextGrp.length > 28) {
			var guh = printTextGrp.members[28];
			guh.destroy();
			printTextGrp.remove(guh);
		}
		printTextGrp.insert(0, new PrintText(text, color));
	}
}

class PrintText extends FlxText {
    private var disableTime:Float = 6;
	public function new(text:String, ?colors:Int = 0xffffffff) {
		super(5, 0, 0, text, 24);
		scrollFactor.set();
        borderSize = 2;
		color = colors;
	}

	override function update(elapsed:Float) {
		super.update(elapsed);
		disableTime -= elapsed;
		if (disableTime < 0) disableTime = 0;
		if (disableTime < 1) alpha = disableTime;
	}
}
