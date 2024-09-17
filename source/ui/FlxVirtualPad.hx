package ui;

class FlxVirtualPad extends FlxSpriteGroup {
    public var dPad:FlxSpriteGroup;
    public var actions:FlxSpriteGroup;

    private static var buttonName:Array<String> = [];
    public var fromString:Map<String, FlxButton>();

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
			    add(dpad.add(createButton(0, FlxG.height - 260, 132, 135, 'up')));
			    add(dpad.add(createButton(0, FlxG.height - 135, 132, 135, 'down')));
            case LEFT_RIGHT:
			    add(dpad.add(createButton(0, FlxG.height - 135, 132, 135, 'left')));
			    add(dpad.add(createButton(126, FlxG.height - 135, 132, 135, 'right')));
            case FULL:
			    add(dpad.add(createButton(110, FlxG.height - 350, 132, 135, 'up')));
			    add(dpad.add(createButton(0, FlxG.height - 245, 132, 135, 'left')));
			    add(dpad.add(createButton(220, FlxG.height - 245, 132, 135, 'right')));
			    add(dpad.add(createButton(110, FlxG.height - 135, 132, 135, 'down')));
            case NONE:
        }

        switch (action) {
            case A:
			    add(actions.add(createButton(FlxG.width - 126, FlxG.height - 135, 132, 135, 'a')));
            case A_B:
			    add(actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
			    add(actions.add(createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b')));
            case A_B_C:
			    add(actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
			    add(actions.add(createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b')));
			    add(actions.add(createButton(FlxG.width - 388, FlxG.height - 135, 132, 135, 'c')));
            case A_B_X_Y:
			    add(actions.add(createButton(FlxG.width - 132, FlxG.height - 260, 132, 135, 'x')));
			    add(actions.add(createButton(FlxG.width - 258, FlxG.height - 260, 132, 135, 'y')));
			    add(actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
			    add(actions.add(createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b')));
            case NONE:
        }
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

    public function createButton(x:Float, y:Float, ?w:Int = 132, ?h:Int = 135, frame:String):FlxButton {
        var button:FlxButton = new FlxButton(x, y);
        button.frames = Paths.fromFrame('ui/virtual-input', frame, w, h);
        button.resetSizeFromFrame();
        button.scrollFactor.set();
        button.alpha = 0.75;

        buttonName.push(frame.toUpperCase());
        fromString.set(frame, button);

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
    NONE;
    UP_DOWN;
    LEFT_RIGHT;
    FULL;
}

enum FlxActionMode {
    NONE;
    A;
    A_B;
    A_B_C;
    A_B_X_Y;
}