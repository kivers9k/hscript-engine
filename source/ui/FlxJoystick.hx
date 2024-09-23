package ui;

import flixel.input.touch.FlxTouch;

typedef ControlDirect = {
	LEFT:Bool,
	RIGHT:Bool,
	UP:Bool,
	DOWN:Bool
}

class FlxJoystick extends FlxSpriteGroup {
	public var base:FlxSprite;
	public var thumb:FlxSprite;
    
	var _touch:FlxTouch;

	var _direction:Float = 0;
	var _radius:Float = 0;
	var _amount:Float = 0;
	
	var controlDirect:ControlDirect;
	
	public function new(x:Float, y:Float, radius:Float = 0) {
		super(x, y);
		scrollFactor.set();
		
		createBase();
		createThumb();

		if (base != null && radius == 0)
		    _radius = base.width * 0.5;
	}
	
	override function update(elapsed:Float) {
		super.update(elapsed);
		
		thumb.x = base.x + (base.width - thumb.width) / 2;
		thumb.y = base.y + (base.height - thumb.height) / 2;
		_direction = 0;
		_amount = 0;

		if (FlxG.mouse.overlaps(base) && _touch.pressed) {
            updateAnalog();
		    thumb.x = base.x + (base.width * 0.5) + Math.cos(_direction) * _amount * _radius - (thumb.width * 0.5);
			thumb.y = base.y + (base.height * 0.5) + Math.sin(_direction) * _amount * _radius - (thumb.height * 0.5);
		}
	}

	function updateAnalog():Void {
		var dx:Float = _touch.x - base.x - (base.width * 0.5);
		var dy:Float = _touch.y - base.y - (base.height * 0.5);
		
		var dist:Float = Math.sqrt(dx * dx + dy * dy);
		
		if (dist < 1) dist = 0;
		
		_direction = Math.atan2(dy, dx);
		_amount = Math.min(_radius, dist) / _radius;
	}

	override function destroy() {
		super.destroy();

		_touch = null; 
		base = null;
		thumb = null;
	}

	function createBase():Void {
		base = new FlxSprite(0, 0);
		base.frames = Paths.fromFrame('ui/virtual-input', 'base', 252, 252);
		base.resetSizeFromFrame();
		base.scrollFactor.set();
		base.solid = false;
		add(base);
	}

	function createThumb():Void {
		thumb = new FlxSprite(0, 0);
		thumb.frames = Paths.fromFrame('ui/virtual-input', 'thumb', 156, 156);
		thumb.resetSizeFromFrame();
		thumb.scrollFactor.set();
		thumb.solid = false;
		add(thumb);
	}
}