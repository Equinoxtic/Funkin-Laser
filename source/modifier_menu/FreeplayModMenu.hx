//
// package modifier_menu;

// #if desktop
// import Discord.DiscordClient;
// #end
// import flash.text.TextField;
// import flixel.FlxG;
// import flixel.FlxSprite;
// import flixel.addons.display.FlxGridOverlay;
// import flixel.group.FlxGroup.FlxTypedGroup;
// import flixel.math.FlxMath;
// import flixel.text.FlxText;
// import flixel.util.FlxColor;
// import lime.utils.Assets;
// import flixel.FlxSubState;
// import flash.text.TextField;
// import flixel.FlxG;
// import flixel.FlxSprite;
// import flixel.util.FlxSave;
// import haxe.Json;
// import flixel.tweens.FlxEase;
// import flixel.tweens.FlxTween;
// import flixel.util.FlxTimer;
// import flixel.input.keyboard.FlxKey;
// import flixel.graphics.FlxGraphic;
// import options_classes.FreeplayModOption;
// import attached_utils.AttachedTextNew;
// import checkbox_utils.CheckboxThingieNew;
// import preference_vars.ModifierVars;
// import Controls;

// using StringTools;

// class FreeplayModMenu extends MusicBeatSubstate
// {
// 	private var curOption:FreeplayModOption = null;
// 	private var curSelected:Int = 0;
// 	private var optionsArray:Array<Dynamic> = [];

// 	private var grpOptions:FlxTypedGroup<Alphabet>;
// 	private var checkboxGroup:FlxTypedGroup<CheckboxThingieNew>;
// 	private var grpTexts:FlxTypedGroup<AttachedTextNew>;

// 	function getOptions()
// 	{
// 		var option:FreeplayModOption = new FreeplayModOption("Pussy Mode", 'pussymode', 'bool', false);
// 		optionsArray.push(option);

// 		var option:FreeplayModOption = new FreeplayModOption("Hardcore Mode", 'hardcoremode', 'bool', false);
// 		optionsArray.push(option);

// 		var option:FreeplayModOption = new FreeplayModOption("Botplay", 'botplay', 'bool', false);
// 		optionsArray.push(option);

// 		var option:FreeplayModOption = new FreeplayModOption("Practice Mode", 'practice', 'bool', false);
// 		optionsArray.push(option);

// 		var option:FreeplayModOption = new FreeplayModOption("No Fail", 'nofail', 'bool', false);
// 		optionsArray.push(option);

// 		var option:FreeplayModOption = new FreeplayModOption("Health Drain", 'healthdrain', 'bool', false);
// 		optionsArray.push(option);

// 		var option:FreeplayModOption = new FreeplayModOption("Health Drain Amount", 'healthdrainamount', 'percent', 0.1);
// 		optionsArray.push(option);
// 		option.displayFormat = '%vX';
// 		option.scrollSpeed = 15;
// 		option.minValue = 0.0;
// 		option.maxValue = 5;
// 		option.changeValue = 0.1;

// 		var option:FreeplayModOption = new FreeplayModOption("Song Speed Multiplier", 'songspeed', 'percent', 0);
// 		optionsArray.push(option);
// 		option.displayFormat = '%vX';
// 		option.scrollSpeed = 15;
// 		option.minValue = 0;
// 		option.maxValue = 3.5;
// 		option.changeValue = 0.1;
// 	}

// 	public function getOptionByName(name:String)
// 	{
// 		for(i in optionsArray)
// 		{
// 			var opt:FreeplayModOption = i;
// 			if (opt.name == name)
// 				return opt;
// 		}
// 		return null;
// 	}

// 	public function new()
// 	{
// 		super();
		
// 		var bg:FlxSprite = new FlxSprite().makeGraphic(FlxG.width, FlxG.height, FlxColor.BLACK);
// 		bg.alpha = 0.75;
// 		add(bg);

// 		// avoids lagspikes while scrolling through menus!
// 		grpOptions = new FlxTypedGroup<Alphabet>();
// 		add(grpOptions);

// 		grpTexts = new FlxTypedGroup<AttachedTextNew>();
// 		add(grpTexts);

// 		checkboxGroup = new FlxTypedGroup<CheckboxThingieNew>();
// 		add(checkboxGroup);
		
// 		getOptions();

// 		for (i in 0...optionsArray.length)
// 		{
// 			var optionText:Alphabet = new Alphabet(0, 70 * i, optionsArray[i].name, true, false, 0.05, 0.8);
// 			optionText.isMenuItem = true;
// 			optionText.x += 300;
// 			/*optionText.forceX = 300;
// 			optionText.yMult = 90;*/
// 			optionText.xAdd = 120;
// 			optionText.targetY = i;
// 			grpOptions.add(optionText);

// 			if(optionsArray[i].type == 'bool') {
// 				var checkbox:CheckboxThingieNew = new CheckboxThingieNew(optionText.x - 105, optionText.y, optionsArray[i].getValue() == true);
// 				checkbox.sprTracker = optionText;
// 				checkbox.offsetY = -60;
// 				checkbox.ID = i;
// 				checkboxGroup.add(checkbox);
// 				optionText.xAdd += 80;
// 			} else {
// 				var valueText:AttachedTextNew = new AttachedTextNew('' + optionsArray[i].getValue(), optionText.width + 80, true, 0.8);
// 				valueText.sprTracker = optionText;
// 				valueText.copyAlpha = true;
// 				valueText.ID = i;
// 				grpTexts.add(valueText);
// 				optionsArray[i].setChild(valueText);
// 			}
// 			updateTextFrom(optionsArray[i]);
// 		}

// 		changeSelection();
// 		reloadCheckboxes();
// 	}

// 	var nextAccept:Int = 5;
// 	var holdTime:Float = 0;
// 	var holdValue:Float = 0;
// 	override function update(elapsed:Float)
// 	{
// 		if (controls.UI_UP_P)
// 		{
// 			changeSelection(-1);
// 		}
// 		if (controls.UI_DOWN_P)
// 		{
// 			changeSelection(1);
// 		}

// 		if (controls.BACK) {
// 			close();
// 			ModifierVars.saveMods();
// 			FlxG.sound.play(Paths.sound('cancelMenu'));
// 		}

// 		if(nextAccept <= 0)
// 		{
// 			var usesCheckbox = true;
// 			if(curOption.type != 'bool')
// 			{
// 				usesCheckbox = false;
// 			}

// 			if(usesCheckbox)
// 			{
// 				if(controls.ACCEPT)
// 				{
// 					FlxG.sound.play(Paths.sound('scrollMenu'));
// 					curOption.setValue((curOption.getValue() == true) ? false : true);
// 					curOption.change();
// 					reloadCheckboxes();
// 				}
// 			} else {
// 				if(controls.UI_LEFT || controls.UI_RIGHT) {
// 					var pressed = (controls.UI_LEFT_P || controls.UI_RIGHT_P);
// 					if(holdTime > 0.5 || pressed) {
// 						if(pressed) {
// 							var add:Dynamic = null;
// 							if(curOption.type != 'string') {
// 								add = controls.UI_LEFT ? -curOption.changeValue : curOption.changeValue;
// 							}

// 							switch(curOption.type)
// 							{
// 								case 'int' | 'float' | 'percent':
// 									holdValue = curOption.getValue() + add;
// 									if(holdValue < curOption.minValue) holdValue = curOption.minValue;
// 									else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;

// 									switch(curOption.type)
// 									{
// 										case 'int':
// 											holdValue = Math.round(holdValue);
// 											curOption.setValue(holdValue);

// 										case 'float' | 'percent':
// 											holdValue = FlxMath.roundDecimal(holdValue, curOption.decimals);
// 											curOption.setValue(holdValue);
// 									}

// 								case 'string':
// 									var num:Int = curOption.curOption; //lol
// 									if(controls.UI_LEFT_P) --num;
// 									else num++;

// 									if(num < 0) {
// 										num = curOption.options.length - 1;
// 									} else if(num >= curOption.options.length) {
// 										num = 0;
// 									}

// 									curOption.curOption = num;
// 									curOption.setValue(curOption.options[num]); //lol
// 									//trace(curOption.options[num]);
// 							}
// 							updateTextFrom(curOption);
// 							curOption.change();
// 							FlxG.sound.play(Paths.sound('scrollMenu'));
// 						} else if(curOption.type != 'string') {
// 							holdValue += curOption.scrollSpeed * elapsed * (controls.UI_LEFT ? -1 : 1);
// 							if(holdValue < curOption.minValue) holdValue = curOption.minValue;
// 							else if (holdValue > curOption.maxValue) holdValue = curOption.maxValue;

// 							switch(curOption.type)
// 							{
// 								case 'int':
// 									curOption.setValue(Math.round(holdValue));
								
// 								case 'float' | 'percent':
// 									curOption.setValue(FlxMath.roundDecimal(holdValue, curOption.decimals));
// 							}
// 							updateTextFrom(curOption);
// 							curOption.change();
// 						}
// 					}

// 					if(curOption.type != 'string') {
// 						holdTime += elapsed;
// 					}
// 				} else if(controls.UI_LEFT_R || controls.UI_RIGHT_R) {
// 					clearHold();
// 				}
// 			}

// 			if(controls.RESET)
// 			{
// 				for (i in 0...optionsArray.length)
// 				{
// 					var leOption:FreeplayModOption = optionsArray[i];
// 					leOption.setValue(leOption.defaultValue);
// 					if(leOption.type != 'bool')
// 					{
// 						if(leOption.type == 'string')
// 						{
// 							leOption.curOption = leOption.options.indexOf(leOption.getValue());
// 						}
// 						updateTextFrom(leOption);
// 					}
// 				}
// 				FlxG.sound.play(Paths.sound('cancelMenu'));
// 				reloadCheckboxes();
// 			}
// 		}

// 		if(nextAccept > 0) {
// 			nextAccept -= 1;
// 		}
// 		super.update(elapsed);
// 	}

// 	function updateTextFrom(option:FreeplayModOption) {
// 		var text:String = option.displayFormat;
// 		var val:Dynamic = option.getValue();
// 		if(option.type == 'percent') val *= 100;
// 		var def:Dynamic = option.defaultValue;
// 		option.text = text.replace('%v', val).replace('%d', def);
// 	}

// 	function clearHold()
// 	{
// 		if(holdTime > 0.5) {
// 			FlxG.sound.play(Paths.sound('scrollMenu'));
// 		}
// 		holdTime = 0;
// 	}
	
// 	function changeSelection(change:Int = 0)
// 	{
// 		curSelected += change;
// 		if (curSelected < 0)
// 			curSelected = optionsArray.length - 1;
// 		if (curSelected >= optionsArray.length)
// 			curSelected = 0;

// 		var bullShit:Int = 0;

// 		for (item in grpOptions.members) {
// 			item.targetY = bullShit - curSelected;
// 			bullShit++;

// 			item.alpha = 0.6;
// 			if (item.targetY == 0) {
// 				item.alpha = 1;
// 			}
// 		}
// 		for (text in grpTexts) {
// 			text.alpha = 0.6;
// 			if(text.ID == curSelected) {
// 				text.alpha = 1;
// 			}
// 		}
// 		curOption = optionsArray[curSelected]; //shorter lol
// 		FlxG.sound.play(Paths.sound('scrollMenu'));
// 	}

// 	function reloadCheckboxes() {
// 		for (checkbox in checkboxGroup) {
// 			checkbox.daValue = (optionsArray[checkbox.ID].getValue() == true);
// 		}
// 	}
// }
