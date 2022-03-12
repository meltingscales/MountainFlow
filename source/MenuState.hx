package;

import flixel.FlxG;
import flixel.FlxState;
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
		var playButton:FlxButton;

		playButton = new FlxButton(0, 0, "Play da game bro", clickPlay);
		playButton.screenCenter();
		add(playButton);
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);
	}
}
