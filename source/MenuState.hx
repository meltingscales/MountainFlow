package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	function clickDungeons()
	{
		FlxG.switchState(new PlayDungeonsState());
	}

	function clickProcGen()
	{
		FlxG.switchState(new PlayProcGenState());
	}

	override public function create()
	{
		super.create();

		var dungeonsButton = new FlxButton(0, 0, "Da Dungeon landz", clickDungeons);
		dungeonsButton.screenCenter();
		dungeonsButton.width *= 1.5;
		dungeonsButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(dungeonsButton);

		var procGenButton = new FlxButton(0, 0, "Da ProcGen landz", clickProcGen);
		procGenButton.screenCenter();
		procGenButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		// le shifty da button down
		procGenButton.y += (dungeonsButton.height * 2);
		procGenButton.width *= 2;
		add(procGenButton);

		var helpText = new FlxText(10, 10, "Instructions:
Use WASD/arrows and Z/X/SPACE :3c");
		// helpText.screenCenter();
		add(helpText);
	}

	override public function update(gameTickElapsed:Float)
	{
		super.update(gameTickElapsed);
	}
}
