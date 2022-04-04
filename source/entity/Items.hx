package entity;

import entity.Item;

class Items
{
	public static var ID_MONSTER_ENERGY = 0;
	public static var ID_STICK = 1;
	public static var ID_DIRT_GLOB = 2;
	public static var ID_ORE_CHUNK1 = 3;
	public static var ID_ORE_CHUNK2 = 4;

	public static var BY_ID_MAP = [
		ID_MONSTER_ENERGY => MonsterEnergy,
		ID_STICK => Stick,
		ID_DIRT_GLOB => DirtGlob,
		ID_ORE_CHUNK1 => OreChunk1,
		ID_ORE_CHUNK2 => OreChunk2,
	];

	public static function by_id(id:Int):Item
	{
		if (BY_ID_MAP.exists(id))
		{
			var fn = BY_ID_MAP[id];
			return fn();
		}
		return null;
	}

	public static function Stick(x = 0, y = 0)
	{
		return new Item(x, y, null, "Stick", ID_STICK);
	}

	public static function MonsterEnergy(x = 0, y = 0)
	{
		return new Item(x, y, AssetPaths.monsterEnergy__png, "Monster Energy", ID_MONSTER_ENERGY);
	}

	public static function DirtGlob(x = 0, y = 0)
	{
		return new Item(x, y, AssetPaths.dirtGlob__png, "Dirt Glob", ID_DIRT_GLOB);
	}

	public static function OreChunk1(x = 0, y = 0)
	{
		return new Item(x, y, AssetPaths.oreChunk1__png, "Ore Chunk 1", ID_ORE_CHUNK1);
	}

	public static function OreChunk2(x = 0, y = 0)
	{
		return new Item(x, y, AssetPaths.oreChunk2__png, "Ore Chunk 2", ID_ORE_CHUNK2);
	}
}
