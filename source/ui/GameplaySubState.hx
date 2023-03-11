package ui;

import flixel.addons.ui.FlxUICheckBox;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

using StringTools;

class GameplaySubState extends MusicBeatSubstate
{
	var option1:FlxUICheckBox;

	override function create()
	{
		FlxG.mouse.visible = true;

		var bg:FlxSprite = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		bg.color = FlxColor.fromRGB(FlxG.random.int(0, 255), FlxG.random.int(0, 255), FlxG.random.int(0, 255));
		bg.updateHitbox();
		bg.screenCenter();
		add(bg);

		option1 = new FlxUICheckBox(40, 30, null, null, "ghostTapping", 300);
		option1.name = 'ghotTaping';
		option1.checked = true;
		option1.scale.x = 5;
		option1.scale.y = 5;
		option1.screenCenter(X);
		add(option1);
		ClientPref.ghostTapping == option1.checked;
    }
	

	override function update(elapsed:Float) {
		super.update(elapsed);

		if (controls.BACK)
		{
			FlxG.mouse.visible = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new ui.OptionsState());
		}
	}
}