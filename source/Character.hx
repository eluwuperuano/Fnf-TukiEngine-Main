package;

import lime.graphics.Image;
import openfl.utils.Assets;
import haxe.Json;
import Section.SwagSection;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.animation.FlxBaseAnimation;
import flixel.graphics.frames.FlxAtlasFrames;
import flixel.util.FlxColor;
import flixel.util.FlxSort;
import haxe.io.Path;

using StringTools;

class Character extends FlxSprite
{
	public var animOffsets:Map<String, Array<Dynamic>>;
	public var debugMode:Bool = false;

	public var isPlayer:Bool = false;
	public var curCharacter:String = DEFAULT_CHARACTER;
	public var barColor:String = '#FFFFFF';
	public var notesColor:Array<String> = ['#FFFFFF', '#FFFFFF', '#FFFFFF', '#FFFFFF'];

	public var healthIcon:String = 'face';
	public var holdTimer:Float = 0;
	public var jsonScale:Float = 1;

	public var positionArray:Array<Float> = [0, 0];
	public var camerapos:Array<Float> = [0, 0];
	public var singDuration:Float = 4;

	public var animationNotes:Array<Dynamic> = [];

	public var healthdrain:Bool;

	public static var DEFAULT_CHARACTER:String = 'bf'; //In case a character is missing, it will use BF on its place

	public var notesSkin:String = 'NOTE_assets';
	public var image:String = '';
	public var originalFlipX:Bool = false;
	public var elAntialiasing:Bool = true;
	public var animationsArray:Array<AnimArray> = [];


	public var animIdle:String;

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		//barColor = isPlayer ? 0xFF66FF33 : 0xFFFF0000;
		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			// Character Json
			default:
				//Debug.logInfo('Generating character (${curCharacter}) from JSON data...');
				var characterPath:String = 'characters/' + curCharacter + '.json';
				var spriteType = "sparrow";

				var path:String = Paths.getPreloadPath(characterPath);
				if (!Assets.exists(path))
				{
					path = Paths.getPreloadPath('characters/' + DEFAULT_CHARACTER + '.json'); //If a character couldn't be found, change him to BF just to prevent a crash
				}
		
				// Load the data from JSON and cast it to a struct we can easily read.
				var jsonData = Assets.getText(path);
				/*if (jsonData == null)
				{
					Debug.logError('Failed to parse JSON data for character ${curCharacter}');
					return;
				}*/
		
				var data:CharacterFile = cast Json.parse(jsonData);
		
				if (Assets.exists(Paths.getPath('images/' + data.image + '.txt', TEXT)))
				{
					spriteType = "packer";
				}

				switch (spriteType){
					
					case "packer":
						frames = Paths.getPackerAtlas(data.image);
					
					case "sparrow":
						frames = Paths.getSparrowAtlas(data.image);
				}
				image = data.image;

				antialiasing = data.antialiasing;
		
				flipX = data.flip_x;
				camerapos = data.camerapos;
				positionArray = data.charpos;
				singDuration = data.sing;

				if(data.scale != 1) {
					jsonScale = data.scale;
					setGraphicSize(Std.int(width * jsonScale));
					updateHitbox();
				}

				animationsArray = data.animations;
				if (animationsArray != null && animationsArray.length > 0)
				{
					for (anim in animationsArray)
					{
						var animAnim:String = '' + anim.anim;
						var animName:String = '' + anim.name;
						var animFps:Int = anim.fps;
						var animLoop:Bool = !!anim.loop; //Bruh
						var animIndices:Array<Int> = anim.indices;
		
						if (anim.indices != null && animIndices.length > 0)
						{
							animation.addByIndices(animAnim, animName, animIndices, "", animFps, animLoop);
						}
						else
						{
							animation.addByPrefix(animAnim, animName, animFps, animLoop);
						}

						if(anim.offsets != null && anim.offsets.length > 1) {
							addOffset(anim.anim, anim.offsets[0], anim.offsets[1]);
						}
					}
				} else {
					quickAnimAdd('idle', 'BF idle dance');
				}

				notesColor = [data.note_colors[0], data.note_colors[1], data.note_colors[2], data.note_colors[3]];

				if(data.healthbar_colors != null && data.healthbar_colors.length > 2)	
				    barColor = data.healthbar_colors;

				healthIcon = data.healthicon;

				healthdrain = data.health_drain;
		
				//playAnim(data.startingAnim);

				animIdle = data.startingAnim;
				playAnim(animIdle);

				if (data.note_skin != null && data.note_skin.length > 0)
				    notesSkin = data.note_skin;
		}
		originalFlipX = flipX;
		elAntialiasing = antialiasing;
		

		dance();
		animation.finish();

		if (isPlayer)
		{
			flipX = !flipX;

			// Doesn't flip for BF, since his are already in the right place???|
			if (!curCharacter.startsWith('bf'))
			{
				// var animArray
				var oldRight = animation.getByName('singRIGHT').frames;
				animation.getByName('singRIGHT').frames = animation.getByName('singLEFT').frames;
				animation.getByName('singLEFT').frames = oldRight;

				// IF THEY HAVE MISS ANIMATIONS??
				if (animation.getByName('singRIGHTmiss') != null)
				{
					var oldMiss = animation.getByName('singRIGHTmiss').frames;
					animation.getByName('singRIGHTmiss').frames = animation.getByName('singLEFTmiss').frames;
					animation.getByName('singLEFTmiss').frames = oldMiss;
				}
			}
		}
	}

	public function loadMappedAnims()
	{
		var swagshit = Song.loadFromJson('picospeaker', 'stress');

		var notes = swagshit.notes;

		for (section in notes)
		{
			for (idk in section.sectionNotes)
			{
				animationNotes.push(idk);
			}
		}

		TankmenBG.animationNotes = animationNotes;

		trace(animationNotes);
		animationNotes.sort(sortAnims);
	}

	function sortAnims(val1:Array<Dynamic>, val2:Array<Dynamic>):Int
	{
		return FlxSort.byValues(FlxSort.ASCENDING, val1[0], val2[0]);
	}

	public function quickAnimAdd(name:String, prefix:String)
	{
		animation.addByPrefix(name, prefix, 24, false);
	}

	private function loadOffsetFile(offsetCharacter:String)
	{
		var daFile:Array<String> = CoolUtil.coolTextFile(Paths.file("characters/offets/" + offsetCharacter + "Offsets.txt"));

		for (i in daFile)
		{
			var splitWords:Array<String> = i.split(" ");
			addOffset(splitWords[0], Std.parseInt(splitWords[1]), Std.parseInt(splitWords[2]));
		}
	}

	override function update(elapsed:Float)
	{

		if (!isPlayer)
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			if (holdTimer >= Conductor.stepCrochet * 0.001 * singDuration)
			{
				dance();
				holdTimer = 0;
			}
		}

		/*if (curCharacter.endsWith('-car'))
		{
			// looping hair anims after idle finished
			if (!animation.curAnim.name.startsWith('sing') && animation.curAnim.finished)
				playAnim('idleHair');
		}*/

		switch (curCharacter)
		{
			case 'gf':
				if (animation.curAnim.name == 'hairFall' && animation.curAnim.finished)
					playAnim('danceRight');
			case "pico-speaker":
				// for pico??
				if (animationNotes.length > 0)
				{
					if (Conductor.songPosition > animationNotes[0][0])
					{
						trace('played shoot anim' + animationNotes[0][1]);

						var shootAnim:Int = 1;

						if (animationNotes[0][1] >= 2)
							shootAnim = 3;

						shootAnim += FlxG.random.int(0, 1);

						playAnim('shoot' + shootAnim, true);
						animationNotes.shift();
					}
				}

				if (animation.curAnim.finished)
				{
					playAnim(animation.curAnim.name, false, false, animation.curAnim.numFrames - 3);
				}
		}

		super.update(elapsed);
	}

	private var danced:Bool = false;

	/**
	 * FOR GF DANCING SHIT
	 */
	public function dance()
	{
		if (!debugMode)
		{
			switch (curCharacter)
			{
				case 'gf' | 'gf-christmas' | 'gf-car' | 'gf-pixel' | 'gf-tankmen':
					if (!animation.curAnim.name.startsWith('hair'))
					{
						danced = !danced;

						if (danced)
							playAnim('danceRight');
						else
							playAnim('danceLeft');
					}

				case 'pico-speaker':
				// lol weed
				// playAnim('shoot' + FlxG.random.int(1, 4), true);

				case 'tankman':
					if (!animation.curAnim.name.endsWith('DOWN-alt'))
						playAnim('idle');

				case 'spooky':
					danced = !danced;

					if (danced)
						playAnim('danceRight');
					else
						playAnim('danceLeft');
				default:
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		animation.play(AnimName, Force, Reversed, Frame);

		var daOffset = animOffsets.get(AnimName);
		if (animOffsets.exists(AnimName))
		{
			offset.set(daOffset[0], daOffset[1]);
		}
		else
			offset.set(0, 0);

		if (curCharacter.startsWith('gf'))
		{
			if (AnimName == 'singLEFT')
			{
				danced = true;
			}
			else if (AnimName == 'singRIGHT')
			{
				danced = false;
			}

			if (AnimName == 'singUP' || AnimName == 'singDOWN')
			{
				danced = !danced;
			}
		}
	}

	public function addOffset(name:String, x:Float = 0, y:Float = 0)
	{
		animOffsets[name] = [x, y];
	}

	/*public function addColorsNote(color0:Int, color1:Int, color2:Int, color3:Int)
	{
		if (!isPlayer)
		{
			Note.dadcolorsNote = [color0, color1, color2, color3];
		}
		else
		{
			Note.bfcolorsNote = [color0, color1, color2, color3];
		}
	}*/

	public function addImageCharacter(name:String, library:String = 'shared') {
		var tex = Paths.getSparrowAtlas(name, library);
		frames = tex;
		
	}
}

typedef CharacterFile = {
	var image:String;
	var scale:Float;
	var flip_x:Bool;

	var animations:Array<AnimArray>;
	
	var healthbar_colors:String;
	var note_colors:Array<String>;
	var startingAnim:String;
	var healthicon:String;
	var antialiasing:Bool;
	var note_skin:String;

	var camerapos:Array<Float>;
	var health_drain:Bool;
	var charpos:Array<Float>;
	var sing:Float;
}

typedef AnimArray = {
	var anim:String;
	var name:String;
	var fps:Int;
	var loop:Bool;
	var indices:Array<Int>;
	var offsets:Array<Int>;
}