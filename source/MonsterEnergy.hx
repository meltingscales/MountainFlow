package;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class MonsterEnergy extends FlxSprite
{
	override function kill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - 16}, 0.33, {
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
		loadGraphic(AssetPaths.monsterEnergy__png, false, 8, 8);
	}
}
