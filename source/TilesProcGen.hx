import entity.Item;
import entity.Items.*;
import flixel.tile.FlxTilemap;
import haxe.macro.Expr.Function;

// stores tile info
class TilesProcGen
{
	public static var VOID = 0;
	public static var FLOOR_DUNGEON = 1;
	public static var BLOCK_NORMAL_DUNGEON = 2;
	public static var BLOCK_BURNT_DUNGEON = 3;
	public static var FLOOR_GRASS = 4;
	public static var BLOCK_DIRT = 5;
	public static var BLOCK_ORE_1 = 6;
	public static var BLOCK_ORE_2 = 7;

	public static var DROP_FUNCS = [
		FLOOR_GRASS => Stick,
		BLOCK_DIRT => DirtGlob,
		BLOCK_ORE_1 => OreChunk1,
		BLOCK_ORE_2 => OreChunk2,
		BLOCK_NORMAL_DUNGEON => OreChunk1,
		BLOCK_BURNT_DUNGEON => OreChunk1,
		// FLOOR_DUNGEON => OreChunk1,
	];

	public static var TILE_DESTROY_MAP = [
		BLOCK_DIRT => FLOOR_GRASS,
		BLOCK_ORE_1 => FLOOR_DUNGEON,
		BLOCK_ORE_2 => FLOOR_DUNGEON,
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
		walls.setTileProperties(FLOOR_DUNGEON, NONE); // dungeon floor
		walls.setTileProperties(BLOCK_NORMAL_DUNGEON, ANY); // normal tile
		walls.setTileProperties(BLOCK_BURNT_DUNGEON, ANY); // burnt tile

		walls.setTileProperties(FLOOR_GRASS, NONE);
		walls.setTileProperties(BLOCK_DIRT, ANY);
		walls.setTileProperties(BLOCK_ORE_1, ANY);
		walls.setTileProperties(BLOCK_ORE_2, ANY);
	}

	public static function getTileReplacement(tileID:Int)
	{
		if (TILE_DESTROY_MAP.exists(tileID))
		{
			return TILE_DESTROY_MAP[tileID];
		}
		return null;
	}
}
