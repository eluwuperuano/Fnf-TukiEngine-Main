package;

import Controls;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class ClientPref
{
	public static var globalAntialiasing:Bool = true;

	public static var ghostTapping:Bool = true;

	// Every key has two binds, add your key bind down here and then add your control on options/ControlsSubState.hx and Controls.hx
	public static var keyBinds:Map<String, Array<FlxKey>> = [
		// Key Bind, Name for ControlsSubState
		'note_left' => [A, LEFT],
		'note_down' => [S, DOWN],
		'note_up' => [W, UP],
		'note_right' => [D, RIGHT],
		'ui_left' => [A, LEFT],
		'ui_down' => [S, DOWN],
		'ui_up' => [W, UP],
		'ui_right' => [D, RIGHT],
		'accept' => [SPACE, ENTER],
		'back' => [BACKSPACE, ESCAPE],
		'pause' => [ENTER, ESCAPE],
		'reset' => [R, NONE]
	];
	public static var defaultKeys:Map<String, Array<FlxKey>> = null;

	public static var colorsNote:Int = 0xFFFFFFFF;
	public static var middleScroll:Bool = false;
	public static var downScroll:Bool = false;

	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
	}

	public static function saveSettings()
	{
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.ghostTapping = ghostTapping;
		FlxG.save.data.colorsNote = colorsNote;

		var save:FlxSave = new FlxSave();
		save.bind('controls',
			CoolUtil.getSavePath()); // Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.downScroll = downScroll;
	}

	public static function loadPrefs()
	{
		if (FlxG.save.data.globalAntialiasing != null)
		{
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if (FlxG.save.data.ghostTapping != null)
		{
			ghostTapping = FlxG.save.data.ghostTapping;
		}
		if (FlxG.save.data.colorsNote != null)
		{
			colorsNote = FlxG.save.data.colorsNote;
		}

		var save:FlxSave = new FlxSave();
		save.bind('controls', CoolUtil.getSavePath());
		if (save != null && save.data.customControls != null)
		{
			var loadedControls:Map<String, Array<FlxKey>> = save.data.customControls;
			for (control => keys in loadedControls)
			{
				keyBinds.set(control, keys);
			}
			reloadControls();
		}
		if (FlxG.save.data.middleScroll != null)
		{
			middleScroll = FlxG.save.data.middleScroll;
		}
		if (FlxG.save.data.downScroll != null)
		{
			downScroll = FlxG.save.data.downScroll;
		}
	}

	public static function reloadControls()
	{
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);
	}
}
