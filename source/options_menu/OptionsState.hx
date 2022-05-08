package options_menu;

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

// TO DO: Redo the menu creation system for not being as dumb
class OptionsState extends MusicBeatState
{
	var options:Array<String> = ['Notes', 'Controls', 'Preferences', 'Adjust Delay and Combo', 'Extras', 'Modifiers'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;

	function switchOptionsSubstate(label:String) {
		switch(label) {
			case 'Notes':
				openSubState(new NotesSubstate());
			case 'Controls':
				openSubState(new ControlsSubstate());
			case 'Preferences':
				openSubState(new PreferencesSubstate());
			case 'Adjust Delay and Combo':
				MusicBeatState.switchState(new NoteOffsetState());
			case 'Extras':
				openSubState(new ExtraPrefsSubstate());
			case 'Modifiers':
				MusicBeatState.switchState(new modifier_menu.ModifierMenuState());
		}
	}

	override function create() {
		#if desktop
		DiscordClient.changePresence("Options Menu", null);
		#end

		menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFFea71fd;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(menuBG);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...options.length)
		{
			var optionText:Alphabet = new Alphabet(0, 0, options[i], true, false);
			optionText.screenCenter();
			optionText.y += (100 * (i - (options.length / 2))) + 50;
			grpOptions.add(optionText);
		}
		changeSelection();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ClientPrefs.saveSettings();
		changeSelection();
	}

	override function update(elapsed:Float) 
	{
		super.update(elapsed);

		if (controls.UI_UP_P) {
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}

		if (controls.BACK) {
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new MainMenuState());
		}

		if (controls.ACCEPT) {
			for (item in grpOptions.members) {
				item.alpha = 0;
			}
			switchOptionsSubstate(options[curSelected]);
			#if desktop
			DiscordClient.changePresence("Options Menu - " + options[curSelected], null);
			#end
		}
	}
	
	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = options.length - 1;
		if (curSelected >= options.length)
			curSelected = 0;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
	}
}
