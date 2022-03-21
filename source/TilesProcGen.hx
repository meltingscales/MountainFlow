import entity.Item;
import entity.Items.*;
import flixel.tile.FlxTilemap;
import haxe.macro.Expr.Function;

// stores tile info
class TilesProcGen
{
	public static var VOID = 0;
	public static var FLOOR = 1;
	public static var NORMAL_DUNGEON = 2;
	public static var BURNT_DUNGEON = 3;
	public static var FLOOR_GRASS = 4;
	public static var BLOCK_DIRT = 5;
	public static var BLOCK_ORE_1 = 6;
	public static var BLOCK_ORE_2 = 7;

	public static var DROP_FUNCS = [
		FLOOR_GRASS => Stick,
		BLOCK_DIRT => DirtGlob,
		BLOCK_ORE_1 => OreChunk1,
		NORMAL_DUNGEON => OreChunk1,
		FLOOR => OreChunk1,
		BLOCK_ORE_2 => OreChunk2
	];

	public static function getTileDrop(id:Int):Item
	{
		// if it has a drop for a specific tile ID
		if (DROP_FUNCS.exists(id))
		{
			// get the fn
			var fn = DROP_FUNCS[id];

			// exec and return value
			return fn();
		}

		return null;
	}

	public static function setAllTileProperties(walls:FlxTilemap)
	{
		walls.setTileProperties(VOID, NONE); // air
		walls.setTileProperties(FLOOR, NONE); // floor
		walls.setTileProperties(NORMAL_DUNGEON, ANY); // normal tile
		walls.setTileProperties(BURNT_DUNGEON, ANY); // burnt tile

		walls.setTileProperties(FLOOR_GRASS, NONE);
		walls.setTileProperties(BLOCK_DIRT, ANY);
		walls.setTileProperties(BLOCK_ORE_1, ANY);
		walls.setTileProperties(BLOCK_ORE_2, ANY);
	}
}
