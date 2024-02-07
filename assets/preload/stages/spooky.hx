var halloweenBG:BGSprite;

var lightningStrikeBeat:Int = 0;
var lightningOffset:Int = 8;
var lightningStrike:Float = -5;

function beatHit(curBeat) {
    if (FlxG.random.bool(10) && curBeat > lightningStrikeBeat + lightningOffset)
    {
        lightingShit();
    }
}

function create() {
    halloweenBG = new BGSprite('halloween_bg', -200, -100, ['halloweem bg0', 'halloweem bg lightning strike']);
    halloweenBG.scrollFactor.set(1, 1);
    add(halloweenBG);
    
    add(gfGroup);
    add(dadGroup);
    add(boyfriendGroup);
}

function lightingShit()
{
    FlxG.camera.flash(0xffffffff, 1);
    FlxG.sound.play(Paths.soundRandom('thunder_', 1, 2));
    halloweenBG.animation.play('halloweem bg lightning strike');

    lightningStrikeBeat = PlayState.curBeat;
    lightningOffset = FlxG.random.int(0, 24);
}