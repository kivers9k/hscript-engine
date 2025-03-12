package script;

class HScript {
	public var parser:Parser = new Parser();
	public var interp:Interp = new Interp();
	public var scriptName:String;

	public function new(hxPath:String, ?name:String, ?preset:Bool = false) {
		scriptName = name != null ? name : hxPath.split('/').pop().replace('.hx', '');
 
        parser.allowMetadata = true;
		parser.allowTypes = true;
		parser.allowJSON = true; 

        setDefaultPreprocesor();
		
		if (preset)
		    presetVars();
			
		execute(File.getContent(hxPath));
	}

    public function setDefaultPreprocesor() {
 	    #if android
		parser.preprocesorValues.set('android', 1);
		#elseif ios
		parser.preprocesorValues.set('ios', 1);
		#elseif mobile
		parser.preprocesorValues.set('mobile', 1);
		#elseif window
		parser.preprocesorValues.set('window', 1);
		#elseif desktop
		parser.preprocesorValues.set('desktop', 1);
		#end
	}

	public function presetVars() {
		// default set
		setVariable('StringTools', StringTools);
		setVariable('Reflect', Reflect);
		setVariable('Math', Math);
		setVariable('Type', Type);
		setVariable('Std', Std);
		setVariable('this', this);

		// flixel class
		setVariable('FlxG', FlxG);
		setVariable('FlxSprite', FlxSprite);
		setVariable('FlxCamera', FlxCamera);
		setVariable('FlxTween', FlxTween);
		setVariable('FlxEase', FlxEase);
		setVariable('FlxTimer', FlxTimer);
		setVariable('FlxText', FlxText);

		// source class
		setVariable('GameState', GameState);
		setVariable('GameSubState', GameSubState);
		setVariable('FlxCustomState', FlxCustomState);
		setVariable('FlxCustomSubState', FlxCustomSubState);
		setVariable('Main', Main);
		setVariable('Paths', Paths);
		setVariable('CustomPath', CustomPath);
		setVariable('SUtil', SUtil);

		// state variable
		var state = GameState.instance;
		if (FlxG.state.subState == GameSubState.instance) {
		    var state = GameSubState.instance;
		}

		setVariable('game', state);
		setVariable('add', state.add);
		setVariable('remove', state.remove);
		setVariable('insert', state.insert);
		setVariable('members', state.members);

        // subState variables
		setVariable('close', GameSubState.instance.close);

		// shader
		setVariable('FlxRuntimeShader', FlxRuntimeShader);
		setVariable('ShaderFilter', openfl.filters.ShaderFilter);
	}

	public function execute(code:String):Dynamic {
		try {
		    return interp.execute(parser.parseString(code));
		} catch(e:Dynamic) {
		    SUtil.alert('Error on HScript', 'in $scriptName\n$e');
		}
		return null;
	}

	public function call(name:String, args:Array<Dynamic>):Dynamic {
		if (existsVariable(name)) {
			var func = getVariable(name);
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

	public function setVariable(name:String, args:Dynamic) {
		interp.variables.set(name, args);
	}

	public function getVariable(name:String):Dynamic {
	    if (interp.variables.exists(name)) {
			return interp.variables.get(name);
		}
		return null;
	}

	public function removeVariable(name:String) {
		interp.variables.remove(name);
	}

	public function existsVariable(name:String):Bool {
		return interp.variables.exists(name);
	}
}
