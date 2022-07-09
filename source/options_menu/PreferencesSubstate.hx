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
import attached_utils.AttachedText;
import checkbox_utils.CheckboxThingie;
import character_classes.Character;
import preference_vars.ClientPrefs;
import Controls;

using StringTools;

class PreferencesSubstate extends MusicBeatSubstate
{
	private static var curSelected:Int = 0;
	static var unselectableOptions:Array<String> = [
		'GRAPHICS',
		'GAMEPLAY'
	];
	static var noCheckbox:Array<String> = [
		'Framerate',
		'Note Delay'
	];

	static var options:Array<String> = [
		'GRAPHICS',
		'Low Quality',
		'Anti-Aliasing',
		'Persistent Cached Data',
		#if !html5
		'Framerate', //Apparently 120FPS isn't correctly supported on Browser? Probably it has some V-Sync shit enabled by default, idk
		#end
		'GAMEPLAY',
		'Hitsounds',
		'Downscroll',
		'Middlescroll',
		'Ghost Tapping',
		'Note Delay',
		'Note Splashes',
		'Advanced Score System',
		'Show Judgement Data',
		'Hide HUD',
		'Show Song Name on Song Length',
		'Hide Song Length',
		'Flashing Lights',
		'Camera Zooms'
		#if !mobile
		,'FPS Counter'
		,'Memory Counter'
		#end
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
			DiscordClient.changePresence("Options Menu", null);
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
					case 'FPS Counter':
						ClientPrefs.showFPS = !ClientPrefs.showFPS;
						if(Main.fpsVar != null)
							Main.fpsVar.visible = ClientPrefs.showFPS;

					case 'Memory Counter':
						ClientPrefs.showMemCounter = !ClientPrefs.showMemCounter;
						if(Main.memCounter != null)
							Main.memCounter.visible = ClientPrefs.showMemCounter;

					case 'Low Quality':
						ClientPrefs.lowQuality = !ClientPrefs.lowQuality;

					case 'Anti-Aliasing':
						ClientPrefs.globalAntialiasing = !ClientPrefs.globalAntialiasing;
						showCharacter.antialiasing = ClientPrefs.globalAntialiasing;
						for (item in grpOptions) {
							item.antialiasing = ClientPrefs.globalAntialiasing;
						}
						for (i in 0...checkboxArray.length) {
							var spr:CheckboxThingie = checkboxArray[i];
							if(spr != null) {
								spr.antialiasing = ClientPrefs.globalAntialiasing;
							}
						}
						OptionsState.menuBG.antialiasing = ClientPrefs.globalAntialiasing;

					case 'Note Splashes':
						ClientPrefs.noteSplashes = !ClientPrefs.noteSplashes;

					case 'Flashing Lights':
						ClientPrefs.flashing = !ClientPrefs.flashing;

					case 'Violence':
						ClientPrefs.violence = !ClientPrefs.violence;

					case 'Swearing':
						ClientPrefs.cursing = !ClientPrefs.cursing;

					case 'Hitsounds':
						ClientPrefs.hitsounds = !ClientPrefs.hitsounds;

					case 'Downscroll':
						ClientPrefs.downScroll = !ClientPrefs.downScroll;

					case 'Middlescroll':
						ClientPrefs.middleScroll = !ClientPrefs.middleScroll;

					case 'Ghost Tapping':
						ClientPrefs.ghostTapping = !ClientPrefs.ghostTapping;

					case 'Camera Zooms':
						ClientPrefs.camZooms = !ClientPrefs.camZooms;

					case 'Hide HUD':
						ClientPrefs.hideHud = !ClientPrefs.hideHud;

					case 'Advanced Score System':
						ClientPrefs.advancedScoring = !ClientPrefs.advancedScoring;

					case 'Show Judgement Data':
						ClientPrefs.showJudgementData = !ClientPrefs.showJudgementData;

					case 'Persistent Cached Data':
						ClientPrefs.imagesPersist = !ClientPrefs.imagesPersist;
						FlxGraphic.defaultPersist = ClientPrefs.imagesPersist;

					case 'Show Song Name on Song Length':
						ClientPrefs.showSongName = !ClientPrefs.showSongName;
					
					case 'Hide Song Length':
						ClientPrefs.hideTime = !ClientPrefs.hideTime;
				}
				FlxG.sound.play(Paths.sound('scrollMenu'));
				reloadValues();
			}
		} else {
			if(controls.UI_LEFT || controls.UI_RIGHT) {
				var add:Int = controls.UI_LEFT ? -1 : 1;
				if(holdTime > 0.5 || controls.UI_LEFT_P || controls.UI_RIGHT_P)
				switch(options[curSelected]) {
					case 'Framerate':
						ClientPrefs.framerate += add;
						if(ClientPrefs.framerate < 60) ClientPrefs.framerate = 60;
						else if(ClientPrefs.framerate > 240) ClientPrefs.framerate = 240;

						if(ClientPrefs.framerate > FlxG.drawFramerate) {
							FlxG.updateFramerate = ClientPrefs.framerate;
							FlxG.drawFramerate = ClientPrefs.framerate;
						} else {
							FlxG.drawFramerate = ClientPrefs.framerate;
							FlxG.updateFramerate = ClientPrefs.framerate;
						}
					case 'Note Delay':
						var mult:Int = 1;
						if(holdTime > 1.5) { //Double speed after 1.5 seconds holding
							mult = 2;
						}
						ClientPrefs.noteOffset += add * mult;
						if(ClientPrefs.noteOffset < 0) ClientPrefs.noteOffset = 0;
						else if(ClientPrefs.noteOffset > 500) ClientPrefs.noteOffset = 500;
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
			case 'Framerate':
				daText = "Pretty self explanatory, isn't it?\nDefault value is 60.";
			case 'Note Delay':
				daText = "Changes how late a note is spawned.\nUseful for preventing audio lag from wireless earphones.";
			case 'FPS Counter':
				daText = "If unchecked, hides FPS Counter.";
			case 'Memory Counter':
				daText = "If unchecked, hides Memory Counter";
			case 'Low Quality':
				daText = "If checked, disables some background details,\ndecreases loading times and improves performance.";
			case 'Persistent Cached Data':
				daText = "If checked, images loaded will stay in memory\nuntil the game is closed, this increases memory usage,\nbut basically makes reloading times instant.";
			case 'Anti-Aliasing':
				daText = "If unchecked, disables anti-aliasing, increases performance\nat the cost of the graphics not looking as smooth.";
			case 'Hitsounds':
				daText = "If checked, each note hit will play a hit sound.";
			case 'Downscroll':
				daText = "If checked, notes go Down instead of Up, simple enough.";
			case 'Middlescroll':
				daText = "If checked, hides Opponent's notes and your notes get centered.";
			case 'Ghost Tapping':
				daText = "If checked, you won't get misses from pressing keys\nwhile there are no notes able to be hit.";
			case 'Swearing':
				daText = "If unchecked, your mom won't be angry at you.";
			case 'Violence':
				daText = "If unchecked, you won't get disgusted as frequently.";
			case 'Note Splashes':
				daText = "If unchecked, hitting \"Sick!\" notes won't show particles.";
			case 'Flashing Lights':
				daText = "Uncheck this if you're sensitive to flashing lights!";
			case 'Camera Zooms':
				daText = "If unchecked, the camera won't zoom in on a beat hit.";
			case 'Advanced Score System':
				daText = "If checked, you will enable the Advanced Scoring System.\n(Hotline 024 inspiration)";
			case 'Show Judgement Data':
				daText = "Hides the Judgement Counter when unchecked.";
			case 'Hide HUD':
				daText = "If checked, hides most HUD elements.";
			case 'Show Song Name on Song Length':
				daText = "If unchecked, the song name on the time bar will be hidden.";
			case 'Hide Song Length':
				daText = "If checked, the bar showing how much time is left\nwill be hidden.";
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
					case 'FPS Counter':
						daValue = ClientPrefs.showFPS;
					case 'Memory Counter':
						daValue = ClientPrefs.showMemCounter;
					case 'Low Quality':
						daValue = ClientPrefs.lowQuality;
					case 'Anti-Aliasing':
						daValue = ClientPrefs.globalAntialiasing;
					case 'Note Splashes':
						daValue = ClientPrefs.noteSplashes;
					case 'Flashing Lights':
						daValue = ClientPrefs.flashing;
					case 'Hitsounds':
						daValue = ClientPrefs.hitsounds;
					case 'Downscroll':
						daValue = ClientPrefs.downScroll;
					case 'Middlescroll':
						daValue = ClientPrefs.middleScroll;
					case 'Ghost Tapping':
						daValue = ClientPrefs.ghostTapping;
					case 'Swearing':
						daValue = ClientPrefs.cursing;
					case 'Violence':
						daValue = ClientPrefs.violence;
					case 'Camera Zooms':
						daValue = ClientPrefs.camZooms;
					case 'Advanced Score System':
						daValue = ClientPrefs.advancedScoring;
					case 'Show Judgement Data':
						daValue = ClientPrefs.showJudgementData;
					case 'Hide HUD':
						daValue = ClientPrefs.hideHud;
					case 'Persistent Cached Data':
						daValue = ClientPrefs.imagesPersist;
					case 'Show Song Name on Song Length':
						daValue = ClientPrefs.showSongName;
					case 'Hide Song Length':
						daValue = ClientPrefs.hideTime;
				}
				checkbox.daValue = daValue;
			}
		}
		for (i in 0...grpTexts.members.length) {
			var text:AttachedText = grpTexts.members[i];
			if(text != null) {
				var daText:String = '';
				switch(options[textNumber[i]]) {
					case 'Framerate':
						daText = '' + ClientPrefs.framerate;
					case 'Note Delay':
						daText = ClientPrefs.noteOffset + 'ms';
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
