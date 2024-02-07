import haxe.Json;
import sys.FileSystem;
import haxe.io.Path;
import hscript.Interp;

using StringTools;

class Hscript extends Interp{
    public function new() {
        super();
    }

    public function hscriptApply(functionToCall:String, ?params:Array<Any>):Dynamic {
    if (this == null)
        {
            return null;
        }
    if (this.variables.exists(functionToCall))
        {
            var functiondemrd = this.variables.get(functionToCall);
            if (params == null)
            {
                var result = null;
                result = functiondemrd();
                return result;
            }else{
                var result = null;
                result = Reflect.callMethod(null, functiondemrd(), params);
                return result;
            }
        }
    return null;
    }

    public function endHscript()
    {
        variables.set("PlayState", PlayState);
        variables.set("WiggleEffectType", WiggleEffect.WiggleEffectType);
        variables.set("setProperty", setProperty);

        variables.set("FlxBasic", flixel.FlxBasic);
        variables.set("FlxCamera", flixel.FlxCamera);
        variables.set("FlxG", flixel.FlxG);
        variables.set("FlxGame", flixel.FlxGame);
        variables.set("FlxSprite", flixel.FlxSprite);
        variables.set("FlxState", flixel.FlxState);
        variables.set("FlxSubState", flixel.FlxSubState);
        variables.set("FlxGridOverlay", flixel.addons.display.FlxGridOverlay);
        variables.set("FlxTrail", flixel.addons.effects.FlxTrail);
        variables.set("FlxTrailArea", flixel.addons.effects.FlxTrailArea);
        variables.set("FlxEffectSprite", flixel.addons.effects.chainable.FlxEffectSprite);
        variables.set("FlxWaveEffect", flixel.addons.effects.chainable.FlxWaveEffect);
        variables.set("FlxTransitionableState", flixel.addons.transition.FlxTransitionableState);
        variables.set("FlxAtlas", flixel.graphics.atlas.FlxAtlas);
        variables.set("FlxAtlasFrames", flixel.graphics.frames.FlxAtlasFrames);
        variables.set("FlxTypedGroup", flixel.group.FlxGroup.FlxTypedGroup);
        variables.set("FlxMath", flixel.math.FlxMath);
        variables.set("FlxText", flixel.text.FlxText);
        variables.set("FlxEase", flixel.tweens.FlxEase);
        variables.set("FlxTween", flixel.tweens.FlxTween);
        variables.set("FlxBar", flixel.ui.FlxBar);
        variables.set("FlxCollision", flixel.util.FlxCollision);
        variables.set("FlxSort", flixel.util.FlxSort);
        variables.set("FlxStringUtil", flixel.util.FlxStringUtil);
        variables.set("FlxTimer", flixel.util.FlxTimer);
        variables.set("FlxRect", flixel.math.FlxRect);
        variables.set("FlxObject", flixel.FlxObject);
        variables.set("FlxSound", flixel.system.FlxSound);

        variables.set("Json", Json);
        variables.set("Assets", lime.utils.Assets);
        variables.set("ShaderFilter", openfl.filters.ShaderFilter);
        variables.set("Exception", haxe.Exception);
        variables.set("Lib", openfl.Lib);
        variables.set("CurrentPlayState", this);
        variables.set("OpenFlAssets", openfl.utils.Assets);
        variables.set("Parser", hscript.Parser);
        variables.set("interp", hscript.Interp);
        variables.set("Paths", Paths);
        variables.set("BGSprite", BGSprite);
        variables.set("Std", Std);
        variables.set("Conductor", Conductor);
        variables.set("BackgroundDancer", BackgroundDancer);
        #if sys
        //sys system
        variables.set("File", sys.io.File);
        variables.set("FileSystem", sys.FileSystem);
        variables.set("FlxGraphic", flixel.graphics.FlxGraphic);
        variables.set("BitmapData", openfl.display.BitmapData);
        #end

        variables.set("update", function(elapsed:Float)                
                        {
                        });
        variables.set("create", function()
                        {
                        });
        variables.set("beatHit", function()
                        {
                        });             
    }

    public function setVariable(string:String, dyn:Dynamic) {
        variables.set(string, dyn);
    }

    //-//MAS MAMADAS//-//

    public static function setVarInArray(instance:Dynamic, variable:String, value:Dynamic):Any
    {
        var variable1:Array<String> = variable.split('[');
        if(variable1.length > 1)
        {
            var variable2:Dynamic = null;
            if(PlayState.instance.selbairav.exists(variable1[0]))
            {
                var variable3:Dynamic = PlayState.instance.selbairav.get(variable1[0]);
                if(variable3 != null)
                    variable2 = variable3;
            }
            else
                variable2 = Reflect.getProperty(instance, variable1[0]);

            for (i in 1...variable1.length)
            {
                var variable4:Dynamic = variable1[i].substr(0, variable1[i].length - 1);
                if(i >= variable1.length-1) //Last array
                    variable2[variable4] = value;
                else //Anything else
                    variable2 = variable2[variable4];
            }
            return variable2;
        }
        /*if(Std.isOfType(instance, Map))
            instance.set(variable,value);
        else*/
            
        if(PlayState.instance.selbairav.exists(variable))
        {
            PlayState.instance.selbairav.set(variable, value);
            return true;
        }

        Reflect.setProperty(instance, variable, value);
        return true;
    }

    public static function getVarInArray(instance:Dynamic, variable:String):Any
    {
        var variable1:Array<String> = variable.split('[');
        if(variable1.length > 1)
        {
            var variable2:Dynamic = null;
            if(PlayState.instance.selbairav.exists(variable1[0]))
            {
                var variable3:Dynamic = PlayState.instance.selbairav.get(variable1[0]);
                if(variable3 != null)
                    variable2 = variable3;
            }
            else
                variable2 = Reflect.getProperty(instance, variable1[0]);

            for (i in 1...variable1.length)
            {
                var variable4:Dynamic = variable1[i].substr(0, variable1[i].length - 1);
                variable2 = variable2[variable4];
            }
            return variable2;
        }

        if(PlayState.instance.selbairav.exists(variable))
        {
            var variable3:Dynamic = PlayState.instance.selbairav.get(variable);
            if(variable3 != null)
                return variable3;
        }

        return Reflect.getProperty(instance, variable);
    }

    public static inline function getInstance()
    {
        return PlayState.instance.isDead ? GameOverSubstate.instance : PlayState.instance;
    }

    public static function getObjectDirectly(objectName:String, ?checkForTextsToo:Bool = true):Dynamic
    {
        var coverMeInPiss:Dynamic = PlayState.instance.getHScriptObject(objectName, checkForTextsToo);
        if(coverMeInPiss==null)
            coverMeInPiss = getVarInArray(getInstance(), objectName);

        return coverMeInPiss;
    }

    public static function getPropertyLoopThingWhatever(set1:Array<String>, ?set2:Bool = true, ?getProperty:Bool=true):Dynamic
    {
        var variable0:Dynamic = getObjectDirectly(set1[0], set2);
        var end = set1.length;
        if(getProperty)end=set1.length-1;

        for (i in 1...end) {
            variable0 = getVarInArray(variable0, set1[i]);
        }
        return variable0;
    }

    public function setProperty(set1:String, set2:Dynamic) {
        var variable1:Array<String> = set1.split('.');
        if (variable1.length > 1) {
            setVarInArray(getPropertyLoopThingWhatever(variable1), variable1[variable1.length-1], set2);
            return true;
        }
        setVarInArray(getInstance(), set1, set2);
        return true;
    }
}