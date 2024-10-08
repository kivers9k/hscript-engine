package script;

class HScript {
	public static var parser:Parser = new Parser();
	public var interp:Interp = new Interp();
	
	public var variables(get, never):Map<String, Dynamic>;
	public function get_variables():Dynamic {
		return interp.variables;
	}

	private var linePos:Array<String> = [];
	public var scriptName:String;

	public function new(hxPath:String) {
		presetVars();
		scriptName = hxPath.split('/').pop().replace('.hx', '');
		
		var contents:String = File.getContent(hxPath);
		var lines:String = '';
		
		for (splitStr in contents.split('\n')) {
			if (!splitStr.startsWith('import')) {
				lines += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.').pop();
				
				if (Type.resolveEnum(lib) != null || Type.resolveClass(lib) != null) {
					interp.variables.set(libName, (Type.resolveEnum(lib) != null) ? Type.resolveEnum(lib) : Type.resolveClass(lib));
				} else {
					SUtil.alert(((Type.resolveEnum(lib) != null) ? 'Enum' : 'Class') + ' not Found', lib);
				}
				linePos.push(splitStr);
			}
		}
		
		try {
			execute(lines);
		} catch(e:Dynamic) {
			SUtil.alert('Error on Hscript', 'in $scriptName\n$e');
		}
	}

	public function presetVars() {
		// default set
		interp.variables.set('StringTools', StringTools);
		interp.variables.set('Reflect', Reflect);
		interp.variables.set('Math', Math);
		interp.variables.set('Type', Type);
		interp.variables.set('Std', Std);
		interp.variables.set('this', this);

		// flixel class
		interp.variables.set('FlxG', FlxG);
		interp.variables.set('FlxSprite', FlxSprite);
		interp.variables.set('FlxCamera', FlxCamera);
		interp.variables.set('FlxTween', FlxTween);
		interp.variables.set('FlxEase', FlxEase);
		interp.variables.set('FlxTimer', FlxTimer);

		// source class
		interp.variables.set('PlayState', PlayState);
		interp.variables.set('FlxCustomState', FlxCustomState);
		interp.variables.set('FlxCustomSubState', FlxCustomState);
		interp.variables.set('Paths', Paths);
		interp.variables.set('SUtil', SUtil);

		// state variable
		var state = FlxG.state;
		if (FlxG.state == PlayState.instance) {
			state == PlayState.instance;
		} else if (FlxG.state == FlxCustomState.instance) {
			state = FlxCustomState.instance;
		} else if (FlxG.state == FlxCustomSubState.instance) {
			state = FlxCustomSubState.instance;
		}

		interp.variables.set('game', state);
		interp.variables.set('add', state.add);
		interp.variables.set('remove', state.remove);
		interp.variables.set('insert', state.insert);
		interp.variables.set('members', state.members);
		
		interp.variables.set('addScript', function(fileName:String) {
			if (FileSystem.exists(Paths.getPath('scripts/$fileName.hx')))
			    state.hxArray.push(new HScript(Paths.getPath('scripts/$fileName.hx')));
		});

		//targeting device variable
		interp.variables.set('deviceTarget',
			#if android 'android'
			#elseif ios 'ios'
			#elseif mobile 'mobile'
			#elseif window 'window'
			#elseif desktop 'desktop'
			#end
		);
	}

	public function execute(code:String):Dynamic {
		parser.line = 1 + linePos.length;
		parser.allowTypes = true;
		parser.allowJSON = true;
		return interp.execute(parser.parseString(code));
	}

	public function call(name:String, args:Array<Dynamic>):Dynamic {
		if (interp.variables.exists(name)) {
			var func = interp.variables.get(name);
			if (Reflect.isFunction(func)) {
				var returnFunc = null;
				try {
					returnFunc = Reflect.callMethod(this, func, args);
				} catch(e:Dynamic) {
					SUtil.alert('Error on $name', 'in $scriptName\n$e');
					trace(e);
				}
				return returnFunc;
			}
		}
		return null;
	}

	public function stop():Void {
		if (interp != null && interp.variables != null) {
			interp.variables.clear();
			interp = null;
		}
	}
}
