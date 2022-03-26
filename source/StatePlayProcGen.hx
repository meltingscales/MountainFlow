package;

import entity.Coin;
import entity.Item;
import entity.MagicPoof;
import entity.Player;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxPoint;
import flixel.text.FlxText;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import flixel.util.FlxSpriteUtil;
import ui.HUDInventory;

class StatePlayProcGen extends FlxState
{
	// you!
	var player:Player;

	// entities
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var items:FlxTypedGroup<Item>;

	// debug line
	var line:FlxSprite;

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

		this.line = new FlxSprite();
		line.makeGraphic(FlxG.width, FlxG.height, 0);
		add(this.line);

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
			var drop = null;
			// drop = TilesProcGen.getTileDrop(tileUnder);
			// trace("we would get this as a drop: " + drop.name);

			var center = player.getMidpoint();
			var endPoint = player.getPointInFrontOfMe();
			trace("casting a ray from " + center + " to " + endPoint);

			var collidePoint = FlxPoint.get(); // we are passing this by reference...
			var didHitTile = !(walls.ray(center, endPoint, collidePoint));

			FlxSpriteUtil.fill(line, 0);
			FlxSpriteUtil.drawLine(line, center.x, center.y, endPoint.x, endPoint.y, {thickness: 2, color: FlxColor.BLUE});

			trace("didHitTile = " + didHitTile);
			if (didHitTile || true)
			{
				// debug since collisions dont work, just pretend the tile in front of us is the collision
				if (!(didHitTile))
				{
					collidePoint.copyFrom(endPoint);
				}

				FlxSpriteUtil.drawLine(line, center.x, center.y, collidePoint.x, collidePoint.y, {thickness: 2, color: FlxColor.RED});
				trace("    hitLocation = " + collidePoint);
				var hx = Std.int(collidePoint.x / 16);
				var hy = Std.int(collidePoint.y / 16);
				var tileThatGotHit = walls.getTile(hx, hy);
				trace("    tileThatGotHit = " + tileThatGotHit);

				drop = TilesProcGen.getTileDrop(tileThatGotHit);

				if (drop != null)
				{
					// if something actually got dropped, delete the tile...
					var replacementTile = TilesProcGen.getTileReplacement(tileThatGotHit);
					if (replacementTile != null)
					{
						// TODO replace tile...
					}

					// show player feedback that an item dropped

					drop.x = hx;
					drop.y = hy;

					// drop.x += (1 * Settings.TILE_WIDTH); // offset it a little so we don't immediately pick it up
					// drop.y += (1 * Settings.TILE_HEIGHT); // offset it a little so we don't immediately pick it up

					for (_ in 1...4)
					{
						add(new MagicPoof(drop.x, drop.y));
					}

					items.add(drop);
				}
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
