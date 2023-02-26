package;

import flixel.tweens.FlxEase;
import flixel.math.FlxMath;
import flixel.tweens.FlxTween;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.FlxG;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.FlxSprite;

class CreditsState extends MusicBeatState {
    var curSelected:Int = -1;

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var creditsStuff:Array<Array<String>> = [];

    var bg:FlxSprite;
	var descText:FlxText;

	var offsetThing:Float = -75;

    override function create()
    {
		bg = new FlxSprite().loadGraphic(Paths.image('menuBG'));
		add(bg);
		bg.screenCenter();
		
		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

        var credistPersom:Array<Array<String>> = [ //Name        Description
            ["Funkin' Crew"],
			['ninjamuffin99',	"Programmer of Friday Night Funkin'"],
			['PhantomArcade',	"Animator of Friday Night Funkin'"  ],
			['evilsk8r',		"Artist of Friday Night Funkin'"    ],
			['kawaisprite',		"Composer of Friday Night Funkin'"  ],
            ["Engine"],
            ['Tuki',            "Creator for the engine"            ]
        ];
		
        for(i in credistPersom){
            creditsStuff.push(i);
        }
	
		for (i in 0...creditsStuff.length)
		{
			var creditsTxt:Alphabet = new Alphabet(0, (70 * i) + 30, creditsStuff[i][0], true, false);
			creditsTxt.isMenuItem = true;
			creditsTxt.targetY = i;
            creditsTxt.screenCenter(X);
			//creditsTxt.snapToPosition();
			grpOptions.add(creditsTxt);
		}

		descText = new FlxText(50, FlxG.height + offsetThing - 25, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		add(descText);
		super.create();
    }

	var quitting:Bool = false;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (FlxG.sound.music.volume < 0.7)
		{
			FlxG.sound.music.volume += 0.5 * FlxG.elapsed;
		}

		if(!quitting)
		{
			if(creditsStuff.length > 1)
			{
				var shiftMult:Int = 1;
				if(FlxG.keys.pressed.SHIFT) shiftMult = 3;

				var upP = controls.NOTE_UP_P;
				var downP = controls.NOTE_DOWN_P;

				if (upP)
				{
					changeSelection(-shiftMult);
					holdTime = 0;
				}
				if (downP)
				{
					changeSelection(shiftMult);
					holdTime = 0;
				}

				if(controls.UI_DOWN || controls.UI_UP)
				{
					var checkLastHold:Int = Math.floor((holdTime - 0.5) * 10);
					holdTime += elapsed;
					var checkNewHold:Int = Math.floor((holdTime - 0.5) * 10);

					if(holdTime > 0.5 && checkNewHold - checkLastHold > 0)
					{
						changeSelection((checkNewHold - checkLastHold) * (controls.UI_UP ? -shiftMult : shiftMult));
					}
				}
			}
			if (controls.BACK)
			{
                FlxG.sound.play(Paths.sound('cancelMenu'));
                FlxG.switchState(new MainMenuState());
				quitting = true;
			}
		}
		
		for (item in grpOptions.members)
		{
			if(!item.isBold)
			{
				var lerpVal:Float = CoolUtil.boundTo(elapsed * 12, 0, 1);
				if(item.targetY == 0)
				{
					var lastX:Float = item.x;
					item.screenCenter(X);
					item.x = FlxMath.lerp(lastX, item.x - 70, lerpVal);
				}
				else
				{
					item.x = FlxMath.lerp(item.x, 200 + -40 * Math.abs(item.targetY), lerpVal);
				}
			}
		}
		super.update(elapsed);
	}

	var moveTween:FlxTween = null;
	function changeSelection(change:Int = 0)
	{
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = creditsStuff.length - 1;
			if (curSelected >= creditsStuff.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var bullShit:Int = 0;

		for (item in grpOptions.members)
		{
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}
			}
		}

		descText.text = creditsStuff[curSelected][1];
		descText.y = FlxG.height - descText.height + offsetThing - 60;

		if(moveTween != null) moveTween.cancel();
		moveTween = FlxTween.tween(descText, {y : descText.y + 75}, 0.25, {ease: FlxEase.sineOut});
	}

	private function unselectableCheck(num:Int):Bool {
		return creditsStuff[num].length <= 1;
	}
}