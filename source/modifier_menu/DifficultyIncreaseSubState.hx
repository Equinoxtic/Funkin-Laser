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

class DifficultyIncreaseSubState extends BaseModOptionsMenu
{
	public function new()
	{
		title = "Difficulty Increase";
		rpcTitle = "Modifier Menu - Difficulty Increase";
		super();
	}

	function getOptions()
	{
		var option:ModOption = new ModOption("Ghost Notes",
			"If enabled, the notes will become transparent.",
			'ghostNotes',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Limited Vision",
			"Enabling this will have a vignette overlaying the HUD.",
			'limitedVision',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Nausea",
			"(@...@\")",
			'nauseous',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Flipped",
			"Once enabled, the camera will flip during the gameplay.",
			'flipped',
			'bool',
			false);
		addOption(option);

		var option:ModOption = new ModOption("Health Drain",
			"Once enabled, the health starts gradually going down.\n(Can be configured.)",
			'healthDrain',
			'bool',
			false);
		addOption(option);
	}
}
