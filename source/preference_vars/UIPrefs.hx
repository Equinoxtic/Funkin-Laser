package preference_vars;

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
	// public static var strumStyle:String = 'Normal';
	public static var uiType:String = "Normal";
	public static var useVignette:Bool = true;
	
	/* Visual Effects
	public static var highscoreVignette:Bool = false;
	public static var vfxModcharts:Bool = false;
	public static var motionBlur:Bool = false;
	public static var allowShader:Bool = falsee */
	public static var strumTailShader:Bool = true;
	public static var strumTailShaderType:String = "Wiggle";

	/* UI Behaviour */
	public static var noteskin:String = 'Arrows';
	public static var timeShowing:String = 'Time Left';
	public static var iconBop:Bool = true;
	public static var scoreZooming:Bool = true;
	public static var healthBarType:String = "Default";
	public static var timeBarColors:Bool = false;
	
	/* Sound & Music Effects */
	public static var hitsounds:Bool = true;
	public static var hitsoundsVolume:Float = 0.5;
	public static var missSounds:Bool = true;
	public static var pauseMusic:String = 'Breakfast';
	
	public static function saveUIPrefs()
	{
		/* UI Layout */
		FlxG.save.data.uiStyle = uiStyle;
		FlxG.save.data.judgementStyle = judgementStyle;
		FlxG.save.data.iconSet = iconSet;
		// FlxG.save.data.strumStyle = strumStyle;
		FlxG.save.data.uiType = uiType;
		FlxG.save.data.useVignette = useVignette;

		/* Visual Effects */
		/* FlxG.save.data.vfxModcharts = vfxModcharts;
		FlxG.save.data.motionBlur = motionBlur;
		FlxG.save.data.allowShader = allowShader; */
		FlxG.save.data.strumTailShader =  strumTailShader;
		FlxG.save.data.strumTailShaderType = strumTailShaderType;

		/* UI Behaviour */
		FlxG.save.data.noteskin = noteskin;
		FlxG.save.data.timeShowing = timeShowing;
		FlxG.save.data.pauseMusic = pauseMusic;
		FlxG.save.data.iconBop = iconBop;
		FlxG.save.data.scoreZooming = scoreZooming;
		FlxG.save.data.healthBarType = healthBarType;
		FlxG.save.data.timeBarColors = timeBarColors;

		/* Sound & Music effects */
		FlxG.save.data.hitsounds = hitsounds;
		FlxG.save.data.hitsoundsVolume = hitsoundsVolume;
		FlxG.save.data.missSounds = missSounds;
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

		/* if (FlxG.save.data.strumStyle != null) {
			strumStyle = FlxG.save.data.strumStyle;
		} */

		if (FlxG.save.data.uiType != null) {
			uiType = FlxG.save.data.uiType;
		}

		if (FlxG.save.data.useVignette != null) {
			useVignette = FlxG.save.data.useVignette;
		}

		/* Visual Effects
		if (FlxG.save.data.vfxModcharts != null) {
			vfxModcharts = FlxG.save.data.vfxModcharts;
		}

		if (FlxG.save.data.motionBlur != null) {
			motionBlur = FlxG.save.data.motionBlur;
		}

		if (FlxG.save.data.allowShader != null) {
			allowShader = FlxG.save.data.allowShader;
		} */
		if (FlxG.save.data.strumTailShader != null) {
			strumTailShader = FlxG.save.data.strumTailShader;
		}
		if (FlxG.save.data.strumTailShaderType != null) {
			strumTailShaderType = FlxG.save.data.strumTailShaderType;
		}

		/* UI Behaviour */
		if (FlxG.save.data.noteskin != null) {
			noteskin = FlxG.save.data.noteskin;
		}

		if (FlxG.save.data.timeShowing != null) {
			timeShowing = FlxG.save.data.timeShowing;
		}

		if (FlxG.save.data.pauseMusic != null) {
			pauseMusic = FlxG.save.data.pauseMusic;
		}

		if (FlxG.save.data.iconBop != null) {
			iconBop = FlxG.save.data.iconBop;
		}

		if (FlxG.save.data.scoreZooming != null) {
			scoreZooming = FlxG.save.data.scoreZooming;
		}

		if (FlxG.save.data.healthBarType != null) {
			healthBarType = FlxG.save.data.healthBarType;
		}

		if (FlxG.save.data.timeBarColors != null) {
			timeBarColors = FlxG.save.data.timeBarColors;
		}

		/* Sound & Music Effects */
		if (FlxG.save.data.hitsounds != null) {
			hitsounds = FlxG.save.data.hitsounds;
		}

		if (FlxG.save.data.hitsoundsVolume != null) {
			hitsoundsVolume = FlxG.save.data.hitsoundsVolume;
		}

		if (FlxG.save.data.missSounds != null) {
			missSounds = FlxG.save.data.missSounds;
		}

		if (FlxG.save.data.pauseMusic != null) {
			pauseMusic = FlxG.save.data.pauseMusic;
		}
	}
}