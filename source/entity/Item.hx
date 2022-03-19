package entity;

import flixel.FlxSprite;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;

class Item extends FlxSprite
{
	public var name:String;
	public var itemId:Int;

	override function kill()
	{
		alive = false;
		FlxTween.tween(this, {alpha: 0, y: y - Settings.TILE_HEIGHT}, 0.33, {
			ease: FlxEase.circOut,
			onComplete: finishKill
		});
	}

	function finishKill(_)
	{
		exists = false;
	}

	public function new(x:Float, y:Float, graphicPath:String = null, name:String = null, itemId:Int = null)
	{
		super(x, y);

		this.name = name;
		this.itemId = itemId;

		if (graphicPath == null)
		{
			graphicPath = AssetPaths.monsterEnergy__png;
		}

		if (name == null)
		{
			this.name = "Monster Energy Drink";
		}

		if (itemId == null)
		{
			this.itemId = 0;
		}

		loadGraphic(graphicPath, false, 8, 8);
	}
}
