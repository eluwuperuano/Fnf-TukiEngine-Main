package;

import flixel.util.FlxColor;
import openfl.utils.Assets;
import haxe.Json;
import flixel.system.FlxSplash;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;

class Main extends Sprite
{
	var data:YourConfig = cast Json.parse(Assets.getText(Paths.getPreloadPath('data/yourConfig.json')));
	public function new()
	{
		super();
		addChild(new FlxGame(
			data.altura, 
			data.anchura, 
			TitleState, 
			data.framerate, 
			data.framerate, 
			data.skipIntro, 
			data.fullScreen
			));

		#if !mobile
		addChild(new FPS(10, 3, FlxColor.fromString(data.fpsColor)));
		#end
	}

	public static var supportedFileTypes = [
		"hhx",
		"hx",
		"hscript",
		"hsc"];
}
typedef YourConfig = {
	var altura:Int;
	var anchura:Int;
	var framerate:Int;
	var skipIntro:Bool;
	var fullScreen:Bool;
	var fpsColor:String;
}