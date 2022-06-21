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

class UILayoutSubState extends BaseOptionsMenu
{
	public function new()
	{
		title = 'UI Layout';
		rpcTitle = 'UI Options - UI Layout';

		var option:Option = new Option('UI Style',
			"Set the UI Style to something fancy!",
			'uiStyle',
			'string',
			'Standard',
			['Standard', 'Mic\'d Up']);
		addOption(option);

		var option:Option = new Option('Judgement Style',
			"Cool-ass Judgement skins :sunglasses:",
			'judgementStyle',
			'string',
			'FNF',
			['FNF', 'Kade']);
		addOption(option);

		var option:Option = new Option('Icon Set',
			"Set what icon set you\'re gonna use!",
			'iconSet',
			'string',
			'FNF',
			['FNF', 'FPS+', 'Mic\'d up']);
		addOption(option);

		var option:Option = new Option('Strum Style',
			"Set the style of the strumline!",
			'strumStyle',
			'string',
			'Normal',
			['Normal', 'Middle Scroll (Old)', 'Middle Scroll (New)', 'Opaque Enemy Strums']);
		addOption(option);

		var option:Option = new Option('UI Type',
			"If enabled, it will show advanced statistics.\n(i.e. current step and beat and etc.)",
			'uiType',
			'string',
			'Normal',
			['Normal', 'Advanced']);
		addOption(option);

		var option:Option = new Option("Test",
			'test',
			'testBool',
			'bool',
			false);
		addOption(option);

		super();
	}
}
