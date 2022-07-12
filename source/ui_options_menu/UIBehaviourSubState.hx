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
import base_options.BaseUIOptionsMenu;
import Controls;

using StringTools;

class UIBehaviourSubState extends BaseUIOptionsMenu
{
	public function new()
	{
		title = 'UI Behaviour';
		rpcTitle = 'UI Options - UI Behaviour';

		var option:UIOption = new UIOption('Noteskin',
			"Set your noteskin!",
			'noteskin',
			'string',
			'Arrows',
			['Arrows', 'Circles']);
		addOption(option);
		
		var option:UIOption = new UIOption('Time Bar',
			"What should the Time bar display?",
			'timeShowing',
			'string',
			'Time Left',
			['Time Left', 'Elapsed', 'Song Name - Time', 'Song Name Only']);
		addOption(option);

		var option:UIOption = new UIOption("Icon Bopping",
			"Whether the icons should bop on the beat hit.",
			'iconBop',
			'bool',
			true);
		addOption(option);

		var option:UIOption = new UIOption("Zoom Score Text",
			"Whether the Score should zoom whenever you hit the note.",
			'scoreZooming',
			'bool',
			true);
		addOption(option);

		var option:UIOption = new UIOption("Health Bar Type",
			"Choose what color the health bar should display.",
			'healthBarType',
			'string',
			"Default",
			["Default", "Vanilla FNF"]);
		addOption(option);
		
		var option:UIOption = new UIOption("Use Time Bar Colors",
			"Whether to make the time bar show the enemy's icon color.",
			'timeBarColors',
			'bool',
			false);
		addOption(option);

		super();
	}
}
