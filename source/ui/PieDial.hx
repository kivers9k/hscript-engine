package ui;

class PieDial extends FlxPieDial {
    public var value(get, set):Float;

    public var min(default, null):Int;
    public var max(default, null):Int;

    public function setRange(min:Int, max:Int) {
        if (max <= min) {
            throw "PieDial: max cannot be less than or equal to min";
            return;
        }

        this.min = min;
        this.max = max;

        if (!Math.isNaN(value)) {
            value = FlxMath.bound(value, min, max);
        } else {
            value = min;
        }
    }

    private function set_value(newValue:Float):Float {
        this.amount = FlxMath.bound(newValue, min, max) / max;
        return newValue;
    }

    private function get_value():Float {
        return value;
    }
}