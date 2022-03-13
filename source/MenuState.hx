package;

import flixel.FlxG;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.ui.FlxButton;

class MenuState extends FlxState
{
	function clickPlay()
	{
		FlxG.switchState(new PlayState());
	}

	override public function create()
	{
		super.create();

		if (FlxG.sound.music == null) // don't restart the music if it's already playing
		{
			FlxG.sound.playMusic(AssetPaths.HaxeFlixel_Tutorial_Game__ogg, 1, true);
		}

		var playButton = new FlxButton(0, 0, "Play da game bro", clickPlay);
		playButton.screenCenter();
		playButton.onUp.sound = FlxG.sound.load(AssetPaths.select__wav);
		add(playButton);

		var helpText = new FlxText(10, 10, "Instructions:
Use WASD and SPACE :3c");
		// helpText.screenCenter();
		add(helpText);
	}

	override public function update(gameTickElapsed:Float)
	{
		super.update(gameTickElapsed);
	}
}
