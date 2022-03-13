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
	var enemies:FlxTypedGroup<Enemy>;

	function checkEnemyVision(enemy:Enemy)
	{
		if (walls.ray(enemy.getMidpoint(), player.getMidpoint()))
		{
			enemy.seesPlayer = true;
			enemy.playerPosition = player.getMidpoint();
		}
		else
		{
			enemy.seesPlayer = false;
		}
	}

	function placeEntities(entity:EntityData)
	{
		var x = entity.x;
		var y = entity.y;

		switch (entity.name)
		{
			case "player":
				player.setPosition(x, y);

			case "monster energy":
				drinks.add(new MonsterEnergy(x + 4, y + 4));

			case "enemy":
				enemies.add(new Enemy(x + 4, y, REGULAR));

			case "boss":
				enemies.add(new Enemy(x + 4, y, BOSS));
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

		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

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

		FlxG.collide(enemies, walls);
		enemies.forEachAlive(checkEnemyVision);
	}

	function playerTouchDrink(player:Player, drink:MonsterEnergy)
	{
		if (player.alive && player.exists && drink.alive && drink.exists)
		{
			drink.kill();
		}
	}
}
