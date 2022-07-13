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

class UISettings extends BaseOptionsMenu
{
	public function new()
	{
		title = "UI Settings";
		rpcTitle = "Preferences - UI Settings";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:Option = new Option("FPS Counter",
			"If unchecked, hides FPS Counter.",
			'showFPS',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Memory Counter",
			"If unchecked, hides Memory Counter.",
			'showMemCounter',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Show Song Credit",
			"If unchecked, when starting a song, credits will no longer be shown.",
			'showSongCredit',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Show Song Name on Song Length",
			"If unchecked, the song name on the time bar will be hidden.",
			'showSongName',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option("Hide Song Length",
			"If checked, the bar showing how much time is left\nwill be hidden.",
			'hideTime',
			'bool',
			false);
		addOption(option);
	}
}
