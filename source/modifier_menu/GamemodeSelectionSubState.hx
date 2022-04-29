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

using StringTools;

class GamemodeSelectionSubState extends MusicBeatSubstate
{
	private static var curSelected:Int = 0;
	static var unselectableOptions:Array<String> = [
		'GAMEMODES',
		'MODIFIERS',
		'MULTIPLIERS'
	];

	static var noCheckbox:Array<String> = [
		'Song Speed',
		'Health Drain Amount',
		'Screen Shake Intensity'
	];

	static var options:Array<String> = [
		'GAMEMODES',
		'Pussy Mode',
		'Hardcore Mode',
		'Endless Mode',
		'MODIFIERS',
		'Perfection',
		'Health Drain',
		'Screen Shake',
		'Enigma',
		'MULTIPLIERS',
		'Song Speed',
		'Health Drain Amount',
		'Screen Shake Intensity'
	];

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var checkboxArray:Array<CheckboxThingie> = [];
	private var checkboxNumber:Array<Int> = [];
	private var grpTexts:FlxTypedGroup<AttachedText>;
	private var textNumber:Array<Int> = [];

	private var showCharacter:Character = null;
	private var descText:FlxText;

	public function new()
	{
		super();
		// avoids lagspikes while scrolling through menus!
		showCharacter = new Character(840, 170, 'bf', true);
		showCharacter.setGraphicSize(Std.int(showCharacter.width * 0.8));
		showCharacter.updateHitbox();
		showCharacter.dance();
		add(showCharacter);
		showCharacter.visible = false;

		grpOptions = new FlxTypedGroup<Alphabet>();
		add(grpOptions);

		grpTexts = new FlxTypedGroup<AttachedText>();
		add(grpTexts);

		for (i in 0...options.length)
		{
			var isCentered:Bool = unselectableCheck(i);
			var optionText:Alphabet = new Alphabet(0, 70 * i, options[i], false, false);
			optionText.isMenuItem = true;
			if(isCentered) {
				optionText.screenCenter(X);
				optionText.forceX = optionText.x;
			} else {
				optionText.x += 300;
				optionText.forceX = 300;
			}
			optionText.yMult = 90;
			optionText.targetY = i;
			grpOptions.add(optionText);

			if(!isCentered) {
				var useCheckbox:Bool = true;
				for (j in 0...noCheckbox.length) {
					if(options[i] == noCheckbox[j]) {
						useCheckbox = false;
						break;
					}
				}

				if(useCheckbox) {
					var checkbox:CheckboxThingie = new CheckboxThingie(optionText.x - 105, optionText.y, false);
					checkbox.sprTracker = optionText;
					checkboxArray.push(checkbox);
					checkboxNumber.push(i);
					add(checkbox);
				} else {
					var valueText:AttachedText = new AttachedText('0', optionText.width + 80);
					valueText.sprTracker = optionText;
					grpTexts.add(valueText);
					textNumber.push(i);
				}
			}
		}

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		for (i in 0...options.length) {
			if(!unselectableCheck(i)) {
				curSelected = i;
				break;
			}
		}
		changeSelection();
		reloadValues();
	}

	var nextAccept:Int = 5;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (controls.UI_UP_P)
		{
			changeSelection(-1);
		}
		if (controls.UI_DOWN_P)
		{
			changeSelection(1);
		}

		if (controls.BACK) {
			grpOptions.forEachAlive(function(spr:Alphabet) {
				spr.alpha = 0;
			});
			grpTexts.forEachAlive(function(spr:AttachedText) {
				spr.alpha = 0;
			});
			for (i in 0...checkboxArray.length) {
				var spr:CheckboxThingie = checkboxArray[i];
				if(spr != null) {
					spr.alpha = 0;
				}
			}
			if(showCharacter != null) {
				showCharacter.alpha = 0;
			}
			descText.alpha = 0;
			close();
			FlxG.sound.play(Paths.sound('cancelMenu'));
			#if desktop
			DiscordClient.changePresence("Modifiers Menu", null);
			#end
		}

		var usesCheckbox = true;
		for (i in 0...noCheckbox.length) {
			if(options[curSelected] == noCheckbox[i]) {
				usesCheckbox = false;
				break;
			}
		}

		if(usesCheckbox) {
			if(controls.ACCEPT && nextAccept <= 0) {
				switch(options[curSelected]) {
					case 'Pussy Mode':
						ModifierVars.pussyMode = !ModifierVars.pussyMode;
					case 'Hardcore Mode':
						ModifierVars.hardcoreMode = !ModifierVars.hardcoreMode;
					case 'Endless Mode':
						ModifierVars.endlessMode = !ModifierVars.endlessMode;
					case 'Perfection':
						ModifierVars.ssMode = !ModifierVars.ssMode;
					case 'Health Drain':
						ModifierVars.healthDrain = !ModifierVars.healthDrain;
					case 'Screen Shake':
						ModifierVars.screenShake = !ModifierVars.screenShake;
					case 'Enigma':
						ModifierVars.enigma = !ModifierVars.enigma;
				}
				FlxG.sound.play(Paths.sound('scrollMenu'));
				reloadValues();
			}
		} else {
			if(controls.UI_LEFT || controls.UI_RIGHT) {
				var addFloat:Float = controls.UI_LEFT ? -0.01 : 0.01;
				if(holdTime > 0.5 || controls.UI_LEFT_P || controls.UI_RIGHT_P)
				switch(options[curSelected]) {
					case 'Song Speed':
						ModifierVars.songSpeed += addFloat;
					case 'Health Drain Amount':
						ModifierVars.healthDrainAmount += addFloat;
					case 'Screen Shake Intensity':
						ModifierVars.screenShakeIntensity += addFloat;
				}
				reloadValues();

				if(holdTime <= 0) FlxG.sound.play(Paths.sound('scrollMenu'));
				holdTime += elapsed;
			} else {
				holdTime = 0;
			}
		}

		if(showCharacter != null && showCharacter.animation.curAnim.finished) {
			showCharacter.dance();
		}

		if(nextAccept > 0) {
			nextAccept -= 1;
		}
		super.update(elapsed);
	}
	
	function changeSelection(change:Int = 0)
	{
		do {
			curSelected += change;
			if (curSelected < 0)
				curSelected = options.length - 1;
			if (curSelected >= options.length)
				curSelected = 0;
		} while(unselectableCheck(curSelected));

		var daText:String = '';
		switch(options[curSelected]) {
			case 'Pussy Mode':
				daText = "If checked, Modcharts will have a debuff and the song will be slowed down.\n(Not compatible with Hardcore Mode)";
			case 'Hardcore Mode':
				daText = "If checked, Modcharts will be a lot more harder, and the song will be majorly sped up.\n(Not compatible with Pussy Mode)";
			case 'Endless Mode':
				daText = "If checked, the game would keep repeating itself once the song is over.";
			case 'Perfection':
				daText = "No missing in the song, or death.";
			case 'Health Drain':
				daText = "If checked, you will have a certain and modifiable amount of health drain during the song.";
			case 'Screen Shake':
				daText = "If checked, the screen will shake during the song.";
			case 'Enigma':
				daText = "If this modifier is allowed, the healthbar will be inivisble.";
			case 'Song Speed':
				daText = "Increment the amount of speed you want for your song.";
			case 'Health Drain Amount':
				daText = "Set the value of how much health drain you should be getting.\n(Must have Health Drain mod on)";
			case 'Screen Shake Intensity':
				daText = "Set the value of how intense the screen will shake during the song.\n(Must have the Screen Shake mod on)";
		}
		descText.text = daText;

		var bullShit:Int = 0;

		for (item in grpOptions.members) {
			item.targetY = bullShit - curSelected;
			bullShit++;

			if(!unselectableCheck(bullShit-1)) {
				item.alpha = 0.6;
				if (item.targetY == 0) {
					item.alpha = 1;
				}

				for (j in 0...checkboxArray.length) {
					var tracker:FlxSprite = checkboxArray[j].sprTracker;
					if(tracker == item) {
						checkboxArray[j].alpha = item.alpha;
						break;
					}
				}
			}
		}
		for (i in 0...grpTexts.members.length) {
			var text:AttachedText = grpTexts.members[i];
			if(text != null) {
				text.alpha = 0.6;
				if(textNumber[i] == curSelected) {
					text.alpha = 1;
				}
			}
		}

		showCharacter.visible = (options[curSelected] == 'Anti-Aliasing');
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function reloadValues() {
		for (i in 0...checkboxArray.length) {
			var checkbox:CheckboxThingie = checkboxArray[i];
			if(checkbox != null) {
				var daValue:Bool = false;
				switch(options[checkboxNumber[i]]) {
					case 'Pussy Mode':
						daValue = ModifierVars.pussyMode;
					case 'Hardcore Mode':
						daValue = ModifierVars.hardcoreMode;
					case 'Endless Mode':
						daValue = ModifierVars.endlessMode;
					case 'Perfection':
						daValue = ModifierVars.ssMode;
					case 'Health Drain':
						daValue = ModifierVars.healthDrain;
					case 'Screen Shake':
						daValue = ModifierVars.screenShake;
					case 'Enigma':
						daValue = ModifierVars.enigma;
				}
				checkbox.daValue = daValue;
			}
		}
		for (i in 0...grpTexts.members.length) {
			var text:AttachedText = grpTexts.members[i];
			if(text != null) {
				var daText:String = '';
				switch(options[textNumber[i]]) {
					case 'Slow Song Multiplier':
						daText = '' + ModifierVars.slowSpeed;
					case 'Health Drain Amount':
						daText = '' + ModifierVars.healthDrainAmount;
					case 'Screen Shake Intensity':
						daText = '' + ModifierVars.screenShakeIntensity;
				}
				var lastTracker:FlxSprite = text.sprTracker;
				text.sprTracker = null;
				text.changeText(daText);
				text.sprTracker = lastTracker;
			}
		}
	}

	private function unselectableCheck(num:Int):Bool {
		for (i in 0...unselectableOptions.length) {
			if(options[num] == unselectableOptions[i]) {
				return true;
			}
		}
		return options[num] == '';
	}
}
