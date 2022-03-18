import entity.Item;
import entity.Items;
import flixel.tile.FlxTilemap;

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

	public static function getTileDrop(id:Int):Item
	{
		var drops = [FLOOR_GRASS => Items.Stick(), BLOCK_DIRT => Items.DirtGlob()];

		return drops.get(id);
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
