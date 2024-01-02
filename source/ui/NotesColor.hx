package ui;

import shaderslmfao.PublicShaders.ColoredNoteShader;
import flixel.FlxSprite;
import flixel.addons.ui.FlxUIInputText;
import flixel.util.FlxColor;

class NotesColor extends MusicBeatState {

    //Note 
    var arrowText0:FlxUIInputText;
    var arrowSprite0:Note;
    
    var arrowText1:FlxUIInputText;
    var arrowSprite1:Note;
    
    var arrowText2:FlxUIInputText;
    var arrowSprite2:Note;
    
    var arrowText3:FlxUIInputText;
    var arrowSprite3:Note;
    //end

    public function new() {
        
        super();
       
        var color0 = new FlxColor(FlxColor.fromString(ClientPref.arrowColor0));
        var color1 = new FlxColor(FlxColor.fromString(ClientPref.arrowColor1));
        var color2 = new FlxColor(FlxColor.fromString(ClientPref.arrowColor2));
        var color3 = new FlxColor(FlxColor.fromString(ClientPref.arrowColor3));

        arrowSprite0 = new Note(0, 0);
        arrowSprite0.shader = new ColoredNoteShader(color0.red, color0.green, color0.blue);
        arrowSprite0.screenCenter();
        add(arrowSprite0);

        arrowSprite1 = new Note(0, 1);
        arrowSprite1.shader = new ColoredNoteShader(color1.red, color1.green, color1.blue);
        arrowSprite1.x = arrowSprite0.x + 60;
        arrowSprite1.y = arrowSprite0.y;
        add(arrowSprite1);

        arrowSprite2 = new Note(0, 2);
        arrowSprite2.shader = new ColoredNoteShader(color2.red, color2.green, color2.blue);
        arrowSprite2.x = arrowSprite1.x + 60;
        arrowSprite2.y = arrowSprite1.y;
        add(arrowSprite2);

        arrowSprite3 = new Note(0, 3);
        arrowSprite3.shader = new ColoredNoteShader(color3.red, color3.green, color3.blue);
        arrowSprite3.x = arrowSprite2.x + 60;
        arrowSprite3.y = arrowSprite2.y;
        add(arrowSprite3);

        var menuBG:FlxSprite = new FlxSprite(0, 0).loadGraphic(Paths.image('menuBG'));
        menuBG.screenCenter();
        menuBG.updateHitbox();
        add(menuBG);
    }
}