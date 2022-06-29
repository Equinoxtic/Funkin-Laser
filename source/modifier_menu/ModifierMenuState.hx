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
import preference_vars.ClientPrefs;
import preference_vars.ModifierVars;

using StringTools;

class ModifierMenuState extends MusicBeatState
{
	var shittyOptions:Array<String> = ['Gamemodes and OG Mods', 'Difficulty Reduction', 'Difficulty Increase', 'Fun and Deadly'];
	private var grpOptions:FlxTypedGroup<Alphabet>;
	private static var curSelected:Int = 0;
	public static var menuBG:FlxSprite;
	var ohNoes:Bool = false;

	override function create()
	{
		#if desktop
		DiscordClient.changePresence("Modifiers Menu", null);
		#end

		menuBG = new FlxSprite().loadGraphic(Paths.image('menuDesat'));
		menuBG.color = 0xFF38CAF2;
		menuBG.setGraphicSize(Std.int(menuBG.width * 1.1));
		menuBG.updateHitbox();
		menuBG.screenCenter();
		menuBG.antialiasing = ClientPrefs.globalAntialiasing;
		add(menuBG);

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		for (i in 0...shittyOptions.length) {
			var optionsText:Alphabet = new Alphabet(0, 0, shittyOptions[i], true, false);
			optionsText.screenCenter();
			optionsText.y += (100 * (i - (shittyOptions.length / 2))) + 50;
			grpOptions.add(optionsText);
		}
		
		changeSelection();

		super.create();
	}

	override function closeSubState() {
		super.closeSubState();
		ModifierVars.saveMods();
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
			ohNoes = false;
			FlxG.sound.play(Paths.sound('cancelMenu'));
			MusicBeatState.switchState(new options_menu.OptionsState());
		}

		if (controls.ACCEPT) {
			ohNoes = true;
			for (item in grpOptions.members) {
				item.alpha = 0;
			}

			switch(shittyOptions[curSelected]) {
				case 'Gamemodes and OG Mods':
					openSubState(new GamemodeSelectionSubState());
				case 'Difficulty Reduction':
					openSubState(new DifficultyReductionSubState());
				case 'Difficulty Increase':
					openSubState(new DifficultyIncreaseSubState());
				case 'Fun and Deadly':
					openSubState(new DifficultyFunSubState());
			}
			#if desktop
			DiscordClient.changePresence("Modifiers Menu - " + shittyOptions[curSelected], null);
			#end
		}
	}

	function changeSelection(change:Int = 0) {
		curSelected += change;
		if (curSelected < 0)
			curSelected = shittyOptions.length - 1;
		if (curSelected >= shittyOptions.length)
			curSelected = 0;

		var bs:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bs - curSelected;
			bs++;
			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
	}
}
