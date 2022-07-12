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

class CameraSettings extends BaseOptionsMenu
{
	public function new()
	{
		title = "Camera Settings";
		rpcTitle = "Preferences - Camera Settings";
		getOptions();
		super();
	}

	function getOptions()
	{
		var option:Option = new Option("Camera Zooms",
			"If unchecked, the camera won't zoom in on a beat hit.",
			'camZooms',
			'bool',
			true);
		addOptions(option);

		var option:Option = new Option("Hide HUD",
			"If checked, hides most HUD elements.",
			'hideHud',
			'bool',
			false);
		addOption(option);

		var option:Option = new Option("Directional Camera",
			"If checked, the camera moves with the focused character's directional animations.",
			'directionalCamera',
			'bool',
			true);
		addOption(option);
	}
}
