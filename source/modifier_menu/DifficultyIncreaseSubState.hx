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
		getOptions();
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

		var option:ModOption = new ModOption("Ghost Note Transparency",
			"Set how transparent the notes should be with Ghost Notes.",
			'ghostNoteAlpha',
			'float',
			0.45);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 15;
		option.minValue = 0.05;
		option.maxValue = 0.75;
		option.changeValue = 0.05;
		option.decimals = 2;

		var option:ModOption = new ModOption("Limited Vision Intensity",
			"Set how limited the vision is for the HUD.",
			'lvIntensity',
			'float',
			0.45);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 25;
		option.minValue = 0.1;
		option.maxValue = 2;
		option.changeValue = 0.05;
		option.decimals = 2;

		var option:ModOption = new ModOption("Nausea Intensity",
			"Set how strong the nausea effect should be.",
			'nauseaIntensity',
			'float',
			0.5);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 30;
		option.minValue = 0.05;
		option.maxValue = 5.25;
		option.changeValue = 0.01;
		option.decimals = 2;

		var option:ModOption = new ModOption("Health Drain Amount",
			"Set the multiplier for Health Drain.",
			'healthDrainAmount',
			'float',
			0.1);
		addOption(option);
		option.displayFormat = '%v';
		option.scrollSpeed = 15;
		option.minValue = 0.0;
		option.maxValue = 5;
		option.changeValue = 0.1;
		option.decimals = 1;
	}
}
