package;

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
	public var curCharacter:String = 'bf';
	public var barColor:FlxColor;

	public var holdTimer:Float = 0;

	public var animationNotes:Array<Dynamic> = [];

	public function new(x:Float, y:Float, ?character:String = "bf", ?isPlayer:Bool = false)
	{
		super(x, y);

		barColor = isPlayer ? 0xFF66FF33 : 0xFFFF0000;
		animOffsets = new Map<String, Array<Dynamic>>();
		curCharacter = character;
		this.isPlayer = isPlayer;

		var tex:FlxAtlasFrames;
		antialiasing = true;

		switch (curCharacter)
		{
			case 'gf':
				// GIRLFRIEND CODE
				addImageCharacter('characters/GF_assets');
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, true);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24, true);

				loadOffsetFile(curCharacter);
				barColor = 0xffA5004D;

					addColorsNote(0xffA5004D, 0xffA5004D, 0xffA5004D, 0xffA5004D);
				

				playAnim('danceRight');

			case 'gf-christmas':
				addImageCharacter('characters/gfChristmas');
				quickAnimAdd('cheer', 'GF Cheer');
				quickAnimAdd('singLEFT', 'GF left note');
				quickAnimAdd('singRIGHT', 'GF Right Note');
				quickAnimAdd('singUP', 'GF Up Note');
				quickAnimAdd('singDOWN', 'GF Down Note');
				animation.addByIndices('sad', 'gf sad', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);
				animation.addByIndices('hairBlow', "GF Dancing Beat Hair blowing", [0, 1, 2, 3], "", 24);
				animation.addByIndices('hairFall', "GF Dancing Beat Hair Landing", [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11], "", 24, false);
				animation.addByPrefix('scared', 'GF FEAR', 24, true);

				loadOffsetFile(curCharacter);
				barColor = 0xffA5004D;

					addColorsNote(0xffA5004D, 0xffA5004D, 0xffA5004D, 0xffA5004D);
				
				playAnim('danceRight');
			case 'gf-tankmen':
				addImageCharacter('characters/gfTankmen');
				animation.addByIndices('sad', 'GF Crying at Gunpoint', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12], "", 24, true);
				animation.addByIndices('danceLeft', 'GF Dancing at Gunpoint', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing at Gunpoint', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				barColor = 0xffA5004D;

					addColorsNote(0xffA5004D, 0xffA5004D, 0xffA5004D, 0xffA5004D);

				loadOffsetFile('gf');
				playAnim('danceRight');

			case 'bf-holding-gf':
				addImageCharacter('characters/bfAndGF');
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singUP', 'BF NOTE UP0');

				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('bfCatch', 'BF catches GF');

				loadOffsetFile(curCharacter);
				barColor = 0xff6800a5;

					addColorsNote(0xffA5004D, 0xFF00E5FF, 0xffA5004D, 0xFFFF0000);

				playAnim('idle');

				flipX = true;

			case 'gf-car':
				addImageCharacter('characters/gfCar');
				animation.addByIndices('singUP', 'GF Dancing Beat Hair blowing CAR', [0], "", 24, false);
				animation.addByIndices('danceLeft', 'GF Dancing Beat Hair blowing CAR', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF Dancing Beat Hair blowing CAR', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24,
					false);
				animation.addByIndices('idleHair', 'GF Dancing Beat Hair blowing CAR', [10, 11, 12, 25, 26, 27], "", 24, true);

				loadOffsetFile(curCharacter);
				barColor = 0xffA5004D;

					addColorsNote(0xffA5004D, 0xffA5004D, 0xffA5004D, 0xffA5004D);

				playAnim('danceRight');

			case 'gf-pixel':
				addImageCharacter('characters/gfPixel');
				animation.addByIndices('singUP', 'GF IDLE', [2], "", 24, false);
				animation.addByIndices('danceLeft', 'GF IDLE', [30, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14], "", 24, false);
				animation.addByIndices('danceRight', 'GF IDLE', [15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29], "", 24, false);

				loadOffsetFile(curCharacter);
				barColor = 0xffA5004D;

					addColorsNote(0xffA5004D, 0xffA5004D, 0xffA5004D, 0xffA5004D);

				playAnim('danceRight');

				setGraphicSize(Std.int(width * PlayState.daPixelZoom));
				updateHitbox();
				antialiasing = false;

			case 'dad':
				// DAD ANIMATION LOADING CODE
				addImageCharacter('characters/DADDY_DEAREST');
				quickAnimAdd('idle', 'Dad idle dance');
				quickAnimAdd('singUP', 'Dad Sing Note UP');
				quickAnimAdd('singRIGHT', 'Dad Sing Note RIGHT');
				quickAnimAdd('singDOWN', 'Dad Sing Note DOWN');
				quickAnimAdd('singLEFT', 'Dad Sing Note LEFT');

				loadOffsetFile(curCharacter);
				barColor = 0xFFaf66ce;

					addColorsNote(0xFFaf66ce, 0xFFaf66ce, 0xFFaf66ce, 0xFFaf66ce);

				playAnim('idle');
			case 'spooky':
				addImageCharacter('characters/spooky_kids_assets');
				quickAnimAdd('singUP', 'spooky UP NOTE');
				quickAnimAdd('singDOWN', 'spooky DOWN note');
				quickAnimAdd('singLEFT', 'note sing left');
				quickAnimAdd('singRIGHT', 'spooky sing right');
				animation.addByIndices('danceLeft', 'spooky dance idle', [0, 2, 6], "", 12, false);
				animation.addByIndices('danceRight', 'spooky dance idle', [8, 10, 12, 14], "", 12, false);

				loadOffsetFile(curCharacter);
				barColor = 0xFFd57e00;

					addColorsNote(0xFFB4B4B4, 0xFFd57e00, 0xFFB4B4B4, 0xFFd57e00);

				playAnim('danceRight');
			case 'mom':
				addImageCharacter('characters/Mom_Assets');
				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');

				loadOffsetFile(curCharacter);
				barColor = 0xFFd8558e;

					addColorsNote(0xFFd8558e, 0xFFd8558e, 0xFFd8558e, 0xFFd8558e);

				playAnim('idle');

			case 'mom-car':
				addImageCharacter('characters/momCar');
				quickAnimAdd('idle', "Mom Idle");
				quickAnimAdd('singUP', "Mom Up Pose");
				quickAnimAdd('singDOWN', "MOM DOWN POSE");
				quickAnimAdd('singLEFT', 'Mom Left Pose');
				// ANIMATION IS CALLED MOM LEFT POSE BUT ITS FOR THE RIGHT
				// CUZ DAVE IS DUMB!
				quickAnimAdd('singRIGHT', 'Mom Pose Left');
				animation.addByIndices('idleHair', "Mom Idle", [10, 11, 12, 13], "", 24, true);

				loadOffsetFile(curCharacter);
				barColor = 0xFFd8558e;

					addColorsNote(0xFFd8558e, 0xFFd8558e, 0xFFd8558e, 0xFFd8558e);

				playAnim('idle');
			case 'monster':
				addImageCharacter('characters/Monster_Assets');
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				loadOffsetFile(curCharacter);
				barColor = 0xFFf3ff6e;

					addColorsNote(0xFFf3ff6e, 0xFFf3ff6e, 0xFFf3ff6e, 0xFFf3ff6e);

				playAnim('idle');
			case 'monster-christmas':
				addImageCharacter('characters/monsterChristmas');
				quickAnimAdd('idle', 'monster idle');
				quickAnimAdd('singUP', 'monster up note');
				quickAnimAdd('singDOWN', 'monster down');
				quickAnimAdd('singLEFT', 'Monster left note');
				quickAnimAdd('singRIGHT', 'Monster Right note');

				loadOffsetFile(curCharacter);
				barColor = 0xFFf3ff6e;

					addColorsNote(0xFFf3ff6e, 0xFFf3ff6e, 0xFFf3ff6e, 0xFFf3ff6e);

				playAnim('idle');
			case 'pico':
				addImageCharacter('characters/Pico_FNF_assetss');
				quickAnimAdd('idle', "Pico Idle Dance");
				quickAnimAdd('singUP', 'pico Up note0');
				quickAnimAdd('singDOWN', 'Pico Down Note0');
				if (isPlayer)
				{
					quickAnimAdd('singLEFT', 'Pico NOTE LEFT0');
					quickAnimAdd('singRIGHT', 'Pico Note Right0');
					quickAnimAdd('singRIGHTmiss', 'Pico Note Right Miss');
					quickAnimAdd('singLEFTmiss', 'Pico NOTE LEFT miss');
				}
				else
				{
					// Need to be flipped! REDO THIS LATER!
					quickAnimAdd('singLEFT', 'Pico Note Right0');
					quickAnimAdd('singRIGHT', 'Pico NOTE LEFT0');
					quickAnimAdd('singRIGHTmiss', 'Pico NOTE LEFT miss');
					quickAnimAdd('singLEFTmiss', 'Pico Note Right Miss');
				}

				quickAnimAdd('singUPmiss', 'pico Up note miss');
				quickAnimAdd('singDOWNmiss', 'Pico Down Note MISS');

				loadOffsetFile(curCharacter);
				barColor = 0xFFb7d855;

					addColorsNote(0xFFb7d855, 0xFFb7d855, 0xFFb7d855, 0xFFb7d855);

				playAnim('idle');

				flipX = true;

			case 'pico-speaker':
				addImageCharacter('characters/picoSpeaker');
				quickAnimAdd('shoot1', "Pico shoot 1");
				quickAnimAdd('shoot2', "Pico shoot 2");
				quickAnimAdd('shoot3', "Pico shoot 3");
				quickAnimAdd('shoot4', "Pico shoot 4");

				// here for now, will be replaced later for less copypaste
				loadOffsetFile(curCharacter);
				barColor = 0xFFb7d855;

					addColorsNote(0xFFb7d855, 0xFFb7d855, 0xFFb7d855, 0xFFb7d855);
				
				playAnim('shoot1');

				loadMappedAnims();

			case 'bf':
				addImageCharacter('characters/BOYFRIEND');
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				quickAnimAdd('firstDeath', "BF dies");
				animation.addByPrefix('deathLoop', "BF Dead Loop", 24, true);
				quickAnimAdd('deathConfirm', "BF Dead confirm");

				animation.addByPrefix('scared', 'BF idle shaking', 24, true);

				loadOffsetFile(curCharacter);

				playAnim('idle');
				barColor = 0xFF31b0d1;

					addColorsNote(0xFFD400FF, 0xFF00E5FF, 0xFF2BFF00, 0xFFFF0000);

				flipX = true;

				loadOffsetFile(curCharacter);

			case 'bf-christmas':
				addImageCharacter('characters/bfChristmas');
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				quickAnimAdd('hey', 'BF HEY');

				loadOffsetFile(curCharacter);

				playAnim('idle');
				barColor = 0xFF31b0d1;

					addColorsNote(0xFFD400FF, 0xFF00E5FF, 0xFF2BFF00, 0xFFFF0000);

				flipX = true;
			case 'bf-car':
				addImageCharacter('characters/bfCar');
				quickAnimAdd('idle', 'BF idle dance');
				quickAnimAdd('singUP', 'BF NOTE UP0');
				quickAnimAdd('singLEFT', 'BF NOTE LEFT0');
				quickAnimAdd('singRIGHT', 'BF NOTE RIGHT0');
				quickAnimAdd('singDOWN', 'BF NOTE DOWN0');
				quickAnimAdd('singUPmiss', 'BF NOTE UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF NOTE LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF NOTE RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF NOTE DOWN MISS');
				animation.addByIndices('idleHair', 'BF idle dance', [10, 11, 12, 13], "", 24, true);

				loadOffsetFile(curCharacter);

				playAnim('idle');
				barColor = 0xFF31b0d1;

					addColorsNote(0xFFD400FF, 0xFF00E5FF, 0xFF2BFF00, 0xFFFF0000);

				flipX = true;
			case 'bf-pixel':
				addImageCharacter('characters/bfPixel');
				quickAnimAdd('idle', 'BF IDLE');
				quickAnimAdd('singUP', 'BF UP NOTE');
				quickAnimAdd('singLEFT', 'BF LEFT NOTE');
				quickAnimAdd('singRIGHT', 'BF RIGHT NOTE');
				quickAnimAdd('singDOWN', 'BF DOWN NOTE');
				quickAnimAdd('singUPmiss', 'BF UP MISS');
				quickAnimAdd('singLEFTmiss', 'BF LEFT MISS');
				quickAnimAdd('singRIGHTmiss', 'BF RIGHT MISS');
				quickAnimAdd('singDOWNmiss', 'BF DOWN MISS');

				loadOffsetFile(curCharacter);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');
				barColor = 0xFF31b0d1;

					addColorsNote(0xFFD400FF, 0xFF00E5FF, 0xFF2BFF00, 0xFFFF9D00);

				width -= 100;
				height -= 100;

				antialiasing = false;

				flipX = true;
			case 'bf-pixel-dead':
				addImageCharacter('characters/bfPixelsDEAD');
				quickAnimAdd('singUP', "BF Dies pixel");
				quickAnimAdd('firstDeath', "BF Dies pixel");
				animation.addByPrefix('deathLoop', "Retry Loop", 24, true);
				quickAnimAdd('deathConfirm', "RETRY CONFIRM");
				animation.play('firstDeath');

				loadOffsetFile(curCharacter);

				playAnim('firstDeath');
				barColor = 0xFF31b0d1;

					addColorsNote(0xFFD400FF, 0xFF00E5FF, 0xFF2BFF00, 0xFFFF9D00);

				// pixel bullshit
				setGraphicSize(Std.int(width * 6));
				updateHitbox();
				antialiasing = false;
				flipX = true;

			case 'bf-holding-gf-dead':
				addImageCharacter('characters/bfHoldingGF-DEAD');
				quickAnimAdd('singUP', 'BF Dead with GF Loop');
				quickAnimAdd('firstDeath', 'BF Dies with GF');
				animation.addByPrefix('deathLoop', 'BF Dead with GF Loop', 24, true);
				quickAnimAdd('deathConfirm', 'RETRY confirm holding gf');

				loadOffsetFile(curCharacter);
				barColor = 0xFF31b0d1;

					addColorsNote(0xFF31b0d1, 0xFF31b0d1, 0xFF31b0d1, 0xFF31b0d1);

				playAnim('firstDeath');

				flipX = true;

			case 'senpai':
				addImageCharacter('characters/senpai');
				quickAnimAdd('idle', 'Senpai Idle');
				// at framerate 16.8 animation plays over 2 beats at 144bpm,
				// but if the game lags or the bpm is > 144 (mods etc.)
				// he may miss his next dance
				// animation.getByName('idle').frameRate = 16.8;

				quickAnimAdd('singUP', 'SENPAI UP NOTE');
				quickAnimAdd('singLEFT', 'SENPAI LEFT NOTE');
				quickAnimAdd('singRIGHT', 'SENPAI RIGHT NOTE');
				quickAnimAdd('singDOWN', 'SENPAI DOWN NOTE');

				loadOffsetFile(curCharacter);
				barColor = 0xFFffaa6f;

					addColorsNote(0xFFffaa6f, 0xFFffaa6f, 0xFFffaa6f, 0xFFffaa6f);

				playAnim('idle');

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;
			case 'senpai-angry':
				addImageCharacter('characters/senpai');
				quickAnimAdd('idle', 'Angry Senpai Idle');
				quickAnimAdd('singUP', 'Angry Senpai UP NOTE');
				quickAnimAdd('singLEFT', 'Angry Senpai LEFT NOTE');
				quickAnimAdd('singRIGHT', 'Angry Senpai RIGHT NOTE');
				quickAnimAdd('singDOWN', 'Angry Senpai DOWN NOTE');

				loadOffsetFile(curCharacter);

				playAnim('idle');
				barColor = 0xFFffaa6f;

					addColorsNote(0xFFffaa6f, 0xFFffaa6f, 0xFFffaa6f, 0xFFffaa6f);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				antialiasing = false;

			case 'spirit':
				frames = Paths.getPackerAtlas('characters/spirit');
				quickAnimAdd('idle', "idle spirit_");
				quickAnimAdd('singUP', "up_");
				quickAnimAdd('singRIGHT', "right_");
				quickAnimAdd('singLEFT', "left_");
				quickAnimAdd('singDOWN', "spirit down_");

				loadOffsetFile(curCharacter);
				barColor = 0xFFff3c6e;

					addColorsNote(0xFFff3c6e, 0xFFff3c6e, 0xFFff3c6e, 0xFFff3c6e);

				setGraphicSize(Std.int(width * 6));
				updateHitbox();

				playAnim('idle');

				antialiasing = false;

			case 'parents-christmas':
				addImageCharacter('characters/mom_dad_christmas_assets');
				quickAnimAdd('idle', 'Parent Christmas Idle');
				quickAnimAdd('singUP', 'Parent Up Note Dad');
				quickAnimAdd('singDOWN', 'Parent Down Note Dad');
				quickAnimAdd('singLEFT', 'Parent Left Note Dad');
				quickAnimAdd('singRIGHT', 'Parent Right Note Dad');

				quickAnimAdd('singUP-alt', 'Parent Up Note Mom');

				quickAnimAdd('singDOWN-alt', 'Parent Down Note Mom');
				quickAnimAdd('singLEFT-alt', 'Parent Left Note Mom');
				quickAnimAdd('singRIGHT-alt', 'Parent Right Note Mom');

				loadOffsetFile(curCharacter);
				barColor = 0xffac40b8;

					addColorsNote(0xffac40b8, 0xffac40b8, 0xffac40b8, 0xffac40b8);

				playAnim('idle');
			case 'tankman':
				addImageCharacter('characters/tankmanCaptain');
				quickAnimAdd('idle', "Tankman Idle Dance");

				if (isPlayer)
				{
					quickAnimAdd('singLEFT', 'Tankman Note Left ');
					quickAnimAdd('singRIGHT', 'Tankman Right Note ');
					quickAnimAdd('singLEFTmiss', 'Tankman Note Left MISS');
					quickAnimAdd('singRIGHTmiss', 'Tankman Right Note MISS');
				}
				else
				{
					// Need to be flipped! REDO THIS LATER
					quickAnimAdd('singLEFT', 'Tankman Right Note ');
					quickAnimAdd('singRIGHT', 'Tankman Note Left ');
					quickAnimAdd('singLEFTmiss', 'Tankman Right Note MISS');
					quickAnimAdd('singRIGHTmiss', 'Tankman Note Left MISS');
				}

				quickAnimAdd('singUP', 'Tankman UP note ');
				quickAnimAdd('singDOWN', 'Tankman DOWN note ');
				quickAnimAdd('singUPmiss', 'Tankman UP note MISS');
				quickAnimAdd('singDOWNmiss', 'Tankman DOWN note MISS');

				// PRETTY GOOD tankman
				// TANKMAN UGH instanc

				quickAnimAdd('singDOWN-alt', 'PRETTY GOOD');
				quickAnimAdd('singUP-alt', 'TANKMAN UGH');

				loadOffsetFile(curCharacter);
				barColor = 0xffE1E1E1;

					addColorsNote(0xffE1E1E1, 0xff6f6f6f, 0xffE1E1E1, 0xff6f6f6f);

				playAnim('idle');

				flipX = true;
		}

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

	function quickAnimAdd(name:String, prefix:String)
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
		if (!curCharacter.startsWith('bf'))
		{
			if (animation.curAnim.name.startsWith('sing'))
			{
				holdTimer += elapsed;
			}

			var dadVar:Float = 4;

			if (curCharacter == 'dad')
				dadVar = 6.1;
			if (holdTimer >= Conductor.stepCrochet * dadVar * 0.001)
			{
				dance();
				holdTimer = 0;
			}
		}

		if (curCharacter.endsWith('-car'))
		{
			// looping hair anims after idle finished
			if (!animation.curAnim.name.startsWith('sing') && animation.curAnim.finished)
				playAnim('idleHair');
		}

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

		if (curCharacter == 'gf')
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

	public function addColorsNote(color0:Int, color1:Int, color2:Int, color3:Int)
	{
		if (!isPlayer)
		{
			Note.dadcolorsNote = [color0, color1, color2, color3];
		}
		else
		{
			Note.bfcolorsNote = [color0, color1, color2, color3];
		}
	}

	public function addImageCharacter(name:String, library:String = 'shared') {
		var tex = Paths.getSparrowAtlas(name, library);
		frames = tex;
		
	}
}