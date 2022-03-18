package;

import entity.Coin;
import entity.Item;
import entity.Player;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class StatePlayProcGen extends FlxState
{
	var player:Player;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var items:FlxTypedGroup<Item>;

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
		map = new FlxOgmo3Loader(AssetPaths.procGenMap__ogmo, AssetPaths.procGenLevel__json);
		walls = map.loadTilemap(AssetPaths.procGenTiles__png, "walls");
		walls.follow();
		TilesProcGen.setAllTileProperties(walls);
		add(walls);

		items = new FlxTypedGroup<Item>();
		add(items);

		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(player);

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

		super.update(gameTickElapsed);
	}

	function playerTouchItem(player:Player, item:Coin)
	{
		if (player.alive && player.exists && item.alive && item.exists)
		{
			item.kill();
			// player.inventory.add(item);
		}
	}
}
