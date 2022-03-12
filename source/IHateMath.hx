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
}
