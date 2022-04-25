package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;

using StringTools;

class ModifierVars {
	// Make this as stupid as ClientPrefs.hx

	/* Gamemodes */
	public static var pussyMode:Bool = false;
	public static var hardcoreMode:Bool = false;

	/* Difficulty Reduction */
	public static var slowSong:Bool = false;
	public static var noFail:Bool = false;
	public static var disabledModcharts:Bool = false;
	public static var slowSpeed:Float = 0.75;

	/* Difficulty Increase */
	public static var fastSong:Bool = false;
	public static var ghostNotes:Bool = false;
	public static var limitedVision:Bool = false;
	public static var nauseous:Bool = false;
	public static var flipped:Bool = false;
	public static var fastSpeed:Float = 2.35;
	public static var ghostNoteAlpha:Float = 0.45;
	public static var lvIntensity:Float = 0.45;
	public static var nauseaIntensity:Float = 3.25;

	/* Fun and Deadly */
	public static var botplay:Bool = false;
	public static var hell:Bool = false;
	public static var drugs:Bool = false;
	public static var amogus:Bool = false;
	public static var drugsMulti:Float = 1.15;

	public static function saveMods() {

		/* Gamemodes */
		FlxG.save.data.pussyMode = pussyMode;
		FlxG.save.data.hardcoreMode = hardcoreMode;

		/* Difficulty Reduction */
		FlxG.save.data.slowSong = slowSong;
		FlxG.save.data.noFail = noFail;
		FlxG.save.data.disabledModcharts = disabledModcharts;
		FlxG.save.data.slowSpeed = slowSpeed;

		/* Difficulty Increase */
		FlxG.save.data.fastSong = fastSong;
		FlxG.save.data.ghostNotes = ghostNotes;
		FlxG.save.data.limitedVision = limitedVision;
		FlxG.save.data.nauseous = nauseous;
		FlxG.save.data.flipped = flipped;
		FlxG.save.data.fastSpeed = fastSpeed;
		FlxG.save.data.ghostNoteAlpha = ghostNoteAlpha;
		FlxG.save.data.lvIntensity = lvIntensity;
		FlxG.save.data.nauseaIntensity = nauseaIntensity;

		/* Fun and Deadly */
		FlxG.save.data.botplay = botplay;
		FlxG.save.data.hell = hell;
		FlxG.save.data.drugs = drugs;
		FlxG.save.data.amogus = amogus;
		FlxG.save.data.drugsMulti = 0;

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

		/* Difficulty Reduction */
		if (FlxG.save.data.slowSong != null) {
			slowSong = FlxG.save.data.slowSong;
		}

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
		if (FlxG.save.data.fastSong != null) {
			fastSong = FlxG.save.data.fastSong;
		}

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
	}
}
