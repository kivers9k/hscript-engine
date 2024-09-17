package ui;

class FlxVirtualPad extends FlxSpriteGroup {
    public var dPad:FlxSpriteGroup;
    public var actions:FlxSpriteGroup;

    private static var buttonName:Array<String> = [];
    public var fromString:Map<String, FlxButton>;

    public static var pressed = {};
    public static var justPressed = {};
    public static var justReleased = {};

    public function new(?dpad:FlxDPadMode = FULL, ?action:FlxActionMode = A_B_C) {
        super(); 
        scrollFactor.set();

        dPad = new FlxSpriteGroup();
        dPad.scrollFactor.set();

        actions = new FlxSpriteGroup();
        actions.scrollFactor.set();

        switch (dpad) {
            case UP_DOWN:
            case LEFT_RIGHT:
            case FULL:
        }

        switch (action) {
            case A:
            case A_B:
            case A_B_C:
            case A_B_X_Y:
        }
    }

    public function createButton(x:Float, y:Float, ?w:Int = 132, ?h:Int = 135, frame:String) {
        var button:FlxButton = new FlxButton(x, y);
        button.frames = Paths.fromFrame('ui/virtual-input', frame, w, h);
        button.scrollFactor.set();

        buttonName.push(frame.toUpperCase());
        fromString.set(frame, button);

        return button;
    }

    override public function update(elapsed:Float):Void {
        super.update(elapsed);

        for (name in buttonName) {
            if (fromString.get(name) != null) {
                pressed = {"$name": fromString.get(name).pressed};
                justPressed = {"$name": fromString.get(name).justPressed};
                justReleased = {"$name": fromString.get(name).justReleased};
            }
        }
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
    UP_DOWN;
    LEFT_RIGHT;
    FULL;
}

enum FlxActionMode {
    A;
    A_B;
    A_B_C;
    A_B_X_Y;
}