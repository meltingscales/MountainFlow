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

	var inventoryHotbar:Array<Item>;

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
		this.inventoryHotbar = new Array();

		background = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.BLACK);
		background.drawRect(0, 19, FlxG.width, 1, FlxColor.WHITE);

		inventoryText = new FlxText((Settings.TILE_WIDTH * 1), (Settings.TILE_HEIGHT * 3), 0, "[Empty inventory]", 8);
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

		// clear out old items
		for (item in this.inventoryHotbar)
		{
			// item.kill();
			item.destroy();
		}

		this.inventoryHotbar = new Array();

		// render new items
		var i = 0;
		for (itemid in this.inventory.set_of_itemID())
		{
			var item = Items.by_id(itemid);
			trace("Should UI render item " + item.prettyPrint());

			item.scrollFactor.set(0, 0); // NEEDED so we render as a "static" non moving layer
			item.allowCollisions = NONE; // it's a ui elt, shouldn't be picked up
			item.x = (i * (Settings.TILE_WIDTH + 4));
			item.y = 8;

			add(item);
			inventoryHotbar.push(item);
			i += 1;
		}
	}
}
