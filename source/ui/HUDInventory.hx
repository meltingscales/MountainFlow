package ui;

import entity.Item;
import entity.Items;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.text.FlxText;
import flixel.ui.FlxButton;
import flixel.util.FlxColor;
import model.Inventory;

using flixel.util.FlxSpriteUtil;

class HUDInventory extends FlxTypedGroup<FlxSprite>
{
	var background:FlxSprite;
	var inventoryText:FlxText;

	var inventoryHotbarItems:Array<Item>;
	var inventoryHotbarNumbers:Array<FlxText>;
	var inventoryHotbarDropButtons:Array<FlxButton>;

	var isOpen:Bool;
	var inventory:Inventory;

	public function toggleVisible()
	{
		this.isOpen = !this.isOpen;

		if (this.isOpen)
		{
			// do something
		}
		else
		{
			// do something else
		}
	}

	public function new(inv:Inventory)
	{
		super();

		this.inventory = inv;

		this.inventoryHotbarItems = new Array();
		this.inventoryHotbarNumbers = new Array();

		background = new FlxSprite().makeGraphic(FlxG.width, 20, FlxColor.GRAY);
		background.drawRect(0, 19, FlxG.width, 1, FlxColor.PURPLE);

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
		for (item in this.inventoryHotbarItems)
		{
			item.destroy();
		}

		for (text in this.inventoryHotbarNumbers)
		{
			text.destroy();
		}

		this.inventoryHotbarItems = new Array();
		this.inventoryHotbarNumbers = new Array();

		// render new items
		var i = 0;
		var sorted_by_itemid = this.inventory.sorted_by_itemID();
		for (itemid in this.inventory.set_of_itemID())
		{
			var item = Items.by_id(itemid);

			item.scrollFactor.set(0, 0); // NEEDED so we render as a "static" non moving layer
			item.allowCollisions = NONE; // it's a ui elt, shouldn't be picked up
			item.x = (i * (Settings.TILE_WIDTH + 4));
			item.y = 0;

			var numItems = sorted_by_itemid.get(item.itemId).length;
			trace('Should UI render item ${item.prettyPrint()}. We have $numItems of it.');

			add(item);
			inventoryHotbarItems.push(item);

			var text = new FlxText();
			text.scrollFactor.set(0, 0);
			text.text = '${numItems}';

			text.x = item.x;
			text.y = item.y;

			text.x += 4;
			text.y += 4;

			add(text);
			inventoryHotbarNumbers.push(text);

			i += 1;
		}
	}
}
