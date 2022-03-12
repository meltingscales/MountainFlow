package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.tile.FlxTilemap;

class PlayState extends FlxState
{
	var player:Player;
	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;
	var drinks:FlxTypedGroup<MonsterEnergy>;

	function placeEntities(entity:EntityData)
	{
		if (entity.name == "player")
		{
			player.setPosition(entity.x, entity.y);
		}
		else if (entity.name == "monster energy")
		{
			drinks.add(new MonsterEnergy(entity.x + 4, entity.y + 4));
		}
	}

	override public function create()
	{
		map = new FlxOgmo3Loader(AssetPaths.turnBasedRPG__ogmo, AssetPaths.level1__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();

		walls.setTileProperties(1, NONE);
		walls.setTileProperties(2, ANY);

		add(walls);

		drinks = new FlxTypedGroup<MonsterEnergy>();
		add(drinks);

		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(player);

		FlxG.camera.follow(player, TOPDOWN, 1);

		super.create();

		// var text = new flixel.text.FlxText(0, 0, 0, "use WASD :)", 64);
		// text.screenCenter();
		// add(text);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
		FlxG.collide(player, walls);
		FlxG.overlap(player, drinks, playerTouchDrink);
	}

	function playerTouchDrink(player:Player, drink:MonsterEnergy)
	{
		if (player.alive && player.exists && drink.alive && drink.exists)
		{
			drink.kill();
		}
	}
}
