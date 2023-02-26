package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import Controls;

class ClientPref {
	public static var ghostTapping:Bool = true;

    public static function saveSettings() {
            FlxG.save.data.ghostTapping = ghostTapping;
    }
    
    public static function loadPrefs() {
            if(FlxG.save.data.ghostTapping != null) {
                ghostTapping = FlxG.save.data.ghostTapping;
            }
    }
}