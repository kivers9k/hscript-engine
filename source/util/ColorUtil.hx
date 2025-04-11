package util;

class ColorUtil {
    public static var TRANSPARENT:Int = 0x00000000;
    public static var BLACK:Int = 0xff000000;
    public static var GRAY:Int = 0xff808080;
    public static var WHITE:Int = 0xffffffff;
    public static var RED:Int = 0xffff0000;
    public static var GREEN:Int = 0xff008000;
    public static var BLUE:Int = 0xff0000ff;
    public static var LIME:Int = 0xff00ff00;
    public static var MAGENTA:Int = 0xffff00cf;
    public static var CYAN:Int = 0xff00ffff;
    public static var BROWN:Int = 0xff8b4513;
    public static var ORANGE:Int = 0xffffa500;
    public static var YELLOW:Int = 0xffffff00;
    public static var PINK:Int = 0xffffc0cb;
    public static var PURPLE:Int = 0xff800080;

    public static function colorFromString(color:String):Int {
        var result:String = color;
        if (color.startsWith('#')) {
            result = color.replace('#', '');
        }
        return Std.parseInt('0xff$color');
    }
}