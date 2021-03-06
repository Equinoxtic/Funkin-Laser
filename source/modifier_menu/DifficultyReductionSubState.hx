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

class DifficultyReductionSubState extends BaseModOptionsMenu
{
	public function new()
	{
		title = "Difficulty Reduction";
		rpcTitle = "Modifier Menu - Difficulty Reduction";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:ModOption = new ModOption("No Fail",
			"Pretty self-explanatory.",
			'noFail',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Modcharts Disabled",
			"Enable this to disable modcharts.",
			'disabledModcharts',
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
	}
}
