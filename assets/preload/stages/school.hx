var isPissed:Bool = true;
var bgGirls:BGSprite;

function create()
{
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

    bgGirls = new BGSprite('weeb/bgFreaks', -100, 190, 0.9, 0.9, ['BG girls group', 'BG fangirls dissuaded'], true);
    bgGirls.animation.play('BG girls group');
    if (SONG.song.toLowerCase() == 'roses')
        bgGirls.animation.play('BG fangirls dissuaded');
    add(bgGirls);
    bgGirls.antialiasing = false;

    bgSky.setGraphicSize(widShit);
    bgSchool.setGraphicSize(widShit);
    bgStreet.setGraphicSize(widShit);
    bgTrees.setGraphicSize(Std.int(widShit * 1.4));
    bgGirls.setGraphicSize(Std.int(bgGirls.width * PlayState.daPixelZoom));

    bgGirls.updateHitbox();
    bgSky.updateHitbox();
    bgSchool.updateHitbox();
    bgStreet.updateHitbox();
    bgTrees.updateHitbox();
    
    add(gfGroup);
    add(dadGroup);
    add(boyfriendGroup);
}