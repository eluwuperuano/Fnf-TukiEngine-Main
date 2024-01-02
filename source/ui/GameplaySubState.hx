package ui;

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

class GameplaySubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'Gameplay Settings';

		var option:Option = new Option('Ghost Tapping',
			"no misses to press",
			'ghostTapping',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option(
			'Opponent Strums Visible',
			"opponent strums now is invisible",
			'opponentStrums',
			'bool',
			false
		);
		addOption(option);

		super();
	}
}