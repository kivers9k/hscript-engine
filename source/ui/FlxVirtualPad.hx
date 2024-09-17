package ui;

class FlxVirtualPad extends FlxUIGroup {
    public var dPad:FlxUIGroup;
    public var actions:FlxUIGroup;

    public static var pressed = {};
    public static var justPressed = {};
    public static var justReleased = {};

    public function new(?dpad:FlxDPadMode = FULL, ?action:FlxActionMode = A_B_C) {
        super(); 
        scrollFactor.set();

        dPad = new FlxUIGroup();
        dpad.scrollFactor.set();

        actions = new FlxUIGroup();
        actions.scrollFactor.set();
    }

    public function createButton(x:Float, y:Float, ?w:Int = 132, ?h:Int = 135, frame:String) {
        var button:FlxSpriteButton = new FlxSpriteButton(x, y);
        button.frames = Paths.fromFrame('ui/virtual-input', frame, w, h);
        button.scrollFactor.set();
        return button;
    }

    override public function destroy():Void {
        super.destroy();

        dPad = FlxDestroyUtil.destroy(dPad);
        actions = FlxDestroyUtil.destroy(actions);

        dPad = null;
        actions = null;
    }
}

enum FlxDPadMode {
    LEFT_RIGHT;
    UP_DOWN;
    FULL;
}

enum FlxActionMode {
    A;
    A_B;
    A_B_C;
    A_B_X_Y;
}