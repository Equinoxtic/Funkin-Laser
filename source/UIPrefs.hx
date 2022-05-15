package;

import flixel.FlxG;
import flixel.util.FlxSave;
import flixel.input.keyboard.FlxKey;
import flixel.graphics.FlxGraphic;

class UIPrefs 
{
	// make stooped

	/* UI Layout */
	public static var uiStyle:String = 'Standard';
	public static var judgementStyle:String = 'FNF';
	public static var iconSet:String = 'FNF';
	public static var strumStyle:String = 'Normal';
	public static var advancedUI:Bool = false;
	
	/* Visual Effects */
	public static var highscoreVignette:Bool = false;
	public static var vfxModcharts:Bool = false;
	public static var motionBlur:Bool = false;
	public static var allowShader:Bool = false;

	/* UI Behaviour */
	public static var noteskin:String = 'Arrows';
	public static var scoreZooming:Bool = true;
	public static var iconBop:Bool = true;
	public static var timeShowing:String = 'Time Left';
	public static var pauseMusic:String = 'Breakfast';
	
	public static function saveUIPrefs()
	{
		/* UI Layout */
		FlxG.save.data.uiStyle = uiStyle;
		FlxG.save.data.judgementStyle = judgementStyle;
		FlxG.save.data.iconSet = iconSet;
		FlxG.save.data.strumStyle = strumStyle;
		FlxG.save.data.advancedUI = advancedUI;

		/* Visual Effects */
		FlxG.save.data.vfxModcharts = vfxModcharts;
		FlxG.save.data.motionBlur = motionBlur;
		FlxG.save.data.allowShader = allowShader;

		/* UI Behaviour */
		FlxG.save.data.noteskin = noteskin;
		FlxG.save.data.scoreZooming = scoreZooming;
		FlxG.save.data.iconBop = iconBop;
		FlxG.save.data.timeShowing = timeShowing;
		FlxG.save.data.pauseMusic = pauseMusic;
	}

	public static function loadUIPrefs()
	{
		/* UI Layout */
		if (FlxG.save.data.uiStyle != null) {
			uiStyle = FlxG.save.data.uiStyle;
		}

		if (FlxG.save.data.judgementStyle != null) {
			judgementStyle = FlxG.save.data.judgementStyle;
		}

		if (FlxG.save.data.iconSet != null) {
			iconSet = FlxG.save.data.iconSet;
		}

		if (FlxG.save.data.strumStyle != null) {
			strumStyle = FlxG.save.data.strumStyle;
		}

		if (FlxG.save.data.advancedUI != null) {
			advancedUI = FlxG.save.data.advancedUI;
		}

		/* Visual Effects */
		if (FlxG.save.data.vfxModcharts != null) {
			vfxModcharts = FlxG.save.data.vfxModcharts;
		}

		if (FlxG.save.data.motionBlur != null) {
			motionBlur = FlxG.save.data.motionBlur;
		}

		if (FlxG.save.data.allowShader != null) {
			allowShader = FlxG.save.data.allowShader;
		}

		/* UI Behaviour */
		if (FlxG.save.data.noteskin != null) {
			noteskin = FlxG.save.data.noteskin;
		}

		if (FlxG.save.data.scoreZooming != null) {
			scoreZooming = FlxG.save.data.scoreZooming;
		}

		if (FlxG.save.data.iconBop != null) {
			iconBop = FlxG.save.data.iconBop;
		}

		if (FlxG.save.data.timeShowing != null) {
			timeShowing = FlxG.save.data.timeShowing;
		}

		if (FlxG.save.data.pauseMusic != null) {
			pauseMusic = FlxG.save.data.pauseMusic;
		}
	}
}