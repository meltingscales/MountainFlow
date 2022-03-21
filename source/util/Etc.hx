package util;

import haxe.Exception;

final class Etc
{
	public static function assert(thing)
	{
		if (!thing)
		{
			throw new Exception("AssertionError!");
		}
	}
}
