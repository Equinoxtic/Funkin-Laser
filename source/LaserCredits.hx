package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxCamera;
import flixel.FlxSprite;
import flixel.FlxSubState;
import flixel.text.FlxText;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class LaserCredits extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var curSelected:Int = 0;
	var descText:FlxText;
	var grpCreditIcons:FlxTypedGroup<FlxSprite>;
	var grpCreditNames:FlxTypedGroup<Alphabet>;
	var creditShit:Array<String> = [
		"Vertic",
		"Verwex",
		"Shadow Mario"
	];

	var canDoShit:Bool = false;

	public static var transCamera:FlxCamera;

	public function new()
	{
		super();

		bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		bg.scrollFactor.set();
		bg.screenCenter();
		bg.alpha = 0;
		add(bg);

		/*
		grpCreditIcons = new FlxTypedGroup<FlxSprite>();
		add(grpCreditIcons);
		grpCreditNames = new FlxTypedGroup<Alphabet>();
		add(grpCreditNames);

		for (i in 0...creditShit.length) {
			var icons:FlxSprite = new FlxSprite().loadGraphic(Paths.font('laser-icons/' + creditShit[i].toLowerCase()));
			icons.antialiasing = ClientPrefs.globalAntialiasing;
			grpCreditIcons.add(icons);
			icons.updateHitbox();
		}
		*/

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		descText = new FlxText(50, 600, 1180, "", 32);
		descText.setFormat(Paths.font("vcr.ttf"), 32, FlxColor.WHITE, CENTER, FlxTextBorderStyle.OUTLINE, FlxColor.BLACK);
		descText.scrollFactor.set();
		descText.borderSize = 2.4;
		add(descText);

		FlxTween.tween(bg, {alpha: 0.5}, 0.75, {ease: FlxEase.quartInOut, onComplete: function(twn:FlxTween) {
			canDoShit = true;
		}});
	}

	override public function update(elapsed:Float)
	{
		super.update(elapsed);

		if (canDoShit) {
			if (controls.UI_UP_P) {
				changeSelection(-1);
			}

			if (controls.UI_DOWN_P) {
				changeSelection(1);
			}

			if (controls.BACK) {
				FlxTween.tween(bg, {alpha: 0}, 0.75, {ease: FlxEase.quartInOut});
				new FlxTimer().start(0.80, function(tmr:FlxTimer) {
					close();
				});
			}
		}
	}

	function changeSelection(change:Int = 0) {
		change += curSelected;
		if (curSelected < 0)
			curSelected = creditShit.length - 1;
		if (curSelected >= creditShit.length)
			curSelected = 0;
		var txt:String = "";
		switch(creditShit[curSelected]) {
			case "Vertic":
				txt = "Main Developer + Programmer of Funkin' Laser.";
			case "Verwex":
				txt = "Main Developer of Mic'd Up. (Engine Inspiration)";
			case "Shadow Mario":
				txt = "Main Programmer of Psych Engine";
		}
		descText.text = txt;
		var bs:Int = 0;
		for (item in grpCreditNames.members) {
			item.targetY = bs - curSelected;
			bs++;
			item.alpha = 0.6;
			if (item.targetY == 0) {
				item.alpha = 1;
			}
		}
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}
}
