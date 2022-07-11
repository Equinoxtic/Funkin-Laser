package preference_vars;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;

using StringTools;

class ModifierVars {
	// Make this as stupid as ClientPrefs.hx

	/* Gamemodes and Regualar Modifiers */
	public static var pussyMode:Bool = false;
	public static var hardcoreMode:Bool = false;
	public static var endlessMode:Bool = false;
	public static var ssMode:Bool = false;
	public static var healthDrain:Bool = false;
	public static var screenShake:Bool = false;
	public static var enigma:Bool = false;
	public static var songSpeed:Float = 1;
	public static var healthDrainAmount:Float = 0.1;
	public static var screenShakeIntensity:Float = 0.005;

	/* Difficulty Reduction */
	// public static var lofi:Bool = false;
	public static var noFail:Bool = false;
	public static var disabledModcharts:Bool = false;
	public static var slowSpeed:Float = 0.75;

	/* Difficulty Increase */
	// public static var hifi:Bool = false;
	public static var ghostNotes:Bool = false;
	public static var limitedVision:Bool = false;
	public static var nauseous:Bool = false;
	public static var flipped:Bool = false;
	public static var fastSpeed:Float = 2.35;
	public static var ghostNoteAlpha:Float = 0.45;
	public static var lvIntensity:Float = 0.45;
	public static var nauseaIntensity:Float = 0.5;

	/* Fun and Deadly */
	public static var botplay:Bool = false;
	public static var practice:Bool = false;
	public static var hell:Bool = false;
	public static var drugs:Bool = false;
	public static var amogus:Bool = false;
	public static var drugsMulti:Float = 1.15;

	/*
	public static var modMap:Map<String, Dynamic> = [
		'hardcoremode' => false,
		'pussymode' => false, 
		'practice' => false,
		'botplay' => false,
		'healthdrain' => false,
		'healthdrainamount' => 0.1,
		'songspeed' => 0
	];
	*/

	public static function saveMods() {

		/* Gamemodes */
		FlxG.save.data.pussyMode = pussyMode;
		FlxG.save.data.hardcoreMode = hardcoreMode;
		FlxG.save.data.endlessMode = endlessMode;
		FlxG.save.data.ssMode = ssMode;
		FlxG.save.data.healthDrain = healthDrain;
		FlxG.save.data.screenShake = screenShake;
		FlxG.save.data.enigma = enigma;
		FlxG.save.data.songSpeed = songSpeed;
		FlxG.save.data.healthDrainAmount = healthDrainAmount;
		FlxG.save.data.screenShakeIntensity = screenShakeIntensity;

		/* Difficulty Reduction */
		// FlxG.save.data.lofi = lofi;
		FlxG.save.data.noFail = noFail;
		FlxG.save.data.disabledModcharts = disabledModcharts;
		// FlxG.save.data.slowSpeed = slowSpeed;

		/* Difficulty Increase */
		// FlxG.save.data.hifi = hifi;
		FlxG.save.data.ghostNotes = ghostNotes;
		FlxG.save.data.limitedVision = limitedVision;
		FlxG.save.data.nauseous = nauseous;
		FlxG.save.data.flipped = flipped;
		// FlxG.save.data.fastSpeed = fastSpeed;
		FlxG.save.data.ghostNoteAlpha = ghostNoteAlpha;
		FlxG.save.data.lvIntensity = lvIntensity;
		FlxG.save.data.nauseaIntensity = nauseaIntensity;

		/* Fun and Deadly */
		FlxG.save.data.botplay = botplay;
		FlxG.save.data.practice = practice;
		FlxG.save.data.hell = hell;
		FlxG.save.data.drugs = drugs;
		FlxG.save.data.amogus = amogus;
		FlxG.save.data.drugsMulti = 0;

		// FlxG.save.data.modMap = modMap;

		/* Saving */
		FlxG.save.flush();
	}

	public static function loadMods() {
		/* Gamemodes */
		if (FlxG.save.data.pussyMode != null) {
			pussyMode = FlxG.save.data.pussyMode;
		}

		if (FlxG.save.data.hardcoreMode != null) {
			hardcoreMode = FlxG.save.data.hardcoreMode;
		}

		if (FlxG.save.data.endlessMode != null) {
			endlessMode = FlxG.save.data.endlessMode;
		}

		if (FlxG.save.data.ssMode != null) {
			ssMode = FlxG.save.data.ssMode;
		}

		if (FlxG.save.data.healthDrain != null) {
			healthDrain = FlxG.save.data.healthDrain;
		}

		if (FlxG.save.data.screenShake != null) {
			screenShake = FlxG.save.data.screenShake;
		}

		if (FlxG.save.data.enigma != null) {
			enigma = FlxG.save.data.enigma;
		}

		if (FlxG.save.data.songSpeed != null) {
			songSpeed = FlxG.save.data.songSpeed;
		}

		if (FlxG.save.data.healthDrainAmount != null) {
			healthDrainAmount = FlxG.save.data.healthDrainAmount;
		}

		if (FlxG.save.data.screenShakeIntensity != null) {
			screenShakeIntensity = FlxG.save.data.screenShakeIntensity;
		}

		/* Difficulty Reduction */
		// if (FlxG.save.data.lofi != null) {
		// 	lofi = FlxG.save.data.lofi;
		// }

		if (FlxG.save.data.noFail != null) {
			noFail = FlxG.save.data.noFail;
		}
		
		if (FlxG.save.data.disabledModcharts != null) {
			disabledModcharts = FlxG.save.data.disabledModcharts;
		}

		if (FlxG.save.data.slowSpeed != null) {
			slowSpeed = FlxG.save.data.slowSpeed;
		}

		/* Difficulty Increase */
		// if (FlxG.save.data.hifi != null) {
		// 	hifi = FlxG.save.data.hifi;
		// }

		if (FlxG.save.data.ghostNotes != null) {
			ghostNotes = FlxG.save.data.ghostNotes;
		}

		if (FlxG.save.data.limitedVision != null) {
			limitedVision = FlxG.save.data.limitedVision;
		}

		if (FlxG.save.data.nauseous != null) {
			nauseous = FlxG.save.data.nauseous;
		}

		if (FlxG.save.data.flipped != null) {
			flipped = FlxG.save.data.flipped;
		}

		if (FlxG.save.data.fastSpeed != null) {
			fastSpeed = FlxG.save.data.fastSpeed;
		}

		if (FlxG.save.data.ghostNoteAlpha != null) {
			ghostNoteAlpha = FlxG.save.data.ghostNoteAlpha;
		}

		if (FlxG.save.data.lvIntensity != null) {
			lvIntensity = FlxG.save.data.lvIntensity;
		}

		if (FlxG.save.data.nauseaIntensity != null) {
			nauseaIntensity = FlxG.save.data.nauseaIntensity;
		}

		/* Fun and Deadly */
		if (FlxG.save.data.botplay != null) {
			botplay = FlxG.save.data.botplay;
		}

		if (FlxG.save.data.practice != null) {
			practice = FlxG.save.data.practice;
		}

		if (FlxG.save.data.hell != null) {
			hell = FlxG.save.data.hell;
		}

		if (FlxG.save.data.drugs != null) {
			drugs = FlxG.save.data.drugs;
		}

		if (FlxG.save.data.amogus != null) {
			amogus = FlxG.save.data.amogus;
		}

		if (FlxG.save.data.drugsMulti != null) {
			drugsMulti = FlxG.save.data.drugsMulti;
		}

		/*
		if(FlxG.save.data.modMap != null)
		{
			var savedMap:Map<String, Dynamic> = FlxG.save.data.modMap;
			for (name => value in savedMap)
			{
				modMap.set(name, value);
			}
		}
		*/
	}

	/* inline public static function getGameplaySetting(name:String, defaultValue:Dynamic):Dynamic {
		return PlayState.isStoryMode ? defaultValue : (modMap.exists(name) ? modMap.get(name) : defaultValue);
	} */
}
