package ui;

import flixel.math.FlxPoint;

class FlxJoystick extends FlxSpriteGroup {
	var base:FlxSprite;
	var thumb:FlxSprite;
	
	var direction:Float = 0;
	var amount:Float = 0;
	var radius:Float = 0;
	
	// -1 go left or up
	// 1 go right or down
	public var stickX(get, default):Int = 0;
	public var stickY(get, default):Int = 0;

	public function new(?X:Float = 0, ?Y:Float = 0, ?Radius:Float = 90, ?baseSprite:FlxSprite, ?thumbSprite:FlxSprite) {
		super(X, Y);
		
		if (baseGraphic == null) {
			base = new FlxSprite();
			base.frames = Paths.getFrame('ui/virtual-input', 'packer');
			base.animation.frameName = 'base';
		} else {
			base = baseSprite;
		}
		base.resetSizeFromFrame();
		base.moves = false;
		add(base);
		
		if (thumbGraphic == null) {
			thumb = new FlxSprite();
			thumb.frames = Paths.getFrame('ui/virtual-input', 'packer');
			thumb.animation.frameName = 'thumb';
		} else {
			thumb = thumbSprite;
		}
		thumb.resetSizeFromFrame();
		thumb.moves = false;
		add(thumb);
		
		this.radius = Radius;
		this.scrollFactor.set();
	}

	override function update(elapsed:Float):Void {
		super.update(elapsed);

        if (visible) {
		    updateJoystick();
		}
	}

	public funtion joystickScale(?x:Float = 1, ?y:Float = 1) {
		for (spr in members) {
		    spr.scale.set(x, y);
		    spr.updateHitbox();
		}
	}
	
	var _touched:Bool = false;
	function updateJoystick():Void {
		for (touch in FlxG.touches.list) {
		    if (touch.overlaps(base, camera) && touch.pressed) {
		    	_touched = true;
	    	} else if (touch.justReleased) {
	    		_touched = false;
	    	}
    		
	    	if (_touched) {
        		var _touchPoint:FlxPoint = touch.getScreenPosition(camera);
		    	var dx:Float = _touchPoint.x - base.x - (base.width / 2);
	    		var dy:Float = _touchPoint.y - base.y - (base.height / 2);
	    		var dist:Float = Math.sqrt(dx * dx + dy * dy);
		    	if (dist < 1) dist = 0;
			
	    		direction = Math.atan2(dy, dx);
	    		amount = Math.min(radius, dist) / radius;
			
	    		thumb.x = x + (base.width / 2) + Math.cos(direction) * amount * radius - (thumb.width / 2);
	    		thumb.y = y + (base.height / 2) + Math.sin(direction) * amount * radius - (thumb.height / 2);
	    	} else {
	    		thumb.x = base.x + (base.width - thumb.width) / 2;
	    		thumb.y = base.y + (base.height - thumb.height) / 2;
	    		direction = 0;
	    		amount = 0;
	    	}
		}
	}

	override function destroy():Void {
		super.destroy();

		base = null;
		thumb = null;
	}
	
	private function get_stickX():Int {
		return Math.round(Math.cos(direction) * amount);
	}

	private function get_stickY():Int {
		return Math.round(Math.sin(direction) * amount);
	}
}