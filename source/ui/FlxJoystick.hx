package ui;

import flixel.math.FlxPoint;
import flixel.input.touch.FlxTouch;

class FlxJoystick extends FlxSpriteGroup {
	public var base:FlxSprite;
	public var thumb:FlxSprite;
	
	var direction:Float = 0;
	var amount:Float = 0;
	var radius:Float = 0;
	
	// -1 go left or up
	// 1 go right or down
	public var stickX(get, default):Int = 0;
	public var stickY(get, default):Int = 0;
	
	public function new(?X:Float = 0, ?Y:Float = 0, ?Radius:Float = 90, ?baseSprite:FlxSprite, ?thumbSprite:FlxSprite) {
		super(X, Y);

		this.radius = Radius;
		
		if (baseSprite == null) {
			base = new FlxSprite();
			base.frames = Paths.getFrame('ui/virtual-input', 'packer');
			base.animation.frameName = 'base';
		} else {
			base = baseSprite.clone();
		}
		base.resetSizeFromFrame();
		base.moves = false;
		add(base);
		
		if (thumbSprite == null) {
			thumb = new FlxSprite();
			thumb.frames = Paths.getFrame('ui/virtual-input', 'packer');
			thumb.animation.frameName = 'thumb';
		} else {
			thumb = thumbSprite.clone();
		}
		thumb.resetSizeFromFrame();
		thumb.moves = false;
		add(thumb);
		
		scrollFactor.set();
		centerThumb();
	}

	override function update(elapsed:Float):Void {
		super.update(elapsed);

		if (visible) {
			updateJoystick();
		}
	}

	public function scaleStick(?value:Float = 1) {
		for (spr in members) {
			spr.scale.set(value, value);
			spr.updateHitbox();
		}
	}

	public function centerThumb() {
		thumb.x = base.x + (base.width - thumb.width) / 2;
		thumb.y = base.y + (base.height - thumb.height) / 2;
	}
	
	var _touched:Bool = false;
	var _getTouchInput:FlxTouch;
	function updateJoystick():Void {
		for (touch in FlxG.touches.list) {
			if (touch.overlaps(base, camera) && touch.justPressed) {
				_touched = true;
				_getTouchInput = touch;
			} else if (_getTouchInput.justReleased) {
				_touched = false;
				_getTouchInput = null;
			}
			
			if (_touched) {
				var touchPoint:FlxPoint = _getTouchInput.getScreenPosition(camera);
				var dx:Float = touchPoint.x - base.x - (base.width / 2);
				var dy:Float = touchPoint.y - base.y - (base.height / 2);
				
				var dist:Float = Math.sqrt(dx * dx + dy * dy);
				if (dist < 1) dist = 0;
				
				direction = Math.atan2(dy, dx);
				amount = Math.min(radius, dist) / radius;
				
				thumb.x = x + (base.width / 2) + Math.cos(direction) * amount * radius - (thumb.width / 2);
				thumb.y = y + (base.height / 2) + Math.sin(direction) * amount * radius - (thumb.height / 2);
			} else {
				centerThumb();
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