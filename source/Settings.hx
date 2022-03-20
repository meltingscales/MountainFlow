package;

import flixel.input.keyboard.FlxKey;

class Settings
{
	public static var VERSION = '1.0.0-alpha';
	public static var NAME = 'MountainFlow';

	public static var TILE_WIDTH = 16;
	public static var TILE_HEIGHT = 16;

	public static var KEYS_MOVE_UP = [UP, W];
	public static var KEYS_MOVE_DOWN = [DOWN, S];
	public static var KEYS_MOVE_LEFT = [LEFT, A];
	public static var KEYS_MOVE_RIGHT = [RIGHT, D];
	public static var KEYS_MOVE_UDLR = [KEYS_MOVE_UP, KEYS_MOVE_DOWN, KEYS_MOVE_LEFT, KEYS_MOVE_RIGHT];
}
