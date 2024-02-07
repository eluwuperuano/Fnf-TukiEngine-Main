var posX = 400;
var posY = 200;

function create() {
    var bg:BGSprite = new BGSprite('weeb/animatedEvilSchool', posX, posY, 0.8, 0.9, ['background 2'], true);
    bg.scale.set(6, 6);
    bg.antialiasing = false;
    add(bg);
    
    add(gfGroup);
    add(dadGroup);
    add(boyfriendGroup);
    
}