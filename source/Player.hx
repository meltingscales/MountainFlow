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

		loadGraphic(AssetPaths.player__png, true, 16, 16);
		setFacingFlip(LEFT, false, false);
		setFacingFlip(RIGHT, true, false);
		animation.add("lr", [3, 4, 3, 5], 6, false);
		animation.add("u", [6, 7, 6, 8], 6, false);
		animation.add("d", [0, 1, 0, 2], 6, false);

		drag.x = drag.y = 1600;

		setSize(8, 8);
		offset.set(4, 4);
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

		var userInputsMoveCmd = (up || down || left || right);

		if (userInputsMoveCmd)
		{
			var angle = IHateMath.angleOfTheDangle(up, down, left, right);
			velocity.set(SPEED, 0);
			velocity.rotate(FlxPoint.weak(0, 0), angle);

			if (up)
				facing = UP;
			else if (down)
				facing = DOWN;
			else if (left)
				facing = LEFT;
			else if (right)
				facing = RIGHT;

			if ((velocity.x != 0 || velocity.y != 0) && touching == NONE)
			{
				switch (facing)
				{
					case LEFT, RIGHT:
						animation.play("lr");
					case UP:
						animation.play("u");
					case DOWN:
						animation.play("d");
					case _:
						"";
				}
			}
		}
	}
}
