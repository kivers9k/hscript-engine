package ui;

class FlxVirtualPad extends FlxSpriteGroup {
    public var dPad:FlxSpriteGroup;
    public var actions:FlxSpriteGroup;

    public var pressed = {};
    public var justPressed = {};
    public var justReleased = {};
    
    public var fromStringMap:Map<String, FlxButton> = new Map<String, FlxButton>();

    public function new(?DPad:FlxDPadMode = FULL, ?Action:FlxActionMode = A_B_C) {
        super();
 
        add(dPad = new FlxSpriteGroup());
        add(actions = new FlxSpriteGroup());
        scrollFactor.set();
        
        switch (DPad) {
            case UP_DOWN:
			    dPad.add(createButton(0, FlxG.height - 260, 132, 135, 'up'));
			    dPad.add(createButton(0, FlxG.height - 135, 132, 135, 'down'));
            case LEFT_RIGHT:
			    dPad.add(createButton(0, FlxG.height - 135, 132, 135, 'left'));
			    dPad.add(createButton(126, FlxG.height - 135, 132, 135, 'right'));
            case FULL:
			    dPad.add(createButton(110, FlxG.height - 350, 132, 135, 'up'));
			    dPad.add(createButton(0, FlxG.height - 245, 132, 135, 'left'));
			    dPad.add(createButton(220, FlxG.height - 245, 132, 135, 'right'));
			    dPad.add(createButton(110, FlxG.height - 135, 132, 135, 'down'));
            case NONE:
        }

        switch (Action) {
            case A:
			    actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
            case A_B:
			    actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
			    actions.add(createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b'));
            case A_B_C:
			    actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
			    actions.add(createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b'));
			    actions.add(createButton(FlxG.width - 384, FlxG.height - 135, 132, 135, 'c'));
            case A_B_X_Y:
			    actions.add(createButton(FlxG.width - 132, FlxG.height - 260, 132, 135, 'x'));
			    actions.add(createButton(FlxG.width - 258, FlxG.height - 260, 132, 135, 'y'));
			    actions.add(createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
			    actions.add(createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b'));
            case NONE:
        }
    }

    override function destroy():Void {
        super.destroy();

        dPad = FlxDestroyUtil.destroy(dPad);
        actions = FlxDestroyUtil.destroy(actions);
        fromStringMap.clear();

        dPad = null;
        actions = null;
        pressed = null;
        justPressed = null;
        justReleased = null;
        fromStringMap = null;
    }

    public function createButton(x:Float, y:Float, w:Int = 132, h:Int = 135, frame:String):FlxButton {
        var button:FlxButton = new FlxButton(x, y);
        button.frames = Paths.fromFrame('ui/virtual-input', frame, w, h, 'packer');
        button.resetSizeFromFrame();
        button.scrollFactor.set();
        button.alpha = 0.75;
        
        if (!fromStringMap.exists(frame)) {
            fromStringMap.set(frame, button);

            var buttonName:String = frame.toUpperCase();
            Reflect.setField(pressed, buttonName, button.pressed);
            Reflect.setField(justPressed, buttonName, button.justPressed);
            Reflect.setField(justReleased, buttonName, button.justReleased);
        }
        return button;
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