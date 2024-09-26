package backends;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxTileFrames;
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

	public static function getFrame(key:String, ?type:String = 'sparrow'):FlxAtlasFrames {
		var fileData:String = null;
		switch (type) {
            case 'sparrow': fileData = getPath('images/$key.xml');
			case 'packer': fileData = getPath('images/$key.txt');
		}

		if (FileSystem.exists(getPath('images/$key.png')) && FileSystem.exists(fileData)) {
            switch (type) {
				case 'sparrow':
				    return FlxAtlasFrames.fromSparrow(image(key), getTextFromFile('images/$key.xml'));
 				case 'packer':
				    return FlxAtlasFrames.fromSpriteSheetPacker(image(key), getTextFromFile('images/$key.txt'));
			}		
		}
		return null;
	}

	public static function fromFrame(key:String, frame:String, w:Int, h:Int, ?type = 'sparrow'):FlxTileFrames {
        if (FileSystem.exists(getPath('images/$key.png'))) {
            return FlxTileFrames.fromFrame(getFrame(key, type).getByName(frame), FlxPoint.get(w, h));
		}
		return null;
	}
}