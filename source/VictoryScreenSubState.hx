package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxTimer;
import flixel.util.FlxColor;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.system.FlxSound;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.addons.transition.FlxTransitionableState;

using StringTools;

class VictoryScreenSubState extends MusicBeatSubstate
{
	var grpVictoryItems:FlxTypedGroup<Alphabet>;
	var victoryItems:Array<String> = ['Continue', 'Replay'];
	var curSelected:Int = 0;
	var grpRatingItems:FlxTypedGroup<FlxSprite>;
	var ratingItems:Array<String> = ['MFC', 'GFC', 'FC', 'SDCB', 'Clear'];
	var ratingStr:String = '';
	var soundImpact:String = '';
	var songStats:FlxText;
	var moreSongStats:FlxText;
	var bg:FlxSprite;
	var allowExit:Bool = false;

	public static var transCamera:FlxCamera;

	public function new(x:Float, y:Float)
	{
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.screenCenter();
		bg.alpha = 0.65;
		add(bg);

		songStats = new FlxText(-10 * 2, FlxG.height * 0.79 - 10, FlxG.width, "", 20);
		songStats.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		songStats.scrollFactor.set();
		songStats.borderSize = 1.25;
		add(songStats);

		moreSongStats = new FlxText(10 * 2, FlxG.height * 0.79 - 275, FlxG.width, "", 20);
		moreSongStats.setFormat(Paths.font("vcr.ttf"), 20, FlxColor.WHITE, RIGHT, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		moreSongStats.scrollFactor.set();
		moreSongStats.borderSize = 1.25;
		add(moreSongStats);

		grpVictoryItems = new FlxTypedGroup<Alphabet>();
		add(grpVictoryItems);

		for (i in 0...victoryItems.length) {
			var shit:Alphabet = new Alphabet(0, (70 * i) + 30, victoryItems[i], true, false);
			shit.isMenuItem = true;
			shit.targetY = i;
			grpVictoryItems.add(shit);
		}

		grpRatingItems = new FlxTypedGroup<FlxSprite>();
		add(grpRatingItems);

		switch(PlayState.ratingFC) {
			case 'Clear':
				ratingStr = 'N/A';
				soundImpact = 'nanda';
			case 'SDCB':
				ratingStr = 'SDCB';
				soundImpact = 'sdcb';
			case 'FC':
				ratingStr = 'FC';
				soundImpact = 'gfcorfc';
			case 'GFC':
				ratingStr = 'GFC';
				soundImpact = 'gfcorfc';
			case 'MFC':
				ratingStr = 'MFC';
				soundImpact = 'mfc';
		}

		for (i in 0...ratingItems.length) {
			var leSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image("rankings/" + ratingStr));
			leSpr.screenCenter();
			leSpr.antialiasing = ClientPrefs.globalAntialiasing;
			leSpr.alpha = 0;
			grpRatingItems.add(leSpr);
		}
		
		FlxTween.tween(bg, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut});
		FlxG.sound.play(Paths.sound("results_sounds/buildup"));
		new FlxTimer().start(1.5, function(tmr:FlxTimer) {
			FlxG.sound.play(Paths.sound("results_sounds/" + soundImpact));
			allowExit = true;
		});
		
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);
		if (controls.UI_UP_P) {
			changeSelection(-1);
		}

		if (controls.UI_DOWN_P) {
			changeSelection(1);
		}
		if (allowExit) {
			if (controls.ACCEPT) {
				grpVictoryItems.forEachAlive(function(spr:Alphabet) {
					FlxG.sound.playMusic(Paths.music('freakyMenu'));
					var ecksdee:String = victoryItems[curSelected];
					switch(ecksdee) {
						case "Restart":
							CustomFadeTransition.nextCamera = transCamera;
							MusicBeatState.resetState();
							FlxG.sound.music.volume = 0;
						case "Continue":
							if (PlayState.isStoryMode)
								MusicBeatState.switchState(new StoryMenuState());
							else
								MusicBeatState.switchState(new FreeplayState());
					}
				});
			}
		}
	}

	function changeSelection(change:Int=0):Void {
		curSelected += change;
		FlxG.sound.play(Paths.sound('scrollMenu'), 0.4);
		if (curSelected < 0)
			curSelected = victoryItems.length - 1;
		if (curSelected >= victoryItems.length)
			curSelected = 0;
		var bs:Int = 0;
		for (item in grpVictoryItems.members) {
			item.targetY = bs - curSelected;
			bs++;
			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
	}
}
