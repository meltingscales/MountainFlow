package entity;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class MagicPoof extends FlxSprite
{
	override function kill()
	{
		alive = false;
		var xWiggle = 10;
		var xShift = FlxG.random.int(-xWiggle, xWiggle);
		FlxTween.tween(this, {
			alpha: 0,
			x: x + xShift,
			y: y + 16
		}, 2, {
			ease: FlxEase.circOut,
			onComplete: finishKill
		});
	}

	function finishKill(_)
	{
		exists = false;
	}

	public function new(x:Float, y:Float)
	{
		super(x, y);
		loadGraphic(AssetPaths.smokePuff__png, false, 8, 8);
		this.kill(); // smoke puff dies immediately
	}
}
