package ui;

import entity.Item;
import entity.Items;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import model.Inventory;

using flixel.util.FlxSpriteUtil;

class HUDInventory extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var inventoryText:FlxText;

	// var inventoryTiles:
	var isOpen:Bool;
	var inventory:Inventory;

	public function toggleVisible()
	{
		this.isOpen = !this.isOpen;
	}

	public function new(inv:Inventory)
	{
		super();

		this.inventory = inv;

		background = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
		background.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);

		inventoryText = new FlxText(16, 2, 0, "[Empty inventory]", 8);
		inventoryText.setBorderStyle(SHADOW, FlxColor.GRAY, 1, 1);

		add(background);
		add(inventoryText);

		forEach(function(sprite)
		{
			sprite.scrollFactor.set(0, 0);
		});
	}

	public function updateHUD()
	{
		inventoryText.text = this.inventory.pretty_print();

		for (itemid in this.inventory.set_of_itemID())
		{
			var item = Items.by_id(itemid);
			trace("Should UI render item " + item.prettyPrint());

			item.allowCollisions = NONE;
		}
	}
}
