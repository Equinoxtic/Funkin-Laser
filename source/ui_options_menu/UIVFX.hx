package ui_options_menu;

#if desktop
import Discord.DiscordClient;
#end
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.addons.display.FlxGridOverlay;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.math.FlxMath;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import lime.utils.Assets;
import flixel.FlxSubState;
import flash.text.TextField;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.util.FlxSave;
import haxe.Json;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.util.FlxTimer;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;
import options_classes.UIOption;
import preference_vars.UIPrefs;
import base_options.BaseUIOptionsMenu;
import Controls;

class UIVFX extends BaseUIOptionsMenu
{
	public function new()
	{
		title = "Visual Effects";
		rpcTitle = "UI Options Menu - Visual Effects";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:UIOption = new UIOption("Note Tail Shaders",
			"Whether the note tail should have shaders during the gameplay.",
			'strumTailShader',
			'bool',
			false);
		addOption(option);

		var option:UIOption = new UIOption("Note Tail Shader Type",
			"Choose how the note tail shaders behave.",
			'strumTailShaderType',
			'string',
			"Wiggle",
			["Wiggle", "Wiggle on beat"]);
		addOption(option);
	}
}
