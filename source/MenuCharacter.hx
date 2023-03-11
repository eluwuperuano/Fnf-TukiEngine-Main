package;

import flixel.util.FlxColor;
import flixel.FlxSprite;
import flixel.graphics.frames.FlxAtlasFrames;
import openfl.utils.Assets;
import haxe.Json;
import haxe.format.JsonParser;

class MenuCharacter extends FlxSprite
{
	public var character:String;
	public var hasConfirmAnimation:Bool = false;
	private static var DEFAULT_CHARACTER:String = 'bf';

	public function new(x:Float, character:String = 'bf')
	{
		super(x);

		changeCharacter(character);
	}

	public function changeCharacter(?character:String = 'bf') {
		if(character == null) character = '';
		if(character == this.character) return;

		this.character = character;
		visible = true;

		var dontPlayAnim:Bool = false;
		scale.set(1, 1);
		updateHitbox();

		hasConfirmAnimation = false;
		switch(character) {
			case '':
				visible = false;
				dontPlayAnim = true;
			default:
				var characterPath:String = 'charactersmenu/' + character + '.json';
				var rawJson = null;
				var path:String = Paths.getPreloadPath(characterPath);
				if(!Assets.exists(path)) {
					path = Paths.getPreloadPath('charactersmenu/' + DEFAULT_CHARACTER + '.json');
				}
				rawJson = Assets.getText(path);
				
				var fileport:MenuCharacterFile = cast Json.parse(rawJson);
				frames = Paths.getSparrowAtlas('charactersmenu/' + fileport.image);
				animation.addByPrefix('idle', fileport.idle_anim, 24);

				var confirmAnim:String = fileport.confirm_anim;
				if(confirmAnim != null && confirmAnim.length > 0 && confirmAnim != fileport.idle_anim)
				{
					animation.addByPrefix('confirm', confirmAnim, 24, false);
					if (animation.getByName('confirm') != null) //check for invalid animation
						hasConfirmAnimation = true;
				}

				color = FlxColor.fromString(fileport.color);

				flipX = (fileport.flipX == true);

				antialiasing = true;

				if(fileport.scale != 1) {
					scale.set(fileport.scale, fileport.scale);
					updateHitbox();
				}
				offset.set(fileport.position[0], fileport.position[1]);
				animation.play('idle');
		}
	}
}

typedef MenuCharacterFile = {
	var image:String;
	var scale:Float;
	var position:Array<Int>;
	var idle_anim:String;
	var confirm_anim:String;
	var flipX:Bool;
	var color:String;
}