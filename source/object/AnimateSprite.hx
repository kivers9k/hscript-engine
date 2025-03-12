package object;

import flixel.animation.FlxAnimation;
import flixel.frames.FlxAtlasFrames;

class AnimateSprite extends FlxSprite {
	private var offsetMap:Map<String, FlxPoint> = new Map<String, FlxPoint>();

	public function new(x:Float, y:Float, ?atlas:FlxAtlasFrames = null) {
		super(x, y);
		if (atlas != null) {
			frames = atlas;
		}
	}

	public function setOffset(name:String, x:Int, y:Int) {
		if (animation.getByName(name) != null) {
			if (!offsetMap.exists(name)) {
			    offsetMap.set(name, new FlxPoint(x, y));
			} else {
			    offsetMap.get(name).set(x, y);
			}
		}
	}
	
	public function play(name:String, force:Bool = false, reversed:Bool = false, frame:Int = 0) {
		if (animation.getByName(name) != null) {
			var exist:Bool = offsetMap.exists(name);
			offset.x = exist ? offsetMap.get(name).x : 0;
			offset.y = exist ? offsetMap.get(name).y : 0;
			
			animation.play(name, force, reversed, frame);
		}
	}
	
	//get animation
	public function getAnimationList():Array<FlxAnimation> return animation.getAnimationList();
	public function getNameList():Array<String> return animation.getNameList();
	
	//animation controlling
	public function destroyAnimations() animation.destroyAnimations();
	public function finish() animation.finish();
	public function randomFrame() animation.randomFrame();
	public function stop() animation.stop();
	public function pause() animation.pause();
	public function resets() animation.reset();
	public function resume() animation.resume();
	public function reverse() animation.reverse();
}