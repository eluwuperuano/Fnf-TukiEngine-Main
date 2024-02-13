var tankWatchtower:BGSprite;
var tankGround:BGSprite;

var tankResetShit:Bool = false;
var tankMoving:Bool = false;
var tankAngle:Float = FlxG.random.int(-90, 45);
var tankSpeed:Float = FlxG.random.float(5, 7);
var tankX:Float = 400; 

var fgTank0:BGSprite;
var fgTank1:BGSprite;
var fgTank2:BGSprite;
var fgTank3:BGSprite;
var fgTank4:BGSprite;
var fgTank5:BGSprite;

function beatHit(curBeat) {
    tankWatchtower.dance();

    fgTank0.dance();
    fgTank1.dance();
    fgTank2.dance();
    fgTank3.dance();
    fgTank4.dance();
    fgTank5.dance();
}

function create() {
					
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

    var tankGround:BGSprite = new BGSprite('tankGround', -420, -150);
    tankGround.setGraphicSize(Std.int(tankGround.width * 1.15));
    tankGround.updateHitbox();
    add(tankGround);

    moveTank();
    
    add(gfGroup);
    add(dadGroup);
    add(boyfriendGroup);

    frontObject();
}

function update(elapsed) {
    moveTank();
}

function frontObject() {
    
    fgTank0 = new BGSprite('tank0', -500, 650, 1.7, 1.5, ['fg']);
    add(fgTank0);

    fgTank1 = new BGSprite('tank1', -300, 750, 2, 0.2, ['fg']);
    add(fgTank1);

    // just called 'foreground' just cuz small inconsistency no bbiggei
    fgTank2 = new BGSprite('tank2', 450, 940, 1.5, 1.5, ['foreground']);
    add(fgTank2);

    fgTank4 = new BGSprite('tank4', 1300, 900, 1.5, 1.5, ['fg']);
    add(fgTank4);

    fgTank5 = new BGSprite('tank5', 1620, 700, 1.5, 1.5, ['fg']);
    add(fgTank5);

    fgTank3 = new BGSprite('tank3', 1300, 1200, 3.5, 2.5, ['fg']);
    add(fgTank3);
}

function moveTank()
{
        var daAngleOffset:Float = 1;
        tankAngle += FlxG.elapsed * tankSpeed;
        tankGround.angle = tankAngle - 90 + 15;

        tankGround.x = tankX + Math.cos(FlxAngle.asRadians((tankAngle * daAngleOffset) + 180)) * 1500;
        tankGround.y = 1300 + Math.sin(FlxAngle.asRadians((tankAngle * daAngleOffset) + 180)) * 1100;
}