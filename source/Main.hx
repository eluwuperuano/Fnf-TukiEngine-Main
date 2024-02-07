package;

import openfl.events.Event;
import openfl.Lib;
import lime.app.Application;
import haxe.io.Path;
import sys.io.File;
import sys.FileSystem;
import haxe.CallStack;
import haxe.CallStack.StackItem;
import openfl.events.UncaughtErrorEvent;
import flixel.util.FlxColor;
import openfl.utils.Assets;
import haxe.Json;
import flixel.system.FlxSplash;
import flixel.FlxGame;
import openfl.display.FPS;
import openfl.display.Sprite;
import openfl.display.StageScaleMode;

using StringTools;

class Main extends Sprite
{
	var data:YourConfig = cast Json.parse(Assets.getText(Paths.getPreloadPath('data/yourConfig.json')));
	var game = {
		width: 1280, // WINDOW width
		height: 720, // WINDOW height
		initialState: TitleState, // initial game state
		zoom: -1.0, // game state bounds
		framerate: 60, // default framerate
		skipSplash: true, // if the default flixel splash screen should be skipped
		startFullscreen: false // if the game should start at fullscreen mode
	};

	public static var fpsVar:FPS;

	public function new()
	{
		super();

		if (stage != null)
		{
			init();
		} else {
			addEventListener(Event.ADDED_TO_STAGE, init);
		}
	}

	private function init(?E:Event):Void {
		if (hasEventListener(Event.ADDED_TO_STAGE))
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
		}

		_game();
	}

	private function _game():Void 
	{

		game.width = data.anchura; // WINDOW width
		game.height = data.altura; // WINDOW height
		game.initialState = TitleState; // initial game state
		game.zoom = -1.0; // game state bounds
		game.framerate = data.framerate; // default framerate
		game.skipSplash = data.skipIntro; // if the default flixel splash screen should be skipped
		game.startFullscreen = data.fullScreen; // if the game should start at fullscreen mode

		var stageWidth:Int = Lib.current.stage.stageWidth;
		var stageHeight:Int = Lib.current.stage.stageHeight;

		if (game.zoom == -1.0)
		{
			var ratioX:Float = stageWidth / game.width;
			var ratioY:Float = stageHeight / game.height;
			game.zoom = Math.min(ratioX, ratioY);
			game.width = Math.ceil(stageWidth / game.zoom);
			game.height = Math.ceil(stageHeight / game.zoom);
		}

		ClientPref.loadDefaultKeys();
		addChild(new FlxGame(
			game.width,
			game.height,
			game.initialState,
			#if (flixel < "5.0.0")
			game.zoom,
			#end
			game.framerate,
			game.framerate,
			game.skipSplash,
			game.startFullscreen
		));

		#if !mobile
			fpsVar = new FPS(10, 3, FlxColor.fromString(data.fpsColor));
			addChild(fpsVar);
			Lib.current.stage.align = "tl";
			Lib.current.stage.scaleMode = StageScaleMode.NO_SCALE;
		#end

		#if html5
		FlxG.autoPause = false;
		FlxG.mouse.visible = false;
		#end

		#if CRASH_HANDLER
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
		#end
	}

	#if CRASH_HANDLER
	function onCrash(e:UncaughtErrorEvent):Void {
		var errMsg:String = "";
		var path:String;
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();

		dateNow = dateNow.replace(" ", "_");
		dateNow = dateNow.replace(":", "'");

		path = "./crash/" + "Engine_" + dateNow + ".txt";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += "\nError: " + e.error + "\nEste error puede ser algo peligroso reportalo en GameBanana> \nCrash Handler written by: sqirra-rng \noriginal code by: Shadow Mario";

		if (!FileSystem.exists("./crash/"))
			FileSystem.createDirectory("./crash/");

		File.saveContent(path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash saved in" + Path.normalize(path));

		Application.current.window.alert(errMsg, "Error!");
		Sys.exit(1);
	}
	#end

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