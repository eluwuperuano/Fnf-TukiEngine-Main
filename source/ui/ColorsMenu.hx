package ui;

import flixel.ui.FlxButton;
import flixel.addons.ui.FlxUIInputText;
import flixel.FlxSprite;
import flixel.FlxG;
import flixel.addons.effects.chainable.FlxEffectSprite;
import flixel.addons.effects.chainable.FlxOutlineEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.util.FlxColor;

class ColorsMenu extends MusicBeatState
{
	var curSelected:Int = 0;

	public function new()
	{
		super();

		var fondoChingon:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuDesat'));
		fondoChingon.color = FlxColor.fromRGB(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255));
		fondoChingon.screenCenter();
		fondoChingon.antialiasing = true;
		add(fondoChingon);
	}

	override function update(elapsed:Float)
	{
		if (FlxG.keys.justPressed.ESCAPE)
			{
				LoadingState.loadAndSwitchState(new OptionsState());
				FlxG.mouse.visible = false;
			}

		super.update(elapsed);
	}
}
