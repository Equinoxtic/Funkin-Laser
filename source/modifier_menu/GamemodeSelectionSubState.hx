package modifier_menu;

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
import options_classes.ModOption;
import base_options.BaseModOptionsMenu;
import Controls;

using StringTools;

class GamemodeSelectionSubState extends BaseModOptionsMenu
{
	
	public function new()
	{
		title = "Gamemodes";
		rpcTitle = "Modifier Menu - Gamemodes";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:ModOption = new ModOption("Pussy Mode",
			"When enabled, the song will slow down\nMaking it easier for you to comprehend pressing notes.",
			'pussyMode',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Hardcore Mode",
			"When enabled, the song will speed up\nand there'd also be a modchart topping all of it off.",
			'hardcoreMode',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Endless Mode",
			"Once enabled, when the song is over it'll repeat in a constant loop.\n(Constantly speeding up as well.)",
			'endlessMode',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Perfection",
			"Not for the faint-hearted.\n(One miss & accuracy < 100% = Death.)",
			'ssMode',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Enigma",
			"The healthbar will become invisible once enabled.",
			'enigma',
			'bool',
			false);
		addOption(option);
	}
}
