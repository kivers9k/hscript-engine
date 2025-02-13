package util;

class ColorUtil {
    public static inline function getPixel32(sprite:FlxSprite, x:Int, y:Int):Int {
        return sprite.pixels.getPixel32(x, y);
    }

    public function setAlphaFloat(sprite:FlxSprite, ?alpha:Float = 1.0):Void {
        sprite.color.alphaFloat = alpha;
    }
}