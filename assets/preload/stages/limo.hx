var limo:BGSprite;
var fastCar:BGSprite;

var dancer:FlxSprite;

var fastCarCanDrive:Bool = true;

function beatHit(curBeat) {
    if (FlxG.random.bool(10) && fastCarCanDrive)
        fastCarDrive();
}

function create()
{
    var skyBG:BGSprite = new BGSprite('limo/limoSunset', -120, -50, 0.1, 0.1);
    add(skyBG);

    var bgLimo:BGSprite = new BGSprite('limo/bgLimo', -150, 480, 0.4, 0.4, ['background limo pink'], true);
    add(bgLimo);

    for (i in 0...5)
    {

        dancer = new FlxSprite((370 * i) + 130, bgLimo.y - 400);
        dancer.frames = Paths.getSparrowAtlas("limo/limoDancer");
        dancer.animation.addByPrefix('danceLeft', 'bg dancer sketch PINK', 24, true);
        dancer.animation.play('danceLeft');
        dancer.antialiasing = true;
        dancer.scrollFactor.set(0.4, 0.4);
        add(dancer);
    } 

    limo = new BGSprite('limo/limoDrive', -120, 550, 1, 1, ['Limo stage'], true);

    fastCar = new BGSprite('limo/fastCarLol', -300, 160);
    
    add(gfGroup);
    add(limo);    
    add(dadGroup);
    add(boyfriendGroup);

    resetFastCar();
    add(fastCar);
}

function resetFastCar():Void
{
    fastCar.x = -12600;
    fastCar.y = FlxG.random.int(140, 250);
    fastCar.velocity.x = 0;
    fastCarCanDrive = true;
}

function fastCarDrive()
{
    FlxG.sound.play(Paths.soundRandom('carPass', 0, 1), 0.7);

    fastCar.velocity.x = (FlxG.random.int(170, 220) / FlxG.elapsed) * 3;
    fastCarCanDrive = false;
    new FlxTimer().start(2, function(tmr:FlxTimer)
    {
        resetFastCar();
    });
}