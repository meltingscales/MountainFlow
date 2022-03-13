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

		var playButton = new FlxButton(0, 0, "Play da game bro", clickPlay);
		playButton.screenCenter();
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
