package;

#if desktop
import Discord.DiscordClient;
#end
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
	var soundImpact:String = '';
	var cheerSound:String = '';
	var bg:FlxSprite;
	var whitePulse:FlxSprite;
	var allowExit:Bool = false;
	var graphicToLoad:String = "";
	var graphicSize:Float = 0;
	var songStats:FlxText;
	var songScore:Int = PlayState.songScore;
	var rankingGraphic:String;

	public static var transCamera:FlxCamera;

	var replayed:Bool = false;
	var continued:Bool = false;

	public function new(x:Float, y:Float)
	{
		super();

		#if desktop
		DiscordClient.changePresence(PlayState.SONG.song + " - " + PlayState.ratingFC + ' (' + PlayState.rankingShit + ')', null);
		#end

		var shittyA:Float = 0;
		var shittyTime:Float = 0;

		bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.screenCenter();
		bg.alpha = 0.65;
		add(bg);

		grpVictoryItems = new FlxTypedGroup<Alphabet>();
		add(grpVictoryItems);

		for (i in 0...victoryItems.length) {
			var shit:Alphabet = new Alphabet(0, (70 * i) + 30, victoryItems[i], true, false);
			shit.isMenuItem = true;
			shit.alpha = 0;
			shit.targetY = i;
			grpVictoryItems.add(shit);
		}

		switch(PlayState.fakeRankingFC) { // For loading the rating pics
			case "N/A":
				graphicToLoad = "NA";
			default:
				graphicToLoad = PlayState.fakeRankingFC;
		}
		
		var ratingSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image("rankings/" + graphicToLoad));
		if (PlayState.fakeRankingFC == "PFC")
			ratingSpr.setGraphicSize(Std.int(ratingSpr.width * 1.5));
		ratingSpr.screenCenter(Y);
		ratingSpr.x = FlxG.width - 44 * 12;
		ratingSpr.antialiasing = ClientPrefs.globalAntialiasing;
		ratingSpr.alpha = 0;
		add(ratingSpr);

		switch(PlayState.fakeRankingShit) {
			default:
				rankingGraphic = PlayState.fakeRankingShit;
			case "N/A":
				rankingGraphic = "NA";
		}

		var rankingSpr:FlxSprite = new FlxSprite().loadGraphic(Paths.image("rankings/" + rankingGraphic.toUpperCase()));
		if (PlayState.fakeRankingShit != "X") {
			rankingSpr.setGraphicSize(Std.int(rankingSpr.width * 0.25));
			rankingSpr.x = FlxG.width - 44 * 10;
			rankingSpr.y = ratingSpr.y - 50;
		} else {
			rankingSpr.setGraphicSize(Std.int(rankingSpr.width * 0.15));
			rankingSpr.x = FlxG.width - 44 * 18;
			rankingSpr.y = ratingSpr.y - 25;
		}
		rankingSpr.screenCenter(Y);
		rankingSpr.antialiasing = ClientPrefs.globalAntialiasing;
		rankingSpr.alpha = 0;
		add(rankingSpr);

		songStats = new FlxText(0, 0, FlxG.width, "", 18);
		songStats.setFormat(Paths.font('vcr.ttf'), 18, FlxColor.WHITE, LEFT);
		songStats.scrollFactor.set();
		songStats.updateHitbox();
		songStats.x = ratingSpr.x;
		songStats.y = ratingSpr.y + 205;
		songStats.alpha = 0;
		add(songStats);

		var poopooTxt:FlxText = new FlxText(0, 0, FlxG.width, "", 18);
		poopooTxt.setFormat(Paths.font('vcr.ttf'), 18, FlxColor.WHITE, CENTER);
		poopooTxt.scrollFactor.set();
		poopooTxt.updateHitbox();
		poopooTxt.x = ratingSpr.x - 550;
		poopooTxt.y = ratingSpr.y + 150;
		poopooTxt.alpha = 0;
		add(poopooTxt);

		poopooTxt.text = "Hey you!\nWe noticed that you were in BOTPLAY mode."
		+ "\nPlease play the song again but this time without BOTPLAY."
		+ "\nThank chu!~\n~Vertic, xoxo";


		whitePulse = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.WHITE);
		whitePulse.screenCenter();
		whitePulse.alpha = 0;
		add(whitePulse);
		
		changeSelection();
		
		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		switch(PlayState.fakeRankingFC) { // For sounds
			case 'N/A':
				soundImpact = 'nanda';
				cheerSound = 'nacheer';
				shittyA = 0.05;
				shittyTime = 0.25;

			case 'SDCB':
				soundImpact = 'sdcb';
				cheerSound = 'sdcbcheer';
				shittyA = 0.15;
				shittyTime = 0.45;

			case 'FC':
				soundImpact = 'gfcorfc';
				cheerSound = 'goodcheer';
				shittyA = 0.25;
				shittyTime = 0.65;

			case 'GFC':
				soundImpact = 'gfcorfc';
				cheerSound = 'goodcheer';
				shittyA = 0.45;
				shittyTime = 0.85;

			case 'MFC':
				soundImpact = 'mfc';
				cheerSound = 'mfccheer';
				shittyA = 0.55;
				shittyTime = 1.05;

			case 'PFC':
				soundImpact = 'mfc';
				cheerSound = 'pfccheer';
				shittyA = 0.65;
				shittyTime = 1.25;
		}
		
		FlxTween.tween(bg, {alpha: 0.45}, 0.65, {ease: FlxEase.quartInOut});
		grpVictoryItems.forEachAlive(function(spr:Alphabet) {
			FlxTween.tween(spr, {alpha: 1}, 0.65, {ease: FlxEase.quartInOut});
		});
		
		if (!ModifierVars.botplay) {
			FlxG.sound.play(Paths.sound("results_sounds/buildup"));
			new FlxTimer().start(1.7, function(tmr:FlxTimer) {
				pulseShit(shittyA, shittyTime);
				FlxG.sound.play(Paths.sound("results_sounds/" + soundImpact));
				FlxG.sound.play(Paths.sound("cheer_sounds/" + cheerSound));
				FlxTween.tween(ratingSpr, {alpha: 1}, 0.15, {ease: FlxEase.backOut});
				FlxTween.tween(rankingSpr, {alpha: 1}, 0.15, {ease: FlxEase.backOut});
				FlxTween.tween(songStats, {alpha: 1}, 0.15, {ease: FlxEase.backOut});
				allowExit = true;
			});
		} else {
			FlxTween.tween(poopooTxt, {alpha: 1}, 1.1, {ease: FlxEase.quartInOut, onComplete: function(twn:FlxTween) {
				allowExit = true;
			}});
		}
	}

	override public function update(elapsed:Float) {
		super.update(elapsed);

		if (replayed || continued) {
			resetShit();
		}

		songStats.text = "TOTAL STATISTICS:\n\n"
		+ "Perfect Chains: " + PlayState.fakePerfectChains
		+ "\nScore: " + PlayState.fakeScore 
		+ "\nAccuracy: " + Highscore.floorDecimal(PlayState.fakeRatingPercent * 100, 2) + "%"
		+ "\nMisses: " + PlayState.fakeMisses
		+ "\nHits: " + PlayState.fakeHits
		+ "\nCombo: " + PlayState.fakeCombo
		+ "\nSick: " + PlayState.fakeSicks
		+ "\nGood: " + PlayState.fakeGoods
		+ "\nBad: " + PlayState.fakeBads
		+ "\nShit: " + PlayState.fakeShits;

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
						case "Replay":
							replayed = true;
							CustomFadeTransition.nextCamera = transCamera;
							MusicBeatState.resetState();
							FlxG.sound.music.volume = 0;
						case "Continue":
							continued = true;
							if (PlayState.isStoryMode) {
								if (PlayState.storyPlaylist.length <= 0) {
									FlxG.sound.playMusic(Paths.music('freakyMenu'));
								} else {
									var difficulty:String = CoolUtil.difficultyStuff[PlayState.storyDifficulty][1];
									trace('LOADING NEXT SONG');
									trace(PlayState.storyPlaylist[0].toLowerCase() + difficulty);
									PlayState.SONG = Song.loadFromJson(PlayState.storyPlaylist[0].toLowerCase() + difficulty, PlayState.storyPlaylist[0]);
									// FlxG.sound.music.stop();
									MusicBeatState.switchState(new PlayState());
								}
								MusicBeatState.switchState(new StoryMenuState());
							} else {
								MusicBeatState.switchState(new FreeplayState());
							}
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

	function pulseShit(a:Float, dur:Float) {
		whitePulse.alpha = a;
		FlxTween.tween(
			whitePulse, {alpha: 0}, dur, {ease: FlxEase.quartInOut}
		);
	}

	function resetShit() {
		PlayState.perfectChains = 0;
		PlayState.songScore = 0;
		PlayState.deathCounter = 0;
		PlayState.songHits = 0;
		PlayState.songShits = 0;
		PlayState.songBads = 0;
		PlayState.songGoods = 0;
		PlayState.songSicks = 0;
		PlayState.combo = 0;
		PlayState.songMisses = 0;
		PlayState.ghostMisses = 0;
		PlayState.ratingPercent = 0;
		PlayState.ratingString = "?";
		PlayState.ratingFC = "N/A";
		PlayState.rankingShit = "N/A";
	}
}
