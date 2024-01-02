package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.text.FlxText;
import flixel.util.FlxColor;

class CharSelect extends MusicBeatState {

    var desat:FlxSprite;
    var boyfriend:Boyfriend;
    var text:FlxText;
    
    override function create() {

        desat = new FlxSprite(-80).loadGraphic(Paths.image('menuDesat'));
		desat.scrollFactor.x = 0;
		desat.scrollFactor.y = 0.18;
		desat.setGraphicSize(Std.int(desat.width * 1.1));
		desat.updateHitbox();
		desat.screenCenter();
		desat.antialiasing = true;
		add(desat);
        
        text = new FlxText(5, FlxG.height - 38, 0, "CharSelect", 12);
		text.scrollFactor.set();
		text.setFormat(Paths.font('fnf.ttf'), 16, FlxColor.WHITE, LEFT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
        add(text);

        boyfriend = new Boyfriend(0, 0, "bf");
        boyfriend.screenCenter();
        boyfriend.playAnim('idle');
        add(boyfriend);

        super.create();
    }
    override function update(elapsed:Float) {

        if (controls.BACK)
        {
            FlxG.switchState(new MainMenuState());
        }

        super.update(elapsed);
    }
}