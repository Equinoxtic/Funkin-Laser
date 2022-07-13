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

class GameplaySettings extends BaseOptionsMenu
{
	public function new()
	{
		title = "Gameplay Settings";
		rpcTitle = "Preferences - Gameplay Settings";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:Option = new Option("Middlescroll",
			"If checked, hides Opponent's notes and your notes get centered.",
			'middleScroll',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option("Downscroll",
			"If checked, notes go Down instead of Up, simple enough.",
			'downScroll',
			'bool',
			false);
		addOption(option);
		
		var option:Option = new Option("Ghost Tapping",
			"If checked, you won't get misses from pressing keys\nwhile there are no notes able to be hit.",
			'ghostTapping',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Note Splashes",
			"If unchecked, hitting \"Sick!\" notes won't show particles.",
			'noteSplashes',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Show Judgement Data",
			"Hides the statistics of gained judgements when unchecked.",
			'showJudgementData',
			'bool',
			true);
		addOption(option);

		var option:Option = new Option("Advanced Scoring System",
			"If checked, you will enable the Advanced Scoring System.\n(Score Multiplier + Extra HUD for gained score & combo)",
			'advancedScoring',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option('Disable Reset Button',
			"If checked, pressing Reset won't do anything.",
			'noReset',
			'bool',
			false);
		addOption(option);
	}
}
