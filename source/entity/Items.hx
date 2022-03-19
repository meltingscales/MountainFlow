package entity;

import entity.Item;

class Items
{
	static var ID_MONSTER_ENERGY = 0;
	static var ID_STICK = 1;
	static var ID_DIRT_GLOB = 2;
	static var ID_ORE_CHUNK1 = 3;
	static var ID_ORE_CHUNK2 = 3;

	public static function Stick(x = 0, y = 0)
	{
		return new Item(x, y, null, "Stick", ID_STICK);
	}

	public static function MonsterEnergy(x = 0, y = 0)
	{
		return new Item(x, y, null, "Monster Energy", ID_MONSTER_ENERGY);
	}

	public static function DirtGlob(x = 0, y = 0)
	{
		return new Item(x, y, null, "Dirt Glob", ID_DIRT_GLOB);
	}

	public static function OreChunk1(x = 0, y = 0)
	{
		return new Item(x, y, null, "Ore Chunk 1", ID_ORE_CHUNK1);
	}

	public static function OreChunk2(x = 0, y = 0)
	{
		return new Item(x, y, null, "Ore Chunk 2", ID_ORE_CHUNK2);
	}
}
