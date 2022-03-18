package entity;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Item extends FlxSprite
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

	public function new(x:Float, y:Float, graphicPath:String = null)
	{
		super(x, y);

		if (graphicPath == null)
		{
			graphicPath = AssetPaths.monsterEnergy__png;
		}

		loadGraphic(graphicPath, false, 8, 8);
	}
}
