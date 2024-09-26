package objects;

import flixel.animation.FlxAnimation;

class AnimateSprite extends FlxSprite {
	private var offsetMap:Map<String, {x:Int, y:Int}> = new Map();

	public function new(x:Float, y:Float, ?image:String, ?type:String = 'sparrow') {
		new(x, y);
		if (image != null)
			frames = Paths.getFrame(image, type);
	}

	public function setOffset(name:String, x:Int, y:Int) {
		if (animation.getByName(name) != null) {
			offsetMap.set(name, {x: x, y: y});
		}
	}
	
	public function play(name:String, force:Bool = false, reversed:Bool = false, frame:Int = 0) {
		if (animation.getByName(name) != null) {
			if (offsetMap.exists(name)) {
				offses.x = offsetMap.get(name).x;
				offset.y = offsetMap.get(name).y;
			}
			animation.play(name, force, reversed, frame);
		}
	}
	
	//get animation
	public function getAnimationList():Array<FlxAnimation> return animation.getAnimationList();
	public function getNameList():Array<String> return animation.getNameList();
	
	//animation controlling
	public function destroyAnimation() animation.destroyAnimation();
	public function finish() animation.finish();
	public function pause() animation.pause();
	public function randomFrame() animation.randomFrame();
	public function reset() animation.reset();
	public function resume() animation.resume();
	public function reverse() animation.reverse();
	public function stop() animation.stop();
}