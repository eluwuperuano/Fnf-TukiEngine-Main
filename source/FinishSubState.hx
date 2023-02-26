package;

import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.text.FlxText;
import flixel.FlxSprite;

using StringTools;

class FinishSubState extends MusicBeatState {
    var scoreTxt:FlxText;
    var missTxt:FlxText;
    var sicksTxt:FlxText;
    var goodsTxt:FlxText;
    var shitsTxt:FlxText;
    var badsTxt:FlxText;

    override function create() {

		var bg:FlxSprite = new FlxSprite(-80).loadGraphic('assets/images/menuBG.png');
		bg.scrollFactor.x = 0;
		bg.scrollFactor.y = 0.18;
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.updateHitbox();
		bg.screenCenter();
		bg.antialiasing = true;
		add(bg);

		scoreTxt = new FlxText(0, 0 + 36, FlxG.width, "", 20);
		scoreTxt.setFormat(Paths.font("fnf.ttf"), 20, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		scoreTxt.scrollFactor.set();
		scoreTxt.text = 'Score: ' + PlayState.instance.songScore;
		add(scoreTxt);

		missTxt = new FlxText(0, scoreTxt.y + 36, FlxG.width, "", 20);
		missTxt.setFormat(Paths.font("fnf.ttf"), 20, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		missTxt.scrollFactor.set();
		missTxt.text = 'Miss: ' + PlayState.instance.songMisses;
		add(missTxt);

		var sicksTxt:FlxText = new FlxText(0, missTxt.y + 36, FlxG.width, "", 20);
		sicksTxt.setFormat(Paths.font("fnf.ttf"), 20, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		sicksTxt.scrollFactor.set();
		sicksTxt.text = 'Sick: ' + PlayState.instance.songSick;
		add(sicksTxt);

		goodsTxt = new FlxText(0, sicksTxt.y + 36, FlxG.width, "", 20);
		goodsTxt.setFormat(Paths.font("fnf.ttf"), 20, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		goodsTxt.scrollFactor.set();
		goodsTxt.text = 'Good: ' + PlayState.instance.songGoods;
		add(goodsTxt);

		badsTxt = new FlxText(0, goodsTxt.y + 36, FlxG.width, "", 20);
		badsTxt.setFormat(Paths.font("fnf.ttf"), 20, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		badsTxt.scrollFactor.set();
		badsTxt.text = 'Bads: ' + PlayState.instance.songBads;
		add(badsTxt);

		shitsTxt = new FlxText(0, badsTxt.y + 36, FlxG.width, "", 20);
		shitsTxt.setFormat(Paths.font("fnf.ttf"), 20, 0xffffffff, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		shitsTxt.scrollFactor.set();
		shitsTxt.text = 'Shits: ' + PlayState.instance.songShits;
		add(shitsTxt);

        super.create();
    }

    override function update(elapsed:Float) {
		if (controls.ACCEPT)
		{
            trace('WENT BACK TO FREEPLAY??');
			FlxG.switchState(new FreeplayState());
		}
    }
}