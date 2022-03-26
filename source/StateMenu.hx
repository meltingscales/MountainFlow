package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class StateMenu extends FlxState
{
	function clickDungeons()
	{
		FlxG.switchState(new StatePlayDungeons());
	}

	function clickProcGen()
	{
		FlxG.switchState(new StatePlayProcGen());
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

		var helpText = new FlxText(10, 10, "Welcome to "
			+ Settings.NAME
			+ " v"
			+ Settings.VERSION
			+ "\nInstructions:
Use WASD/arrows and Z/X/SPACE
F2/F12 for debug");
		// helpText.screenCenter();
		add(helpText);
	}

	override public function update(gameTickElapsed:Float)
	{
		super.update(gameTickElapsed);
	}
}
