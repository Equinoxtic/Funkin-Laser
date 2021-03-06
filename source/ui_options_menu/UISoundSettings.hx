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

using StringTools;

class UISoundSettings extends BaseUIOptionsMenu
{
	public function new()
	{
		title = "Sound Settings";
		rpcTitle = "UI Options - Sound Settings";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:UIOption = new UIOption("Hitsounds",
			"If checked, each note hit will play a hit sound.\nSpecifically going \"Tick!\"",
			'hitsounds',
			'bool',
			true);
		addOption(option);

		var option:UIOption = new UIOption("Hitsound Volume",
			"Set how loud the hitsounds should be.",
			'hitsoundsVolume',
			'float',
			0.75);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.1;
		option.maxValue = 1;
		option.changeValue = 0.1;
		option.decimals = 1;
		option.onChange = onChangeHitsoundVolume;

		var option:UIOption = new UIOption("Miss Sounds",
			"If disabled, each note miss won't play a miss sound.",
			'missSounds',
			'bool',
			true);
		addOption(option);

		var option:UIOption = new UIOption("Miss Sounds Volume",
			"Set how loud the hitsounds should be.",
			'missSoundsVolume',
			'float',
			0.1);
		addOption(option);
		option.scrollSpeed = 1.6;
		option.minValue = 0.1;
		option.maxValue = 0.3;
		option.changeValue = 0.01;
		option.decimals = 2;
		option.onChange = onChangeMissSoundsVolume;

		var option:UIOption = new UIOption("Mute Vocals on Miss",
			"Whether the vocals should be muted when missing a note.",
			'muteVox',
			'bool',
			true);
		addOption(option);

		var option:UIOption = new UIOption('Pause Music',
			"Choose what the Pause Menu music should play!",
			'pauseMusic',
			'string',
			'Breakfast',
			['Breakfast', 'Osu', 'Osu Bacon Boi', 'Tea Time']);
		addOption(option);
	}

	function onChangeHitsoundVolume()
	{
		FlxG.sound.play(Paths.sound('hitsound'), UIPrefs.hitsoundsVolume);
	}

	function onChangeMissSoundsVolume()
	{
		FlxG.sound.play(Paths.soundRandom('missnote', 1, 3), UIPrefs.missSoundsVolume);
	}
}
