package;
//import flixel.system.FlxSound;
import flixel.FlxState;
import haxe.Json;
import flixel.util.FlxTimer;
import openfl.utils.Assets;
import flixel.math.FlxAngle;
import flixel.group.FlxGroup;
import flixel.addons.effects.chainable.FlxWaveEffect;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.sound.FlxSound;
import flixel.FlxG;
import flixel.util.FlxColor;
import shaderslmfao.BuildingShaders;
import flixel.FlxSprite;

using StringTools;

#if MODS_ALLOWED
import sys.FileSystem;
import sys.io.File;
#end

class Stages extends MusicBeatState{
    //var another:PlayState;
    public var curStage:String = DEFAULT_STAGE;

	public var danceIdle:Bool = false; //Character use "danceLeft" and "danceRight" instead of "idle"
	public var skipDance:Bool = false;
	public var debugMode:Bool = false;

	var data:StagesJson;


	//stages 
	    //spooky
	    	public var halloweenBG:FlxSprite;
	    //philly
			public var phillybg:BGSprite;
        	public var phillycity:BGSprite;
        	public var streetBehind:BGSprite;
			public var phillyLightsColors:Array<FlxColor>;
			var light:BGSprite;
			public var eventlight:Bool = false;
			public var street:BGSprite;
        	var lightFadeShader:BuildingShaders;
        	var phillyTrain:FlxSprite;
        	var trainSound:FlxSound;
        //limo
			public var limo:BGSprite;
			var grpLimoDancers:FlxTypedGroup<BackgroundDancer>;
			var fastCar:BGSprite;
        //mall
			var upperBoppers:BGSprite;
			var bottomBoppers:BGSprite;
            var santa:BGSprite;
        //shool
	        var bgGirls:BackgroundGirls;
        //school evil    
        //tank
			public var tankmanRun:FlxTypedGroup<TankmenBG>;
            var gfCutsceneLayer:FlxGroup;
            var bfTankCutsceneLayer:FlxGroup;
            var tankWatchtower:BGSprite;
            var tankGround:BGSprite;
            public var foregroundSprites:FlxTypedGroup<BGSprite>;
	//end

	public var obj:FlxSprite;

	public static var DEFAULT_STAGE:String = 'stage';

	public var addFront:String;

    public function new(stageSelec:String) {
        super();
        curStage = stageSelec;

		foregroundSprites = new FlxTypedGroup<BGSprite>();

		phillyLightsColors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];

        switch (curStage)
        {		
			case 'philly':

				phillybg = new BGSprite('philly/sky', -100, 0, 0.1, 0.1);
				phillybg.scrollFactor.set(0.1, 0.1);
				add(phillybg);

				phillycity = new BGSprite('philly/city', -10, 0, 0.3, 0.3);
				phillycity.scrollFactor.set(0.3, 0.3);
				phillycity.setGraphicSize(Std.int(phillycity.width * 0.85));
				phillycity.updateHitbox();
				add(phillycity);

				lightFadeShader = new BuildingShaders();

				phillyLightsColors = [0xFF31A2FD, 0xFF31FD8C, 0xFFFB33F5, 0xFFFD4531, 0xFFFBA633];


					light = new BGSprite('philly/window', phillycity.x, phillycity.y, 0.3, 0.3);
					light.scrollFactor.set(0.3, 0.3);
					light.setGraphicSize(Std.int(light.width * 0.85));
					light.updateHitbox();
					light.antialiasing = true;
					light.alpha = 0;
					add(light);

				streetBehind = new BGSprite('philly/behindTrain', -40, 50);
				add(streetBehind);

				phillyTrain = new BGSprite('philly/train', 2000, 360);
				add(phillyTrain);

				trainSound = new FlxSound().loadEmbedded(Paths.sound('train_passes', 'week3'));
				FlxG.sound.list.add(trainSound);

				// var cityLights:FlxSprite = new FlxSprite().loadGraphic(AssetPaths.win0.png);

				street = new BGSprite('philly/street', -40, 50);
				add(street);

			case 'limo':

				var skyBG:BGSprite = new BGSprite('limo/limoSunset', -120, -50, 0.1, 0.1);
				add(skyBG);

				var bgLimo:BGSprite = new BGSprite('limo/bgLimo', -150, 480, 0.4, 0.4, ['background limo pink'], true);
				add(bgLimo);

				grpLimoDancers = new FlxTypedGroup<BackgroundDancer>();
				add(grpLimoDancers);

				for (i in 0...5)
				{
					var dancer:BackgroundDancer = new BackgroundDancer((370 * i) + 130, bgLimo.y - 400);
					dancer.scrollFactor.set(0.4, 0.4);
					grpLimoDancers.add(dancer);
				}

				var overlayShit:FlxSprite = new FlxSprite(-500, -600).loadGraphic(Paths.image('limo/limoOverlay'));
				overlayShit.alpha = 0.5;
				// add(overlayShit);
				// var shaderBullshit = new BlendModeEffect(new OverlayShader(), FlxColor.RED);
				// FlxG.camera.setFilters([new ShaderFilter(cast shaderBullshit.shader)]);
				// overlayShit.shader = shaderBullshit;

				limo = new BGSprite('limo/limoDrive', -120, 550, 1, 1, ['Limo stage'], true);

				fastCar = new BGSprite('limo/fastCarLol', -300, 160);
			    // add(limo);

			case 'mall':
				
				var bg:BGSprite = new BGSprite('christmas/bgWalls', -1000, -500, 0.2, 0.2);
				bg.setGraphicSize(Std.int(bg.width * 0.8));
				bg.updateHitbox();
				add(bg);

				upperBoppers = new BGSprite('christmas/upperBop', -240, -90, 0.33, 0.33, ['Upper Crowd Bob']);
				upperBoppers.setGraphicSize(Std.int(upperBoppers.width * 0.85));
				upperBoppers.updateHitbox();
				add(upperBoppers);

				var bgEscalator:BGSprite = new BGSprite('christmas/bgEscalator', -1100, -600, 0.3, 0.3);
				bgEscalator.setGraphicSize(Std.int(bgEscalator.width * 0.9));
				bgEscalator.updateHitbox();
				add(bgEscalator);

				var tree:BGSprite = new BGSprite('christmas/christmasTree', 370, -250, 0.40, 0.40);
				add(tree);

				bottomBoppers = new BGSprite('christmas/bottomBop', -300, 140, 0.9, 0.9, ['Bottom Level Boppers Idle']);
				bottomBoppers.setGraphicSize(Std.int(bottomBoppers.width * 1));
				bottomBoppers.updateHitbox();
				add(bottomBoppers);

				var fgSnow:BGSprite = new BGSprite('christmas/fgSnow', -600, 700);
				add(fgSnow);

				santa = new BGSprite('christmas/santa', -840, 150, 1, 1, ['santa idle in fear']);
				add(santa);

			case 'mallEvil':

				var bg:BGSprite = new BGSprite('christmas/evilBG', -400, -500, 0.2, 0.2);
				bg.setGraphicSize(Std.int(bg.width * 0.8));
				bg.updateHitbox();
				add(bg);

				var evilTree:BGSprite = new BGSprite('christmas/evilTree', 300, -300, 0.2, 0.2);
				add(evilTree);

				var evilSnow:BGSprite = new BGSprite('christmas/evilSnow', -200, 700);
				add(evilSnow);
				
			case 'school':

				// defaultCamZoom = 0.9;

				var bgSky:BGSprite = new BGSprite('weeb/weebSky', 0, 0, 0.1, 0.1);
				add(bgSky);
				bgSky.antialiasing = false;

				var repositionShit = -200;

				var bgSchool:BGSprite = new BGSprite('weeb/weebSchool', repositionShit, 0, 0.6, 0.90);
				add(bgSchool);
				bgSchool.antialiasing = false;

				var bgStreet:BGSprite = new BGSprite('weeb/weebStreet', repositionShit, 0, 0.95, 0.95);
				add(bgStreet);
				bgStreet.antialiasing = false;

				var widShit = Std.int(bgSky.width * 6);

					var fgTrees:BGSprite = new BGSprite('weeb/weebTreesBack', repositionShit + 170, 130, 0.9, 0.9);
					fgTrees.setGraphicSize(Std.int(widShit * 0.8));
					fgTrees.updateHitbox();
					add(fgTrees);
					fgTrees.antialiasing = false;

				var bgTrees:FlxSprite = new FlxSprite(repositionShit - 380, -800);
				bgTrees.frames = Paths.getPackerAtlas('weeb/weebTrees');
				bgTrees.animation.add('treeLoop', [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18], 12);
				bgTrees.animation.play('treeLoop');
				bgTrees.scrollFactor.set(0.85, 0.85);
				add(bgTrees);
				bgTrees.antialiasing = false;

					var treeLeaves:BGSprite = new BGSprite('weeb/petals', repositionShit, -40, 0.85, 0.85, ['PETALS ALL'], true);
					treeLeaves.setGraphicSize(widShit);
					treeLeaves.updateHitbox();
					add(treeLeaves);
					treeLeaves.antialiasing = false;

				bgSky.setGraphicSize(widShit);
				bgSchool.setGraphicSize(widShit);
				bgStreet.setGraphicSize(widShit);
				bgTrees.setGraphicSize(Std.int(widShit * 1.4));

				bgSky.updateHitbox();
				bgSchool.updateHitbox();
				bgStreet.updateHitbox();
				bgTrees.updateHitbox();

					bgGirls = new BackgroundGirls(-100, 190);
					bgGirls.scrollFactor.set(0.9, 0.9);

					bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));
					bgGirls.updateHitbox();
					add(bgGirls);

			case 'schoolEvil':

				var waveEffectBG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 3, 2);
				var waveEffectFG = new FlxWaveEffect(FlxWaveMode.ALL, 2, -1, 5, 2);
				var posX = 400;
				var posY = 200;

					var bg:BGSprite = new BGSprite('weeb/animatedEvilSchool', posX, posY, 0.8, 0.9, ['background 2'], true);
					bg.scale.set(6, 6);
					bg.antialiasing = false;
					add(bg);

			case 'tank':
				
				var bg:BGSprite = new BGSprite('tankSky', -400, -400, 0, 0);
				add(bg);

				var tankSky:BGSprite = new BGSprite('tankClouds', FlxG.random.int(-700, -100), FlxG.random.int(-20, 20), 0.1, 0.1);
				tankSky.active = true;
				tankSky.velocity.x = FlxG.random.float(5, 15);
				add(tankSky);

				var tankMountains:BGSprite = new BGSprite('tankMountains', -300, -20, 0.2, 0.2);
				tankMountains.setGraphicSize(Std.int(tankMountains.width * 1.2));
				tankMountains.updateHitbox();
				add(tankMountains);

				var tankBuildings:BGSprite = new BGSprite('tankBuildings', -200, 0, 0.30, 0.30);
				tankBuildings.setGraphicSize(Std.int(tankBuildings.width * 1.1));
				tankBuildings.updateHitbox();
				add(tankBuildings);

				var tankRuins:BGSprite = new BGSprite('tankRuins', -200, 0, 0.35, 0.35);
				tankRuins.setGraphicSize(Std.int(tankRuins.width * 1.1));
				tankRuins.updateHitbox();
				add(tankRuins);

				var smokeLeft:BGSprite = new BGSprite('smokeLeft', -200, -100, 0.4, 0.4, ['SmokeBlurLeft'], true);
				add(smokeLeft);

				var smokeRight:BGSprite = new BGSprite('smokeRight', 1100, -100, 0.4, 0.4, ['SmokeRight'], true);
				add(smokeRight);

				// tankGround.

				tankWatchtower = new BGSprite('tankWatchtower', 100, 50, 0.5, 0.5, ['watchtower gradient color']);
				add(tankWatchtower);

				tankGround = new BGSprite('tankRolling', 300, 300, 0.5, 0.5, ['BG tank w lighting'], true);
				add(tankGround);
				// tankGround.active = false;

				tankmanRun = new FlxTypedGroup<TankmenBG>();
				add(tankmanRun);

				var tankGround:BGSprite = new BGSprite('tankGround', -420, -150);
				tankGround.setGraphicSize(Std.int(tankGround.width * 1.15));
				tankGround.updateHitbox();
				add(tankGround);

				moveTank();

				// smokeLeft.screenCenter();

				var fgTank0:BGSprite = new BGSprite('tank0', -500, 650, 1.7, 1.5, ['fg']);
				foregroundSprites.add(fgTank0);

				var fgTank1:BGSprite = new BGSprite('tank1', -300, 750, 2, 0.2, ['fg']);
				foregroundSprites.add(fgTank1);

				// just called 'foreground' just cuz small inconsistency no bbiggei
				var fgTank2:BGSprite = new BGSprite('tank2', 450, 940, 1.5, 1.5, ['foreground']);
				foregroundSprites.add(fgTank2);

				var fgTank4:BGSprite = new BGSprite('tank4', 1300, 900, 1.5, 1.5, ['fg']);
				foregroundSprites.add(fgTank4);

				var fgTank5:BGSprite = new BGSprite('tank5', 1620, 700, 1.5, 1.5, ['fg']);
				foregroundSprites.add(fgTank5);

				var fgTank3:BGSprite = new BGSprite('tank3', 1300, 1200, 3.5, 2.5, ['fg']);
				foregroundSprites.add(fgTank3);
			default:
				//Debug.logInfo('Generating character (${curCharacter}) from JSON data...');
				var characterPath:String = 'stages/' + curStage + '-OBJS.json';

				#if MODS_ALLOWED
				var path:String = Paths.modFolders(characterPath);
				if (!FileSystem.exists(path))
				{
					path = Paths.getPreloadPath(characterPath);
				}

				if (!FileSystem.exists(path))
				#else
				var path:String = Paths.getPreloadPath(characterPath);
				if (!Assets.exists(path))
				#end
				{
					path = Paths.getPreloadPath('stages/' + DEFAULT_STAGE + '-OBJS.json'); //If a character couldn't be found, change him to BF just to prevent a crash
				}

				#if MODS_ALLOWED
				var jsonData = File.getContent(path);
				#else
				// Load the data from JSON and cast it to a struct we can easily read.
				var jsonData = Assets.getText(path);
				#end
				/*if (jsonData == null)
				{
					Debug.logError('Failed to parse JSON data for character ${curCharacter}');
					return;
				}*/
		
				data = cast Json.parse(jsonData);

				if (data.stagesobjs != null && data.stagesobjs.length > 0)
				{
					for (allobjs in data.stagesobjs)
					{

						obj = new FlxSprite(allobjs.objXY[0], allobjs.objXY[1]);
		
						if (allobjs.animationsArray != null && allobjs.animationsArray.length > 0)
						{
							var spriteType = "sparrow";
					
							#if MODS_ALLOWED
							var modTxtToFind:String = Paths.modsTxt(allobjs.imageName);
							var txtToFind:String = Paths.getPath('images/' + allobjs.imageName + '.txt', TEXT);
			
							// var modTextureToFind:String = Paths.modFolders("images/"+json.image);
							// var textureToFind:String = Paths.getPath('images/' + json.image, new AssetType();
			
							if (FileSystem.exists(modTxtToFind) || FileSystem.exists(txtToFind) || Assets.exists(txtToFind))
							#else
							if (Assets.exists(Paths.getPath('images/' + allobjs.imageName + '.txt', TEXT)))
							#end	
							{
								spriteType = "packer";
							}

							switch (spriteType){
								
								case "packer":
									obj.frames = Paths.getPackerAtlas(allobjs.imageName, allobjs.objDirectory);
								
								case "sparrow":
									obj.frames = Paths.getSparrowAtlas(allobjs.imageName, allobjs.objDirectory);
							}
							if(allobjs.animationsArray != null && allobjs.animationsArray.length > 0)
							{
								for (anim in allobjs.animationsArray)
								{
									if (anim.indices != null && anim.indices.length > 0)
									{
										obj.animation.addByIndices(anim.nameAnim, anim.animation, anim.indices, "", anim.objfps, anim.objLoop);
									} else {
										obj.animation.addByPrefix(anim.nameAnim, anim.animation, anim.objfps, anim.objLoop);
									}
								}	
							}

							//obj.animation.play('idle');
						}else{
							obj.loadGraphic(Paths.image(allobjs.imageName, allobjs.objDirectory));
							obj.active = false;
						}
						obj.flipX = allobjs.objFlipX;
						obj.scrollFactor.set(allobjs.objScroll[0], allobjs.objScroll[1]);
						obj.antialiasing = allobjs.objAntianaliting;
						if (allobjs.objScale != 1)
						{
							obj.setGraphicSize(Std.int(obj.width * allobjs.objScale));
							obj.updateHitbox();
						}
						add(obj);
					}
				}

        }


    }


	override public function update(elapsed:Float) {

		switch (curStage)
		{
			case 'philly':
				if (trainMoving)
				{
					trainFrameTiming += elapsed;

					if (trainFrameTiming >= 1 / 24)
					{
						updateTrainPos();
						trainFrameTiming = 0;
					}
				}

				light.alpha -= (Conductor.crochet / 1000) * FlxG.elapsed * 1.5;

			case 'tank':
				moveTank();
		}
		super.update(elapsed);
	}

	//philly function

	public var trainMoving:Bool = false;
	public var trainFrameTiming:Float = 0;

	public var trainCars:Int = 8;
	public var trainFinishing:Bool = false;
	public var trainCooldown:Int = 0;

	public function trainStart():Void
	{
		trainMoving = true;
		if (!trainSound.playing)
			trainSound.play(true);
	}

	public var startedMoving:Bool = false;

	function updateTrainPos():Void
	{
		if (trainSound.time >= 4700)
		{
			startedMoving = true;
			//another.gf.playAnim('hairBlow');
		}

		if (startedMoving)
		{
			phillyTrain.x -= 400;

			if (phillyTrain.x < -2000 && !trainFinishing)
			{
				phillyTrain.x = -1150;
				trainCars -= 1;

				if (trainCars <= 0)
					trainFinishing = true;
			}

			if (phillyTrain.x < -4000 && trainFinishing)
				trainReset();
		}
	}

	function trainReset():Void
	{
		/*if (another.gf != null)
		{
			another.gf.danced = false; // Sets head to the correct position once the animation ends
			another.gf.playAnim('hairFall');
			another.gf.specialAnim = true;
		}*/
		phillyTrain.x = FlxG.width + 200;
		trainMoving = false;
		// trainSound.stop();
		// trainSound.time = 0;
		trainCars = 8;
		trainFinishing = false;
		startedMoving = false;
	}
	//end

	//limo function
	var fastCarCanDrive:Bool = true;

	function resetFastCar():Void
	{
		fastCar.x = -12600;
		fastCar.y = FlxG.random.int(140, 250);
		fastCar.velocity.x = 0;
		fastCarCanDrive = true;
	}

	function fastCarDrive()
	{
		FlxG.sound.play('assets/sounds/carPass' + FlxG.random.int(0, 1) + TitleState.soundExt, 0.7);

		fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
		fastCarCanDrive = false;
		new FlxTimer().start(2, function(tmr:FlxTimer)
		{
			resetFastCar();
		});
	}
	//end

	public var lightningStrikeBeat:Int = 0;
	public var lightningOffset:Int = 8;

	public var curLight:Int = 0;

	override function beatHit() {
		super.beatHit();
		switch (curStage)
		{
			case 'school':
				bgGirls.dance();
				if (PlayState.SONG.song.toLowerCase() == 'roses')
					if (bgGirls != null)
						bgGirls.swapDanceType();

			case 'mall':
				upperBoppers.dance(true);
				bottomBoppers.dance(true);
				santa.dance(true);

			case 'limo':
				grpLimoDancers.forEach(function(dancer:BackgroundDancer)
				{
					dancer.dance();
				});

				if (FlxG.random.bool(10) && fastCarCanDrive)
					fastCarDrive();
			case "philly":
				if (!trainMoving)
					trainCooldown += 1;

				if (curBeat % 4 == 0)
				{
					curLight = FlxG.random.int(0, phillyLightsColors.length - 1, [curLight]);
					light.color = phillyLightsColors[curLight];
					light.alpha = 1;

					if (eventlight)
					{

						if (curStage == 'philly')
						{
						}	
					} else {

						if (curStage == 'philly')
						{
						}	
					}
				}

				if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
				{
					trainCooldown = FlxG.random.int(-4, 0);
					trainStart();
				}
			case 'tank':
				tankWatchtower.dance();

				foregroundSprites.forEach(function(spr:BGSprite)
				{
					spr.dance();
				});
			default:
				if (data != null)
				{
					dance();
				}	
		}
		
	}

	public function lightningStrikeShit():Void
	{
		FlxG.camera.flash(FlxColor.WHITE, 1);
		FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
		if (Assets.exists('halloween_bg'))
		{
			halloweenBG.animation.play('halloweem bg lightning strike');
		}

		lightningStrikeBeat = curBeat;
		lightningOffset = FlxG.random.int(8, 24);

		/*another.boyfriend.playAnim('scared', true);
		another.gf.playAnim('scared', true);*/
	}

	var tankResetShit:Bool = false;
	var tankMoving:Bool = false;
	var tankAngle:Float = FlxG.random.int(-90, 45);
	var tankSpeed:Float = FlxG.random.float(5, 7);
	var tankX:Float = 400;

	public function moveTank():Void
	{
		//if (!inCutscene)
		/*{*/
			var daAngleOffset:Float = 1;
			tankAngle += FlxG.elapsed * tankSpeed;
			tankGround.angle = tankAngle - 90 + 15;

			tankGround.x = tankX + Math.cos(FlxAngle.asRadians((tankAngle * daAngleOffset) + 180)) * 1500;
			tankGround.y = 1300 + Math.sin(FlxAngle.asRadians((tankAngle * daAngleOffset) + 180)) * 1100;
		//}
	}

	public var danced:Bool = false;

	public function dance()
	{
		if (!debugMode && !skipDance)
		{
			if(obj.animation.getByName('danceRight') != null)
			{
				danced = !danced;

				if (danced)
					playAnim('danceRight');
				else
					playAnim('danceLeft');
			}
			else if(obj.animation.getByName('idle') != null) {
					playAnim('idle');
			}
		}
	}

	public function playAnim(AnimName:String, Force:Bool = false, Reversed:Bool = false, Frame:Int = 0):Void
	{
		obj.animation.play(AnimName, Force, Reversed, Frame);
	}
}

typedef StagesJson = {
	var stagesobjs:Array<StageObjJson>;
}

typedef StageObjJson = {
	var imageName:String;
	var objXY:Array<Int>;
	var objScroll:Array<Int>;
	var objAntianaliting:Bool;
	var objScale:Float;
	var objFlipX:Bool;
	var objDirectory:String;
	var animationsArray:Array<AnimationsObj>;
}
typedef AnimationsObj = {
	var nameAnim:String;
	var animation:String;
	var objfps:Int;
	var objLoop:Bool;
	var indices:Array<Int>;
}