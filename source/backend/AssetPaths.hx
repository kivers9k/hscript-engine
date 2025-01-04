package backend;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxTileFrames;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import flash.media.Sound;

class AssetPaths {
	public static function getPath(key:String):String {
		return SUtil.getPath('assets/$key');
	}

	public static function exists(key:String):Bool {
		return FileSystem.exists(getPath(key));
	}

	inline static public function image(key:String):FlxGraphic {
		if (exists('images/$key.png')) {
			var bitmap:BitmapData = BitmapData.fromFile(getPath('images/$key.png'));
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, getPath('images/$key.png'));
			
			return graphic;
		}
		return null;
	}
	
	static public function sound(key:String):Sound {
		if (exists('sounds/$key.ogg')) {
			return Sound.fromFile(getPath('sounds/$key.ogg'));
		}
		return null;
	}
    
	public static function font(key:String):String {
		if (exists(key) && (key.endsWith('.ttf') || key.endsWith('.otf'))) {
			return getPath(key);
		}
        return null;
    }
    
	public static function getContent(key:String):String {
		if (exists(key)) {
			return File.getContent(getPath(key));
		}
		return null;
    }

	public static function json(key:String):Dynamic {
		if (exists('$key.json')) {
			return haxe.Json.parse(getContent('$key.json'));
		}
		return null;
	}

	public static function shader(key:String):String {
 		if (exists('shaders/$key') && (key.endsWith('.frag') || key.endsWith('.vert'))) {
			return getContent('shaders/$key');
		}
		return null;
	}

	public static function getFrame(key:String, ?type:String = 'sparrow'):FlxAtlasFrames {
		var fileFormat:String = null;
		switch (type) {
            case 'sparrow': fileFormat = 'xml';
			case 'packer': fileFormat = 'txt';
		}

		if (exists('images/$key.png') && exists('images/$key.$fileFormat')) {
            switch (type) {
				case 'sparrow':
				    return FlxAtlasFrames.fromSparrow(image(key), getContent('images/$key.xml'));
 				case 'packer':
				    return FlxAtlasFrames.fromSpriteSheetPacker(image(key), getContent('images/$key.txt'));
			}		
		}
		return null;
	}

	public static function fromFrame(key:String, frame:String, w:Int, h:Int, ?type = 'sparrow'):FlxTileFrames {
        if (exists('images/$key.png')) {
            return FlxTileFrames.fromFrame(getFrame(key, type).getByName(frame), FlxPoint.get(w, h));
		}
		return null;
	}
}