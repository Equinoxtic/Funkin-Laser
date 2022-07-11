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

class DifficultyFunSubState extends BaseModOptionsMenu
{
	public function new()
	{
		title = "Fun and Deadly";
		rpcTitle = "Modifier Menu - Fun and Deadly";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:ModOption = new ModOption("Hell",
			"Hell. Just pure Hell.",
			'hell',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Drugs",
			"Woahhhh brooooo, this shit so good af broooooo",
			'drugs',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Amogus",
			"sus",
			'amogus',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Drugs Multiplier",
			"wohsowhoahdwohosahdodhwodsodhfhsdhahowed",
			'drugsMulti',
			'percent',
			1.15);
		addOption(option);

		var option:ModOption = new ModOption("Song Speed Multiplier",
			"Set how fast the song should be.",
			'songSpeed',
			'float',
			1);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 15;
		option.minValue = 1;
		option.maxValue = 3.5;
		option.changeValue = 0.1;
		option.decimals = 1;
	}
}
