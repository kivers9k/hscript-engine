package backend;

import flixel.graphics.frames.FlxAtlasFrames;
import flixel.graphics.frames.FlxTileFrames;
import flixel.graphics.FlxGraphic;
import openfl.display.BitmapData;
import flash.media.Sound;

class CustomPath {
	private static var paths:String;
	
	public function new(pathName:String) {
		paths = pathName;
	}
	
	public static function getPath(key:String):String {
		return SUtil.getPath('$paths/$key');
	}

	public inline static function exists(key:String):Bool {
		return FileSystem.exists(getPath(key));
	}

	public inline static function image(key:String, ?imgFolder:String = 'images'):FlxGraphic {
		if (exists('$imgFolder/$key.png')) {
			var bitmap:BitmapData = BitmapData.fromFile(getPath('$imgFolder/$key.png'));
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, getPath('$imgFolder/$key.png'));
			
			return graphic;
		}
		return null;
	}
	
	public static function sound(key:String, ?sndFolder:String = 'sounds'):Sound {
		if (exists('$sndFolder/$key.ogg')) {
			return Sound.fromFile(getPath('$sndFolder/$key.ogg'));
		}
		return null;
	}
    
	public static function font(key:String, ?fontFolder:String = 'fonts'):String {
		if (exists('$fontFolder/$key') && (key.endsWith('.ttf') || key.endsWith('.otf'))) {
			return getPath('$fontFolder/$key');
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

	public static function shader(key:String, ?shaderFolder:String = 'shaders'):FlxRuntimeShader {
 		if (exists('$shaderFolder/$key') && (key.endsWith('.frag') || key.endsWith('.vert'))) {
			return new FlxRuntimeShader(getContent('$shaderFolder/$key'));
		}
		return null;
	}

	public static function getFrame(key:String, ?path:String = 'images', ?type:String = 'sparrow'):FlxAtlasFrames {
		var fileFormat:String = null;
		switch (type) {
            case 'sparrow': fileFormat = 'xml';
			case 'packer': fileFormat = 'txt';
		}

		if (exists('$path/$key.png') && exists('$path/$key.$fileFormat')) {
            switch (type) {
				case 'sparrow':
				    return FlxAtlasFrames.fromSparrow(image(key, path), getContent('$path/$key.xml'));
 				case 'packer':
				    return FlxAtlasFrames.fromSpriteSheetPacker(image(key, path), getContent('$path/$key.txt'));
			}
		}
		return null;
	}

	public static function fromFrame(key:String, ?path:String = 'images', frame:String, w:Int, h:Int, ?type = 'sparrow'):FlxTileFrames {
        if (exists('$path/$key.png')) {
            return FlxTileFrames.fromFrame(getFrame(key, path, type).getByName(frame), FlxPoint.get(w, h));
		}
		return null;
	}
}