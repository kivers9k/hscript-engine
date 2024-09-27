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

	private var linePos:Array<String> = [];
	public var scriptName:String = null;
	public function new(hxPath:String) {
		presetVars();
		scriptName = hxPath;
		
		var contents:String = File.getContent(hxPath);
		var lines:String = '';
		
		for (splitStr in contents.split('\n')) {
			if (!splitStr.startsWith('import')) {
				lines += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.')[lib.split('.').length - 1];
				
				//enum support yay!
				if (Type.resolveEnum(lib) != null || Type.resolveClass(lib) != null) {
					interp.variables.set(
						libName,
						(Type.resolveEnum(lib) != null) ? Type.resolveEnum(lib) : Type.resolveClass(lib)
					);
				} else {
					SUtil.alert(((Type.resolveEnum(lib) != null) ? 'Enum' : 'Class') + ' not Found', lib);
				}
				linePos.push(splitStr);
			}
		}
		
		try {
			execute(lines);
		} catch(e:Dynamic) {
			SUtil.alert('Error on Hscript', '$scriptName\n$e');
		}
	}

	public function presetVars() {
		interp.variables = [					
	        //default set
			'StringTools' => StringTools,
			'Reflect' => Reflect,
		    'Math' => Math,
			'Type' => Type,
		    'Std' => Std,

			'FlxG' => FlxG,
	        'FlxSprite' => FlxSprite,
		    'FlxCamera' => FlxCamera,
		    'FlxTween' =>  FlxTween,
		    'FlxEase' => FlxEase,
	        'FlxTimer' => FlxTimer,

		    'add' => FlxG.state.add,
            'remove' => FlxG.state.remove,
		    'insert' => FlxG.state.insert,

		    //PlayState
			'PlayState' => PlayState,
	        'game' => PlayState.instance,
		    'print' => PlayState.instance.print,

	        'FlxCustomState' => FlxCustomState,
	        'FlxCustomSubState' => FlxCustomState,
			'Paths' => Paths,
		    'SUtil' => SUtil,
		
	        'setVar' => function(name:String, args:Dynamic) {
			    for (hx in PlayState.instance.hxArray)
			    	hx.variables.set(name, args);
			},

		    'getVar' => function(name:String) {
			    var result:Dynamic = null;
			    for (hx in PlayState.instance.hxArray) {
			    	if (hx.variables.exists(name)) {
			    		result = hx.variables.get(name);
			    	}
			    }
			    return result;
			},

		    'removeVar' => function(name:String) {
			    for (hx in PlayState.instance.hxArray) {
				    if (hx.variables.exists(name)) {
					    hx.variables.remove(name);
					    return true;
				    }
			    }
			    return false;
		    }
		];

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

	public function call(funcName:String, param:Array<Dynamic>):Dynamic {
		if (interp.variables.exists(funcName)) {
			var func = interp.variables.get(funcName);
			if (Reflect.isFunction(func)) {
				var returnFunc = null;
				try {
					returnFunc = Reflect.callMethod(this, func, param);
				} catch(e:Dynamic) {
					SUtil.alert('Error on "$funcName"', '$scriptName\n$e');
					trace(e);
				}
				return returnFunc;
			}
		}
		return null;
	}

	public function execute(code:String):Dynamic {
		parser.line = 1 + linePos.length;
		parser.allowTypes = true;
		parser.allowJSON = true;
		return interp.execute(parser.parseString(code));
	}
}
