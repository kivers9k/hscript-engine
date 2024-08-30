package;

import AndroidExtension as SUtil;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.util.FlxTimer;

import sys.io.File;

import hscript.Parser;
import hscript.Interp;
import hscript.Expr;

using StringTools;

class HScript {
	public static var parser:Parser = new Parser();
	public var interp:Interp = new Interp();
	
	public var variables(get, never):Map<String, Dynamic>;
	public function get_variables():Dynamic {
		return interp.variables;
	}

	public function new(hxPaths:String) {
		preset();
		
		// the
		var contents:String = File.getContent(hxPaths);
		var lines:String = '';
		
		for (splitStr in contents.split('\n')) {
			if (!splitStr.startsWith('import')) {
				lines += splitStr + '\n';
			} else {
				var lib:String = splitStr.split(' ')[1].replace(';', '');
				var libName:String = lib.split('.')[lib.split('.').length - 1];
				
				if (Type.resolveClass(lib) != null) {
					interp.variables.set(libName, Type.resolveClass(lib));
				} else {
					SUtil.alert('Library not Found!', lib);
				}
			}
		}
		
		try {
			execute(lines);
		} catch(error:Dynamic) {
			SUtil.alert('Error on Hscript!', error);
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
		interp.variables.set('game', PlayState.instance);

		interp.variables.set('setVar', function(name:String, args:Dynamic) {
			this.variables.set(name, args);
		});
		interp.variables.set('getVar', function(name:String) {
			var result:Dynamic = null;
			if (this.variables.exists(name)) {
				result = this.variables.get(name);
			}
			return result;
		});
		interp.variables.set('removeVar', function(name:String) {
			if (this.variables.exists(name)) {
				this.variables.remove(name);
				return true;
			}
			return false;
		});
		
		interp.variables.set('StringTools', StringTools);
		interp.variables.set('Reflect', Reflect);
		interp.variables.set('Math', Math);
		interp.variables.set('Type', Type);
		interp.variables.set('Std', Std);
	}

	public function call(name:String, args:Array<Dynamic>):Dynamic {
		try {
			if (interp.variables.exists(name)) {
				return Reflect.callMethod(this, interp.variables.get(name), args);
			}
		} catch(e:Dynamic) {
			SUtil.alert('Error on Hscript!', e);
			return false;
		}
		return false;
	}

	public function execute(codeToRun:String):Dynamic {
		@:privateAccess
		parser.line = 1;
		parser.allowTypes = true;
		return interp.execute(parser.parseString(codeToRun));
	}
}
