package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.math.FlxPoint;
import flixel.util.FlxColor;

class Player extends FlxSprite
{
	static inline var SPEED:Float = 200;

	public function new(x:Float = 0, y:Float = 0)
	{
		super(x, y);
		makeGraphic(16, 16, FlxColor.BLUE);
		drag.x = drag.y = 1600;
	}

	override function update(elapsed:Float)
	{
		updateMovement();
		super.update(elapsed);
	}

	function updateMovement()
	{
		var up:Bool = false;
		var down:Bool = false;
		var left:Bool = false;
		var right:Bool = false;

		up = FlxG.keys.anyPressed([UP, W]);
		down = FlxG.keys.anyPressed([DOWN, S]);
		left = FlxG.keys.anyPressed([LEFT, A]);
		right = FlxG.keys.anyPressed([RIGHT, D]);

		if (up && down)
		{
			up = down = false;
		}
		if (left && right)
		{
			left = right = false;
		}

		var isMoving = (up || down || left || right);

		if (isMoving)
		{
			var angle = IHateMath.angleOfTheDangle(up, down, left, right);
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), angle);
		}
	}
}
