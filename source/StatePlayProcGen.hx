package;

import entity.Coin;
import entity.Item;
import entity.MagicPoof;
import entity.Player;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import ui.HUDInventory;

class StatePlayProcGen extends FlxState
{
	// you!
	var player:Player;

	// entities
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var items:FlxTypedGroup<Item>;

	// gooey
	var HUDinventory:HUDInventory;

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);

			case "item":
				items.add(new Item(x + 4, y + 4));

				// case "enemy":
				// 	enemies.add(new Enemy(x + 4, y, REGULAR));

				// case "boss":
				// 	enemies.add(new Enemy(x + 4, y, BOSS));
		}
	}

	override public function create()
	{
		this.map = new FlxOgmo3Loader(AssetPaths.procGenMap__ogmo, AssetPaths.procGenLevel__json);
		this.walls = map.loadTilemap(AssetPaths.procGenTiles__png, "walls");
		walls.follow();
		TilesProcGen.setAllTileProperties(walls);
		add(walls);

		this.items = new FlxTypedGroup<Item>();
		add(items);

		this.player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(player);

		this.HUDinventory = new HUDInventory();
		// helpText.screenCenter();
		add(HUDinventory);

		FlxG.camera.follow(player, TOPDOWN, 1);

		super.create();

		// var text = new flixel.text.FlxText(0, 0, 0, "use WASD :)", 64);
		// text.screenCenter();
		// add(text);
	}

	override public function update(gameTickElapsed:Float)
	{
		FlxG.collide(player, walls);
		FlxG.overlap(player, items, playerTouchItem);

		var spacebar = FlxG.keys.anyJustPressed([SPACE]);

		// test dynamic tilemap updates: when user presses spacebar, they mine a tile
		if (spacebar)
		{
			var x = (player.x / Settings.TILE_WIDTH);
			var y = (player.y / Settings.TILE_WIDTH);

			var xi = Std.int(x);
			var yi = Std.int(y);

			var tx = x * Settings.TILE_WIDTH;
			var ty = y * Settings.TILE_HEIGHT;

			// this is a test -- put the item a bit above so it doesnt get SLORPED up immediately by

			var tileUnder = walls.getTile(xi, yi);
			// trace("under " + x + "," + y + " we get tile " + tileUnder);
			var drop = TilesProcGen.getTileDrop(tileUnder);
			// trace("we would get this as a drop: " + drop.name);

			trace("casting a ray from " + player.getMidpoint() + " to " + player.getPointInFrontOfMe());
			var hitLocation = FlxPoint.get(); // we are passing this by reference...
			var didHitTile = !(walls.ray(player.getMidpoint(), player.getPointInFrontOfMe(), hitLocation));
			trace("didHitTile = " + didHitTile);
			if (didHitTile)
			{
				trace("    hitLocation = " + hitLocation);
				var hx = Std.int(hitLocation.x / 16);
				var hy = Std.int(hitLocation.y / 16);
				var tileThatGotHit = walls.getTile(hx, hy);
				trace("    tileThatGotHit = " + tileThatGotHit);
			}

			if (drop != null)
			{
				// show player feedback that an item dropped
				for (_ in 1...4)
				{
					add(new MagicPoof(tx, ty));
				}

				drop.x = tx;
				drop.y = ty;

				drop.x += (1 * Settings.TILE_WIDTH); // offset it a little so we don't immediately pick it up
				drop.y += (1 * Settings.TILE_HEIGHT); // offset it a little so we don't immediately pick it up

				items.add(drop);
			}
		}

		super.update(gameTickElapsed);
	}

	function playerTouchItem(player:Player, item:Item)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			player.inventory.add(item);
			// trace("just picked up " + item.name);
			item.kill();

			// show player their inventory
			HUDinventory.updateHUD(player.inventory);
		}
	}
}
