import flixel.tile.FlxTilemap;

// stores tile info
class ProcGenTiles
{
	public static var VOID = 0;
	public static var FLOOR = 1;
	public static var NORMAL_DUNGEON = 2;
	public static var BURNT_DUNGEON = 3;
	public static var FLOOR_DIRT = 4;
	public static var DIRT = 5;

	public static function setAllTileProperties(walls:FlxTilemap)
	{
		walls.setTileProperties(ProcGenTiles.VOID, NONE); // air
		walls.setTileProperties(ProcGenTiles.FLOOR, NONE); // floor
		walls.setTileProperties(ProcGenTiles.NORMAL_DUNGEON, ANY); // normal tile
		walls.setTileProperties(ProcGenTiles.BURNT_DUNGEON, ANY); // burnt tile
		walls.setTileProperties(ProcGenTiles.FLOOR_DIRT, NONE);
	}
}
