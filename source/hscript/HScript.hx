package hscript;

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;

class HScript {
	public static var parser:Parser = new Parser();
	public var interp:Interp = new Interp();
	
	public var variables(get, never):Map<String, Dynamic>;
	public function get_variables():Dynamic {
		return interp.variables;
	}

	public var scriptName:String = null;
	private var linePos:Array<String> = [];
	public function new(hxPath:String) {
		scriptName = hxPath;
		preset();
		
		// the
		var contents:String = File.getContent(hxPath);
		var lines:String = '';
		
		for (splitStr in contents.split('\n')) {
			if (!splitStr.startsWith('import')) {
				lines += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.')[lib.split('.').length - 1];
				
				//enum support yay!
				var isEnum:Bool = Type.resolveEnum(lib) != null;
				if (isEnum || Type.resolveClass(lib) != null) {
					interp.variables.set(libName,
						isEnum ? Type.resolveEnum(lib) : Type.resolveClass(lib)
					);
				} else {
					SUtil.alert((isEnum ? 'Enum' : 'Class') + ' not Found', lib);
				}
				
				linePos.push(splitStr);
			}
		}
		
		try {
			execute(lines);
		} catch(e:Dynamic) {
			SUtil.alert('Error on Hscript', '$scriptName\n$e');
		}
		
		call('onCreate', []);
	}

	public function preset() {
		interp.variables.set('FlxG', FlxG);
		interp.variables.set('FlxSprite', FlxSprite);
		interp.variables.set('FlxCamera', FlxCamera);
		interp.variables.set('FlxTween', FlxTween);
		interp.variables.set('FlxEase', FlxEase);
		interp.variables.set('FlxTimer', FlxTimer);

		interp.variables.set('add', FlxG.state.add);
		interp.variables.set('remove', FlxG.state.remove);
		interp.variables.set('insert', FlxG.state.insert);

        //PlayState function
		interp.variables.set('game', PlayState.instance);
		interp.variables.set('print', PlayState.instance.print);

		interp.variables.set('FlxCustomState', FlxCustomState);
		interp.variables.set('FlxCustomSubState', FlxCustomState);
		interp.variables.set('Paths', Paths);
		interp.variables.set('SUtil', SUtil);

		interp.variables.set('setVar', function(name:String, args:Dynamic) {
			for (hx in PlayState.instance.hxArray)
			    hx.variables.set(name, args);
		});
		interp.variables.set('getVar', function(name:String) {
			var result:Dynamic = null;
			for (hx in PlayState.instance.hxArray) {
			    if (hx.variables.exists(name)) {
				    result = hx.variables.get(name);
			    }
			}
			return result;
		});
		interp.variables.set('removeVar', function(name:String) {
			for (hx in PlayState.instance.hxArray) {
			    if (hx.variables.exists(name)) {
				    hx.variables.remove(name);
				    return true;
				}
			}
			return false;
		});
		
		interp.variables.set('StringTools', StringTools);
		interp.variables.set('Reflect', Reflect);
		interp.variables.set('Math', Math);
		interp.variables.set('Type', Type);
		interp.variables.set('Std', Std);

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

	public function call(name:String, args:Array<Dynamic>):Dynamic {
		try {
			if (interp.variables.exists(name)) {
				return Reflect.callMethod(this, interp.variables.get(name), args);
			}
		} catch(e:Dynamic) {
			SUtil.alert('Error on Hscript', '$scriptName\n$e');
			return false;
		}
		return false;
	}

	public function execute(code:String):Dynamic {
		parser.line = 1 + linePos.length;
		parser.allowTypes = true;
		parser.allowJSON = true;
		return interp.execute(parser.parseString(code));
	}
}
