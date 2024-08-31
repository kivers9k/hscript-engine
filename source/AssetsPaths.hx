package;

import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import sys.io.File;
import sys.FileSystem;
import flash.media.Sound;

class AssetPaths {
	public static function getPath(key:String):String {
		return SUtil.getPath() + 'assets/$key';
	}
	
	inline static public function image(key:String):FlxGraphic {
		var path:String = getPath('images/$key.png');
		
		if (FileSystem.exists(path)) {
			var bitmap:BitmapData = BitmapData.fromFile(path);
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, path);
			
			return graphic;
		}
		return null;
	}
	
	static public function sound(key:String):Sound {
		var path:String = getPath('sounds/$key');
		
		if (FileSystem.exists(path)) {
			return Sound.fromFile(path);
		}
		return null;
	}
	
	public static function getTxtFromFile(key:String):String {
		var path:String = getPath(key);
		
		if (FileSystem.exists(path)) {
			return File.getContent(path);
		}
		return null;
	}
}