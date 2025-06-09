package ui;

class PieDial extends FlxPieDial {
    @:isVar
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
            value = Math.max(min, Math.min(value, max));
        } else {
            value = min;
        }
    }

    private function set_value(newValue:Float):Float {
        value = Math.max(min, Math.min(newValue, max));
        this.amount = value / max;
        return newValue;
    }

    private function get_value():Float {
        return value;
    }
}