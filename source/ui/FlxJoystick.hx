package ui;

typedef ControlDirect = {
	LEFT:Bool,
	RIGHT:Bool,
	UP:Bool,
	DOWN:Bool
}

class FlxJoystick extends FlxSpriteGroup {
	public var base:FlxSprite;
	public var thumb:FlxSprite;
	
	static var _joysticks:Array<FlxJoystick> = [];
	
	var _direction:Float = 0;
	var _radius:Float = 0;
	var _amount:Float = 0;
	
	var controlDirect:ControlDirect;
	
	public function new(x:Float, y:Float) {
		super(x, y);
		_joysticks.push(this);
		scrollFactor.set();
		
		createBase();
		createThumb();
	}
	
	override function update(elapsed:Float) {
		super.update(elapsed);
		
		for (jstick in _joysticks) {
			thumb.x = base.x + (base.width - thumb.width) / 2;
			thumb.y = base.y + (base.height - thumb.height) / 2;
			_direction = 0;
			_amount = 0;
		}
	}

	function updateAnalog() {
		var dx:Float = mouse.x - base.x - (base.width * 0.5);
		var dy:Float = mouse.y - base.y - (base.height * 0.5);
		
		var dist:Float = Math.sqrt(dx * dx + dy * dy);
		
		if (dist < 1) dist = 0;
		
		_direction = Math.atan2(dy, dx);
		_amount = Math.min(_radius, dist) / _radius;
	}

	override function destroy() {
		super.destroy();
		
		_joysticks.remove(this);
		base = null;
		thumb = null;
	}

	function createBase():Void {
		base = new FlxSprite(0, 0);
		base.frames = Paths.fromFrame('ui/virtual-input', 'base', 252, 252);
		base.scrollFactor.set();
		add(base);
	}

	function createThumb():Void {
		thumb = new FlxSprite(0, 0);
		thumb.frames = Paths.fromFrame('ui/virtual-input', 'thumb', 156, 156);
		thumb.scrollFactor.set();
		add(thumb);
	}
}