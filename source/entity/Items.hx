package entity;

import entity.Item;

class Items
{
	static var ID_MONSTER_NRG = 0;
	static var ID_STICK = 1;
	static var ID_DIRT_GLOB = 2;

	public static function Stick(x = 0, y = 0)
	{
		return new Item(x, y, null, "Stick", ID_STICK);
	}

	public static function MonsterEnergy(x = 0, y = 0)
	{
		return new Item(x, y, null, null, null);
	}

	public static function DirtGlob(x = 0, y = 0)
	{
		return new Item(x, y, null, "Dirt Glob", ID_DIRT_GLOB);
	}
}
