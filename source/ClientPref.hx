package;

import Controls;
import flixel.FlxG;
import flixel.graphics.FlxGraphic;
import flixel.input.keyboard.FlxKey;
import flixel.util.FlxSave;

class ClientPref
{
	public static var controllerMode:Bool = false;

	public static var camZooms:Bool = true;

	public static var noteOffset:Int = 0;

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
	public static var middleScroll:Bool = false;
	public static var downScroll:Bool = false;
	public static var noteRainbow:Bool = true;
	public static var customArrowColors_allChars:Bool = false;
	public static var changesides:Bool = false;

	public static var opponentStrums:Bool = false;

	public static function loadDefaultKeys()
	{
		defaultKeys = keyBinds.copy();
	}

	public static function saveSettings()
	{
		FlxG.save.data.globalAntialiasing = globalAntialiasing;
		FlxG.save.data.ghostTapping = ghostTapping;


		var save:FlxSave = new FlxSave();
		save.bind('controls',
			CoolUtil.getSavePath()); // Placing this in a separate save so that it can be manually deleted without removing your Score and stuff
		save.data.customControls = keyBinds;
		save.flush();
		FlxG.log.add("Settings saved!");
		FlxG.save.data.middleScroll = middleScroll;
		FlxG.save.data.downScroll = downScroll;
		FlxG.save.data.noteRainbow = noteRainbow;
		FlxG.save.data.customArrowColors_allChars = customArrowColors_allChars;
		FlxG.save.data.changesides = changesides;
		FlxG.save.data.camZooms = camZooms;
		FlxG.save.data.opponentStrums = opponentStrums;
	}

	public static function loadPrefs()
	{
		if (FlxG.save.data.camZooms != null)
		{
			camZooms = FlxG.save.data.camZooms;
		}
		if (FlxG.save.data.globalAntialiasing != null)
		{
			globalAntialiasing = FlxG.save.data.globalAntialiasing;
		}
		if (FlxG.save.data.ghostTapping != null)
		{
			ghostTapping = FlxG.save.data.ghostTapping;
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
		if (FlxG.save.data.noteRainbow != null)
		{
			noteRainbow = FlxG.save.data.noteRainbow;
		}
		if (FlxG.save.data.customArrowColors_allChars != null)
		{
			customArrowColors_allChars = FlxG.save.data.customArrowColors_allChars;
		}
		if (FlxG.save.data.changesides != null)
		{
			changesides = FlxG.save.data.changesides;
		}
		if (FlxG.save.data.opponentStrums != null)
		{
			opponentStrums = FlxG.save.data.opponentStrums;
		}	
	}

	public static function reloadControls()
	{
		PlayerSettings.player1.controls.setKeyboardScheme(KeyboardScheme.Solo);
	}

	public static function copyKey(arrayToCopy:Array<FlxKey>):Array<FlxKey>
	{
		var copiedArray:Array<FlxKey> = arrayToCopy.copy();
		var i:Int = 0;
		var len:Int = copiedArray.length;

		while (i < len)
		{
			if (copiedArray[i] == NONE)
			{
				copiedArray.remove(NONE);
				--i;
			}
			i++;
			len = copiedArray.length;
		}
		return copiedArray;
	}
}
