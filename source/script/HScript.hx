package script;

class HScript {
	public var parser:Parser = new Parser();
	public var interp:Interp = new Interp();

	public var variables(get, never):Map<String, Dynamic>;
	public var modules(get, never):Map<String, Dynamic>;

	public var scriptName:String;

	public function new(hxPath:String, ?name:String, ?preset:Bool = false) {
		scriptName = name != null ? name : hxPath.split('/').pop().replace('.hx', '');

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
		// module
		modules.set('StringTools', StringTools);
		modules.set('Reflect', Reflect);
		modules.set('Math', Math);
		modules.set('Type', Type);
		modules.set('Std', Std);
        
		modules.set('FlxG', FlxG);
		modules.set('FlxSprite', FlxSprite);
		modules.set('FlxCamera', FlxCamera);
		modules.set('FlxTween', FlxTween);
		modules.set('FlxEase', FlxEase);
		modules.set('FlxTimer', FlxTimer);
		modules.set('FlxText', FlxText);
        
		modules.set('GameState', GameState);
		modules.set('GameSubState', GameSubState);
		modules.set('FlxCustomState', FlxCustomState);
		modules.set('FlxCustomSubState', FlxCustomSubState);
		modules.set('Main', Main);
		modules.set('Paths', Paths);
		modules.set('Files', Files);
		modules.set('SUtil', SUtil);
		modules.set('ColorUtil', ColorUtil);
        
		modules.set('FlxRuntimeShader', FlxRuntimeShader);
		modules.set('ShaderFilter', openfl.filters.ShaderFilter);

		// variable
        variables.set('this', this);

		variables.set('game', GameState.instance);
		variables.set('add', FlxG.state.add);
		variables.set('remove', FlxG.state.remove);
		variables.set('insert', FlxG.state.insert);
		variables.set('members', FlxG.state.members);
        
		variables.set('close', GameSubState.instance.close);
	}

	public function execute(code:String):Dynamic {
		try {
		    return interp.execute(parser.parseString(code));
		} catch(e:Dynamic) {
		    SUtil.alert('Error on HScript', 'in $scriptName\n$e');
			trace(e);
		}
		return null;
	}

	public function call(name:String, args:Array<Dynamic>):Dynamic {
		if (variables.exists(name)) {
			var func = variables.get(name);
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
		if (interp != null && variables != null) {
			variables.clear();
			interp = null;
		}
	}

	private function get_variables() {
		return interp.variables;
	}

	private function get_modules() {
		return interp.modules;
	}
}
