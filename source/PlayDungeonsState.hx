package;

import entity.Coin;
import entity.Enemy;
import entity.Player;
import flixel.FlxG;
import flixel.FlxState;
import flixel.addons.editors.ogmo.FlxOgmo3Loader;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.system.FlxSound;
import flixel.tile.FlxTilemap;
import flixel.util.FlxColor;
import ui.CombatHUD;
import ui.HUD;

using flixel.util.FlxSpriteUtil;

class PlayDungeonsState extends FlxState
{
	var player:Player;

	var map:FlxOgmo3Loader;
	var walls:FlxTilemap;

	var coinSound:FlxSound;

	var coins:FlxTypedGroup<Coin>;
	var enemies:FlxTypedGroup<Enemy>;

	var hud:HUD;

	var money:Int = 0;
	var health:Int = 3;

	var specialTileX = 33;
	var specialTileY = 18;

	var inCombat:Bool = false;
	var combatHud:CombatHUD;

	var ending:Bool;
	var won:Bool;

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
				coins.add(new Coin(x + 4, y + 4));

			case "enemy":
				enemies.add(new Enemy(x + 4, y, REGULAR));

			case "boss":
				enemies.add(new Enemy(x + 4, y, BOSS));
		}
	}

	override public function create()
	{
		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game__ogg, 1, true);
		}

		map = new FlxOgmo3Loader(AssetPaths.turnBasedRPG__ogmo, AssetPaths.level1__json);
		walls = map.loadTilemap(AssetPaths.tiles__png, "walls");
		walls.follow();

		// test to see if we can programmatically set tiles
		walls.setTile(specialTileX, specialTileY, 3);

		walls.setTileProperties(Tiles.VOID, NONE); // air
		walls.setTileProperties(Tiles.FLOOR, NONE); // floor
		walls.setTileProperties(Tiles.NORMAL_DUNGEON, ANY); // normal tile
		walls.setTileProperties(Tiles.BURNT_DUNGEON, ANY); // burnt tile

		add(walls);

		coins = new FlxTypedGroup<Coin>();
		add(coins);

		coinSound = FlxG.sound.load(AssetPaths.coin__wav);

		enemies = new FlxTypedGroup<Enemy>();
		add(enemies);

		player = new Player();
		map.loadEntities(placeEntities, "entities");
		add(player);

		FlxG.camera.follow(player, TOPDOWN, 1);

		hud = new HUD();
		add(hud);

		combatHud = new CombatHUD();
		add(combatHud);

		super.create();

		// var text = new flixel.text.FlxText(0, 0, 0, "use WASD :)", 64);
		// text.screenCenter();
		// add(text);
	}

	override public function update(gameTickElapsed:Float)
	{
		if (inCombat)
		{
			if (!combatHud.visible)
			{
				health = combatHud.playerHealth;
				hud.updateHUD(health, money);
				if (combatHud.outcome == DEFEAT)
				{
					ending = true;
					FlxG.camera.fade(FlxColor.BLACK, 0.33, false, doneFadeOut);
				}
				else
				{
					if (combatHud.outcome == VICTORY)
					{
						combatHud.enemy.kill();
						if (combatHud.enemy.type == BOSS)
						{
							won = true;
							ending = true;
							FlxG.camera.fade(FlxColor.BLACK, 0.33, false, doneFadeOut);
						}
					}
					else
					{
						combatHud.enemy.flicker();
					}
					inCombat = false;
					player.active = true;
					enemies.active = true;
				}
			}
		}
		else
		{
			var spacebar = FlxG.keys.anyJustPressed([SPACE]);

			// test dynamic tilemap updates: when user presses spacebar, randomize a tile
			if (spacebar)
			{
				walls.setTile(specialTileX, specialTileY, FlxG.random.int(Tiles.VOID, Tiles.BURNT_DUNGEON));
			}

			FlxG.collide(player, walls);
			FlxG.overlap(player, coins, playerTouchCoin);
			FlxG.collide(enemies, walls);
			enemies.forEachAlive(checkEnemyVision);
			FlxG.overlap(player, enemies, playerTouchEnemy);
		}

		super.update(gameTickElapsed);

		if (ending)
		{
			return;
		}
	}

	function startCombat(enemy:Enemy)
	{
		inCombat = true;
		player.active = false;
		enemies.active = false;
		combatHud.initCombat(health, enemy);
	}

	function playerTouchEnemy(player:Player, enemy:Enemy)
	{
		if (player.alive && player.exists && enemy.alive && enemy.exists && !enemy.isFlickering())
		{
			startCombat(enemy);
		}
	}

	function playerTouchCoin(player:Player, coin:Coin)
	{
		if (player.alive && player.exists && coin.alive && coin.exists)
		{
			coin.kill();
			coinSound.play(true);
			money++;
			hud.updateHUD(health, money);
		}
	}

	function doneFadeOut()
	{
		FlxG.switchState(new GameOverState(won, money));
	}
}
