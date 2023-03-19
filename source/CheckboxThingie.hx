package;

import flixel.FlxSprite;

class CheckboxThingie extends FlxSprite
{
	public var daValue(default, set):Bool;
	public var sprTracker:FlxSprite;
	public var copyAlpha:Bool = true;
	public var offsetX:Float = 0;
	public var offsetY:Float = 0;

	public function new(x:Float, y:Float, ?checked = false)
	{
		super(x, y);

		frames = Paths.getSparrowAtlas('checkboxThingie');
		animation.addByPrefix('static', 'Check Box unselected', 24, false);
		animation.addByPrefix('checked', 'Check Box selecting animation', 24, false);

		antialiasing = true;
		setGraphicSize(Std.int(0.9 * width));
		updateHitbox();

		animationFinished(checked ? 'checked' : 'static');
		animation.finishCallback = animationFinished;
		daValue = checked;
	}

	override function update(elapsed:Float) {
		if (sprTracker != null) {
			setPosition(sprTracker.x - 130 + offsetX, sprTracker.y + 30 + offsetY);
			if(copyAlpha) {
				alpha = sprTracker.alpha;
			}
		}
		super.update(elapsed);
	}

	private function set_daValue(check:Bool):Bool {
		if(check) {
			if(animation.curAnim.name != 'checked' && animation.curAnim.name != 'checked') {
				animation.play('checked', true);
				offset.set(34, 100);
			}
		} else if(animation.curAnim.name != 'static' && animation.curAnim.name != 'static') {
			animation.play("static", true);
			offset.set(34, 0);
		}
		return check;
	}

	private function animationFinished(name:String)
	{
		switch(name)
		{
			case 'checked':
				animation.play('checked', true);
				offset.set(3, 12);

			case 'static':
				animation.play('static', true);
				offset.set(3, 12);
		}
	}
}
