package ui;

class FlxVirtualPad extends FlxSpriteGroup {
    // buttons group
    public var stick:FlxVirtualStick;
    public var dPad:FlxSpriteGroup;
    public var actions:FlxSpriteGroup;

    // dpad button
    public var buttonLeft:FlxButton;
    public var buttonRight:FlxButton;
    public var buttonUp:FlxButton;
    public var buttonDown:FlxButton;

    // actions button
    public var buttonA:FlxButton;
    public var buttonB:FlxButton;
    public var buttonC:FlxButton;
    public var buttonX:FlxButton;
    public var buttonY:FlxButton;

    public function new(?DPad:FlxDPadMode = FULL, ?Action:FlxActionMode = A_B_C) {
        super();
 
        add(dPad = new FlxSpriteGroup());
        add(actions = new FlxSpriteGroup());

        switch (DPad) {
            case UP_DOWN:
			    dPad.add(buttonUp = createButton(0, FlxG.height - 260, 132, 135, 'up'));
			    dPad.add(buttonDown = createButton(0, FlxG.height - 135, 132, 135, 'down'));
            case LEFT_RIGHT:
			    dPad.add(buttonLeft = createButton(0, FlxG.height - 135, 132, 135, 'left'));
			    dPad.add(buttonRight = createButton(126, FlxG.height - 135, 132, 135, 'right'));
            case FULL:
			    dPad.add(buttonUp = createButton(110, FlxG.height - 350, 132, 135, 'up'));
			    dPad.add(buttonLeft = createButton(0, FlxG.height - 245, 132, 135, 'left'));
			    dPad.add(buttonRight = createButton(220, FlxG.height - 245, 132, 135, 'right'));
			    dPad.add(buttonDown = createButton(110, FlxG.height - 135, 132, 135, 'down'));
            case STICK:
                stick = new FlxVirtualStick();
                stick.setPosition(40, FlxG.height - stick.height - 40);
                dPad.add(stick);
            case NONE:
        }

        switch (Action) {
            case A:
			    actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
            case A_B:
			    actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
			    actions.add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b'));
            case A_B_C:
			    actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
			    actions.add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b'));
			    actions.add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 135, 'c'));
            case A_B_X_Y:
			    actions.add(buttonX = createButton(FlxG.width - 132, FlxG.height - 260, 132, 135, 'x'));
			    actions.add(buttonY = createButton(FlxG.width - 258, FlxG.height - 260, 132, 135, 'y'));
			    actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a'));
			    actions.add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b'));
            case NONE:
        }

        this.scrollFactor.set();
        this.alpha = 0.75;
    }

    override function destroy():Void {
        super.destroy();

        stick = FlxDestroyUtil.destroy(stick);
        dPad = FlxDestroyUtil.destroy(dPad);
        actions = FlxDestroyUtil.destroy(actions);

        stick = null;
        dPad = null;
        actions = null;

        buttonLeft = null;
        buttonRight = null;
        buttonUp = null;
        buttonDown = null;

        buttonA = null;
        buttonB = null;
        buttonC = null;
        buttonX = null;
        buttonY = null;
    }

    public function createButton(x:Float, y:Float, w:Int, h:Int, frame:String):FlxButton {
        var button:FlxButton = new FlxButton(x, y);
        button.frames = Paths.fromFrame('ui/virtual-input', frame, w, h, 'packer');
        button.resetSizeFromFrame();
        return button;
    }
}

enum FlxDPadMode {
    NONE;
    UP_DOWN;
    LEFT_RIGHT;
    FULL;
    STICK;
}

enum FlxActionMode {
    NONE;
    A;
    A_B;
    A_B_C;
    A_B_X_Y;
}
