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

class FreeplayModMenu extends BaseModOptionsMenu
{
	public function new()
	{
		title = "Freeplay Modifier Menu";
		rpcTitle = "Freeplay - Modifier Menu";

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.height, FlxG.width, FlxColor.BLACK);
		bg.setGraphicSize(Std.int(bg.width * 1.1));
		bg.screenCenter();
		bg.alpha = 0.75;
		add(bg);

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

		var option:ModOption = new ModOption("Botplay",
			"Enabling this will let the game play for you.",
			'botplay',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Practice Mode",
			"Enabling this will let you basically have no fail.\nBUT you won't get any score from it.",
			'practice',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("No Fail",
			"Pretty self-explanatory.",
			'noFail',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Health Drain",
			"Once enabled, the health starts gradually going down.\n(Can be configured.)",
			'healthDrain',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Health Drain Amount",
			"Set the multiplier for Health Drain.",
			'healthDrainAmount',
			'percent',
			0.1);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 15;
		option.minValue = 0.0;
		option.maxValue = 5;
		option.changeValue = 0.1;
		option.decimals = 1;

		var option:ModOption = new ModOption("Song Speed Multiplier",
			"Set how fast the song should be.",
			'songSpeed',
			'percent',
			0);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 15;
		option.minValue = 0;
		option.maxValue = 3.5;
		option.changeValue = 0.1;
		option.decimals = 1;
	}
}
