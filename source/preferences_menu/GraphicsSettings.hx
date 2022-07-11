package preferences_menu;

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
import options_classes.Option;
import base_options.BaseOptionsMenu;
import Controls;

using StringTools;

class GraphicsSettings extends BaseOptionsMenu
{
	public function new()
	{
		title = "Graphics";
		rpcTitle = "Preferences - Graphics";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:Option = new Option("Low Quality",
			"If checked, disables some background details,\ndecreases loading times and improves performance.",
			'lowQuality',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option("Persistent Cached Data",
			"If checked, images loaded will stay in memory\nuntil the game is closed, this increases memory usage,\nbut basically makes reloading times instant.",
			'imagesPersist',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option("Anti-Aliasing",
			"If unchecked, disables anti-aliasing, increases performance\nat the cost of the graphics not looking as smooth.",
			'globalAntialiasing',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Flashing Lights",
			"Uncheck this if you're sensitive to flashing lights!",
			'flashing',
			'bool',
			true);
		addOption(option);
	}
}
