package ui;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

using flixel.util.FlxSpriteUtil;

class HUDInventorySingleItem extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var itemImage:FlxSprite;

	public function new()
	{
		super();
		background = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
		background.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);
	}
}
