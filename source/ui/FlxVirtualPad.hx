package ui;

class FlxVirtualPad extends FlxSpriteGroup {
    public var dPad:FlxSpriteGroup;
    public var actions:FlxSpriteGroup;

    public var fromStringMap:Map<String, FlxButton> = #if (haxe >= "4.0.0") new Map<String, FlxButton>() #else new Map() #end;

    public var buttonUp:FlxButton;
    public var buttonDown:FlxButton;
    public var buttonLeft:FlxButton;
    public var buttonRight:FlxButton;
    public var buttonA:FlxButton;
    public var buttonB:FlxButton;
    public var buttonC:FlxButton;
    public var buttonX:FlxButton;
    public var buttonY:FlxButton;
    
    public function new(?DPad:FlxDPadMode, ?Action:FlxActionMode) {
        super(); 
        scrollFactor.set();
 
        if (DPad == null) DPad = FULL;
        if (Action == null) Action = A_B_C;

        dPad = new FlxSpriteGroup();
        dPad.scrollFactor.set();

        actions = new FlxSpriteGroup();
        actions.scrollFactor.set();

        switch (DPad) {
            case UP_DOWN:
			    add(dPad.add(buttonUp = createButton(0, FlxG.height - 260, 132, 135, 'up')));
			    add(dPad.add(buttonDown = createButton(0, FlxG.height - 135, 132, 135, 'down')));
            case LEFT_RIGHT:
			    add(dPad.add(buttonLeft = createButton(0, FlxG.height - 135, 132, 135, 'left')));
			    add(dPad.add(buttonRight = createButton(126, FlxG.height - 135, 132, 135, 'right')));
            case FULL:
			    add(dPad.add(buttonUp = createButton(110, FlxG.height - 350, 132, 135, 'up')));
			    add(dPad.add(buttonLeft = createButton(0, FlxG.height - 245, 132, 135, 'left')));
			    add(dPad.add(buttonRight = createButton(220, FlxG.height - 245, 132, 135, 'right')));
			    add(dPad.add(buttonDown = createButton(110, FlxG.height - 135, 132, 135, 'down')));
            case NONE:
        }

        switch (Action) {
            case A:
			    add(actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
            case A_B:
			    add(actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
			    add(actions.add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b')));
            case A_B_C:
			    add(actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
			    add(actions.add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b')));
			    add(actions.add(buttonC = createButton(FlxG.width - 384, FlxG.height - 135, 132, 135, 'c')));
            case A_B_X_Y:
			    add(actions.add(buttonX = createButton(FlxG.width - 132, FlxG.height - 260, 132, 135, 'x')));
			    add(actions.add(buttonY = createButton(FlxG.width - 258, FlxG.height - 260, 132, 135, 'y')));
			    add(actions.add(buttonA = createButton(FlxG.width - 132, FlxG.height - 135, 132, 135, 'a')));
			    add(actions.add(buttonB = createButton(FlxG.width - 258, FlxG.height - 135, 132, 135, 'b')));
            case NONE:
        }
    }

    override function destroy():Void {
        super.destroy();

        dPad = FlxDestroyUtil.destroy(dPad);
        actions = FlxDestroyUtil.destroy(actions);

        dPad = null;
        actions = null;
        buttonUp = null;
        buttonDown = null;
        buttonLeft = null;
        buttonRight = null;
        buttonA = null;
        buttonB = null;
        buttonC = null;
        buttonX = null;
        buttonY = null;
    }

    public function createButton(x:Float, y:Float, w:Int = 132, h:Int = 135, frame:String):FlxButton {
        var button:FlxButton = new FlxButton(x, y);
        button.frames = Paths.fromFrame('ui/virtual-input', frame, w, h, 'packer');
        button.resetSizeFromFrame();
        button.scrollFactor.set();
        button.alpha = 0.75;
        
        if (!fromStringMap.exists(frame)) {
            fromStringMap.set(frame, button);
        }

        return button;
    }

    public function fromString(name:String):FlxButton {
        return fromStringMap.exists(name) ? fromStringMap.get(name) : null;
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