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

	public inline static function exists(key:String):Bool {
		return FileSystem.exists(getPath(key));
	}

	public inline static function image(key:String):FlxGraphic {
		if (exists('images/$key.png')) {
			var bitmap:BitmapData = BitmapData.fromFile(getPath('images/$key.png'));
			var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, getPath('images/$key.png'));
			return graphic;
		}
		return null;
	}
	
	public static function sound(key:String):Sound {
		if (exists('sounds/$key.ogg')) {
			return Sound.fromFile(getPath('sounds/$key.ogg'));
		}
		return null;
	}
	
	public static function font(key:String):String {
		if (exists('fonts/$key') && (key.endsWith('.ttf') || key.endsWith('.otf'))) {
			return getPath('fonts/$key');
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

	public static function shader(key:String):FlxRuntimeShader {
 		if (exists('shaders/$key') && (key.endsWith('.frag') || key.endsWith('.vert'))) {
			return new FlxRuntimeShader(getContent('shaders/$key'));
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

// for outside assets folder
class Files {
	public static getPath(dir:String):String {
		return SUtil.getPath(dir);
	}
	
	public inline static function exists(dir:String):Bool {
		return FileSystem.exists(getPath(dir));
	}

	public inline static function image(dir:String):FlxGraphic {
		var file = getPath('$dir.png');
		var bitmap:BitmapData = BitmapData.fromFile(file);
		var graphic:FlxGraphic = FlxGraphic.fromBitmapData(bitmap, false, file);
		return graphic;
	}

	public static function sound(dir:String):Sound {
		var file = getPath('$dir.ogg');
		return Sound.fromFile(file);
	}

	public static function font(dir:String):String {
		var file = getPath('$dir');
		if (file.endsWith('.ttf') || file.endsWith('.oft')) {
			return dir;
		}
		return null;
	}
	
	public function shader(dir:String):FlxRuntimeShader {
		var file = getFile('$dir');
		var frag = null;
		var vert = null;
		
		if (dir.endsWith('.frag')) {
			frag = getContent(dir);
		} else if (file.endsWith('.vert')) {
			vert = getContent(dir);
		}
		return new FlxRuntimeShader(frag, vert);
	}
	
	public static function getContent(dir:String):String {
		return File.getContent(getPath(dir));
	}
	
	public static function json(dir:String):Dynamic {
		return haxe.Json.parse(getContent('$dir.json'));
	}
	
	public static function getFrame(dir:String, ?type:String = 'sparrow'):FlxAtlasFrames {
		var atlas = null;
		switch(type) {
			case 'sparrow':
				atlas = FlxAtlasFrames.fromSparrow(image(dir), getContent('$dir.xml'));
			case 'packer':
				atlas = FlxAtlasFrames.fromSpriteSheetPacker(img(dir), getContent('$dir.txt'));
		}
		return atlas;
	}
	
	public static function fromFrame(dir:String, name:String, w:Int, h:Int, ?type:String = 'sparrow'):FlxTileFrames {
		return FlxTileFrames.fromFrame(getFrame(dir, type).getByName(name), FlxPoint.get(w, h));
	}
}