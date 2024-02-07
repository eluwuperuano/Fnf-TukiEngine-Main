
var phillybg:BGSprite;
var phillycity:BGSprite;
var streetBehind:BGSprite;

var phillyTrain:FlxSprite;
var trainSound:FlxSound;

var phillyLightsColors:Array<FlxColor>;

var light:BGSprite;
var street:BGSprite;

var trainMoving:Bool = false;
var trainFrameTiming:Float = 0;

var trainCars:Int = 8;
var trainFinishing:Bool = false;
var trainCooldown:Int = 0;

var curLight:Int = 0;

var startedMoving:Bool = false;

function beatHit(curBeat)
{
    if (!trainMoving)
        trainCooldown += 1;

        if (curBeat % 4 == 0)
        {
            curLight = FlxG.random.int(0, phillyLightsColors.length - 1, [curLight]);
            FlxTween.color(light, 1, 0x00ffffff, phillyLightsColors[curLight]);
            light.alpha = 1;
        }

    if (curBeat % 8 == 4 && FlxG.random.bool(30) && !trainMoving && trainCooldown > 8)
    {
        trainCooldown = FlxG.random.int(-4, 0);
        startTrain();
    }
}

function create() {

    phillybg = new BGSprite('philly/sky', -100, 0, 0.1, 0.1);
    phillybg.scrollFactor.set(0.1, 0.1);
    add(phillybg);

    phillycity = new BGSprite('philly/city', -10, 0, 0.3, 0.3);
    phillycity.scrollFactor.set(0.3, 0.3);
    phillycity.setGraphicSize(Std.int(phillycity.width * 0.85));
    phillycity.updateHitbox();
    add(phillycity);

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

    street = new BGSprite('philly/street', -40, 50);
    add(street);
    
    add(gfGroup);
    add(dadGroup);
    add(boyfriendGroup);
}

function update(elapsed) {
    if (trainMoving)
    {
        trainFrameTiming += elapsed;

        if (trainFrameTiming >= 1 / 24)
        {
            updatePosTrain();
            trainFrameTiming = 0;
        }
    }

    light.alpha -= (Conductor.crochet / 1000) * FlxG.elapsed * 1.5;
}

function startTrain():Void
{
    trainMoving = true;
    if (!trainSound.playing)
        trainSound.play(true);
}


function updatePosTrain():Void
{
    if (trainSound.time >= 4700)
    {
        startedMoving = true;
        gf.playAnim('hairBlow');
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
            resetTrain();
    }
}

function resetTrain():Void
{
    if (gf != null)
    {
        gf.danced = false; // Sets head to the correct position once the animation ends
        gf.playAnim('hairFall');
        gf.specialAnim = true;
    }
    phillyTrain.x = FlxG.width + 200;
    trainMoving = false;
    // trainSound.stop();
    // trainSound.time = 0;
    trainCars = 8;
    trainFinishing = false;
    startedMoving = false;
}