package util;

import flixel.math.FlxPoint;
import flixel.util.FlxDirection;
import flixel.util.FlxDirectionFlags;

final class IHateMath
{
	public static function angleOfTheDangle(up:Bool, down:Bool, left:Bool, right:Bool):Float
	{
		var angle:Float = 0;
		if (up)
		{
			angle = -90;
			if (left)
			{
				angle -= 45;
			}
			else if (right)
			{
				angle += 45;
			}
		}
		else if (down)
		{
			angle = 90;
			if (left)
			{
				angle += 45;
			}
			else if (right)
			{
				angle -= 45;
			}
		}
		else if (left)
		{
			angle = 180;
		}
		else if (right)
		{
			angle = 0;
		}
		return angle;
	}

	public static final DIRECTION_POINT_MAP = [
		LEFT => new FlxPoint(-1, 0),
		RIGHT => new FlxPoint(1, 0),
		UP => new FlxPoint(0, -1),
		DOWN => new FlxPoint(0, 1)
	];

	public static function directionToPoint(direction:FlxDirectionFlags)
	{
		return DIRECTION_POINT_MAP[direction].copyTo(new FlxPoint());
	}
}
