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
import checkbox_utils.CheckboxThingie;
import attached_utils.AttachedText;
import preference_vars.ModifierVars;
import character_classes.Character;
import flixel.graphics.FlxGraphic;

using StringTools;

class FreeplayModMenu extends MusicBeatSubstate
{
	private static var curSelected:Int = 0;
	static var unselectableOptions:Array<String> = [
		'GAMEMODES',
		'MODS',
		'MULTIPLIERS'
	];
	static var noCheckbox:Array<String> = [
		'Health Drain Amount',
		'Song Speed'
	];
	
	static var options:Array<String> = [
		'GAMEMODES',
		'Pussy Mode',
		'Hardcore Mode',
		'MODS',
		'Botplay',
		'Practice Mode',
		'No Fail',
		'Health Drain',
		'MULTIPLIERS',
		'Health Drain Amount',
		'Song Speed'
	];

	private var grpOptions:FlxTypedGroup<Alphabet>;
	private var checkboxArray:Array<CheckboxThingie> = [];
	private var checkboxNumber:Array<Int> = [];
	private var grpTexts:FlxTypedGroup<AttachedText>;
	private var textNumber:Array<Int> = [];

	private var showCharacter:Character = null;
	private var descText:FlxText;
	var canSelectShit:Bool = false;

	public function new()
	{
		super();

		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.screenCenter();
		bg.alpha = 0;
		add(bg);
		
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

		descText = new FlxText(50, 600, 1180, "", 26);
		descText.setFormat(Paths.font("vcr.ttf"), 26, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		for (i in 0...options.length) {
			if(!unselectableCheck(i)) {
				curSelected = i;
				break;
			}
		}

		FlxTween.tween(bg, {alpha: 0.5}, 0.65, {ease: FlxEase.quartInOut, onComplete: function(twn:FlxTween) {
			canSelectShit = true;
		}});

		changeSelection();
		reloadValues();
	}

	var nextAccept:Int = 5;
	var holdTime:Float = 0;
	override function update(elapsed:Float)
	{
		if (canSelectShit) {
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
						case 'Botplay':
							ModifierVars.botplay = !ModifierVars.botplay;
						case 'Practice Mode':
							ModifierVars.practice = !ModifierVars.practice;
						case 'No Fail':
							ModifierVars.noFail = !ModifierVars.noFail;
						case 'Health Drain':
							ModifierVars.healthDrain = !ModifierVars.healthDrain;
					}
					FlxG.sound.play(Paths.sound('scrollMenu'));
					reloadValues();
				}
			} else {
				if(controls.UI_LEFT || controls.UI_RIGHT) {
					var addFloat:Float = controls.UI_LEFT ? -0.1 : 0.1;
					if(holdTime > 0.5 || controls.UI_LEFT_P || controls.UI_RIGHT_P)
					switch(options[curSelected]) {
						case 'Song Speed':
							ModifierVars.songSpeed += addFloat;
							if (ModifierVars.songSpeed < 0) ModifierVars.songSpeed = 0;
							if (ModifierVars.songSpeed > 3) ModifierVars.songSpeed = 3;
						case 'Health Drain Amount':
							ModifierVars.healthDrainAmount += addFloat;
							if (ModifierVars.healthDrainAmount < 0) ModifierVars.healthDrainAmount = 0;
							if (ModifierVars.healthDrainAmount > 5) ModifierVars.healthDrainAmount = 5;
					}
					reloadValues();

					if(holdTime <= 0) FlxG.sound.play(Paths.sound('scrollMenu'));
					holdTime += elapsed;
				} else {
					holdTime = 0;
				}
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
				daText = "If checked, the song will be slowed down.";
			case 'Hardcore Mode':
				daText = "If checked, the song will be faster, and a hard modchart plays.\n(You can make the song faster with Song Speed)";
			case 'Botplay':
				daText = "Enabling this would enable \"Botplay\" mode, which would let the game play by itself.";
			case  'Practice Mode':
				daText = "Enabling this would enable \"Practice\" mode.\nThis mode will grant you no failure, but a penalty once your HP drops to 0.";
			case 'No Fail':
				daText = "Enabling this will make you invincible.";
			case 'Song Speed':
				daText = "Set how fast the song should go.\n(Going above 0 will speed up the song)";
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
					case 'Botplay':
						daValue = ModifierVars.botplay;
					case 'Practice Mode':
						daValue = ModifierVars.practice;
					case 'No Fail':
						daValue = ModifierVars.noFail;
					case 'Health Drain':
						daValue = ModifierVars.healthDrain;
				}
				checkbox.daValue = daValue;
			}
		}
		for (i in 0...grpTexts.members.length) {
			var text:AttachedText = grpTexts.members[i];
			if(text != null) {
				var daText:String = '';
				switch(options[textNumber[i]]) {
					case 'Song Speed':
						daText = '' + ModifierVars.songSpeed;
					case 'Health Drain Amount':
						daText = '' + ModifierVars.healthDrainAmount;
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
