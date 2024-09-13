package backends;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
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
		var path:String = getPath('sounds/$key.ogg');

		if (FileSystem.exists(path)) {
			return Sound.fromFile(path);
		}
		return null;
	}
    
	public static function font(key:String):String {
		var path:String = getPath('fonts/$key');

		if (FileSystem.exists(path) && (path.endsWith('.ttf') || path.endsWith('.otf'))) {
			return path;
		}
        return null;
    }
    
	public static function getTextFromFile(key:String):String {
		var path:String = getPath(key);
		
		if (FileSystem.exists(path)) {
			return File.getContent(path);
		}
		return null;
    }

	public static function getFrame(key:String):FlxAtlasFrames {
		if (FileSystem.exists(getPath('images/$key.xml'))) {
            return FlxAtlasFrames.fromSparrow(
				image(key),
				getTextFromFile('images/key.xml')
			);
		} else if (FileSystem.exists(getPath('images/$key.txt))) {
			return FlxAtlasFrames.fromSpriteSheetPacker(
                image(key),
				getTextFromFile('images/$key.txt')
			);
		}
		return null;
	}
}
