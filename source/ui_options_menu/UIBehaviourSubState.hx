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
import Controls;

using StringTools;

class UIBehaviourSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'UI Behaviour';
		rpcTitle = 'UI Options - UI Behaviour';

		var option:Option = new Option('Noteskin',
			"Set your noteskin!",
			'noteskin',
			'string',
			'Arrows',
			['Arrows', 'Circles', 'Stepmania']);
		addOption(option);
		
		var option:Option = new Option('Time Bar:',
			"What should the Time bar display?",
			'timeShowing',
			'string',
			'Time Left',
			['Time Left', 'Elapsed', 'Song Name - Time', 'Song Name Only']);
		addOption(option);
			
		var option:Option = new Option('Pause Music',
			"Choose what the Pause Menu music should play!",
			'pauseMusic',
			'string',
			'Breakfast',
			['Breakfast', 'Osu', 'Osu Bacon Boi', 'Tea Time']);
		addOption(option);

		var option:Option = new Option('Score Zooms on Hit',
			"Whether to zoom the Score Text on Note hits.",
			'scoreZooming',
			'bool',
			true);
		addOption(option);
	
		var option:Option = new Option('Icon Bopping',
			"Whether the icons should bop on the beat hit.",
			'iconBop',
			'bool',
			true);
		addOption(option);

		super();
	}
}
