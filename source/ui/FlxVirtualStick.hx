package ui;

import flixel.util.FlxPoint;
import flixel.input.touch.FlxTouch;
import flixel.system.FlxAssets.FlxGraphicAsset;

class FlxVirtualStick extends FlxSpriteGroup {
	var touch:FlxTouch;
	
	var direction:Float = 0;
	var amount:Float = 0;
	var radius:Float = 0;
	
	// -1 go left or up
	// 1 go right or down
	public var stickX(get, default):Int = 0;
	public var stickY(get, default):Int = 0;
	
	public var base:FlxSprite;
	public var thumb:FlxSprite;
	
	public function new(X:Float = 0, Y:Float = 0, ?Radius:Float = 90, ?baseGraphic:Null<FlxGraphicAsset>, ?thumbGraphic:Null<FlxGraphicAsset>) {
		super(x, y);
		
		base = new FlxSprite(0, 0, baseGraphic);
		if (baseGraphic == null) {
			base.frames = Paths.getFrame('ui/virtual-input', 'packer');
			base.animation.frameName = 'base';
			base.resetSizeFromFrame();
		}
		base.moves = false;
		add(base);
		
		thumb = new FlxSprite(0, 0, thumbGraphic);
		if (thumbGraphic == null) {
			thumb.frames = Paths.getFrame('ui/virtual-input', 'packer');
			thumb.animation.frameName = 'thumb';
			thumb.resetSizeFromFrame();
		}
		thumb.moves = false;
		add(thumb);
		
		this.radius = Radius;
	}
	
	var _touched:Bool = false;
	public override function update(elapsed:Float) {
		super.update(elapsed);
		
		if (FlxG.mouse.justPressed && FlxG.mouse.overlaps(base, cameras[0])) {
			_touched = true;
		} else if (FlxG.mouse.justReleased) {
			_touched = false;
		}
		
		if (_touched) {
			var touchPoint:FlxPoint = FlxG.mouse.getScreenPosition(base, cameras[0]);
			var dx:Float = _touchPoint.x - base.x - (base.width / 2);
			var dy:Float = _touchPoint.y - base.y - (base.height / 2);
			var dist:Float = Math.sqrt(dx * dx + dy * dy);
			if (dist < 1) dist = 0;
			
			direction = Math.atan2(dy, dx);
			amount = Math.min(radius, dist) / radius;
			
			thumb.x = x + (base.width / 2) + Math.cos(direction) * amount * radius - (thumb.width / 2);
			thumb.x = y + (base.height / 2) + Math.sin(direction) * amount * radius - (thumb.height / 2);
		} else {
			thumb.x = base.x + (base.width - thumb.width) / 2;
			thumb.y = base.y + (base.height - thumb.height) / 2;
			direction = 0;
			amount = 0;
		}
	}
	
	private function get_stickX(v:Int):Int {
		return Math.round(Math.cos(direction) * amount);
	}

	private function get_stickY(v:Int):Int {
		return Math.round(Math.sin(direction) * amount);
	}
}