package;

import Controls.Control;
import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;
import flixel.group.FlxGroup.FlxTypedGroup;

using StringTools;

class NavigationBar extends MusicBeatSubstate
{
	var bg:FlxSprite;
	var sidebar:FlxSprite;
	var sidebarTop:FlxSprite;
	var sidebarTopText:FlxText;
	var sidebarContents:FlxTypedGroup<FlxText>;
	var sidebarSelectors:FlxTypedGroup<FlxSprite>;
	var canDoShit:Bool = false;
	var curSelected:Int = 0;
	var sidebarShit:Array<String> = [];

	public static var transCamera:FlxCamera;
	
	public function new()
	{
		super();

		var sidebarShit:Array<String> = [
			'Travel to Modifiers Menu',
		];

		// sidebarShit = currentSidebarShit;

		bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		bg.screenCenter();
		bg.alpha = 0;
		add(bg);

		sidebar = new FlxSprite().makeGraphic(250, FlxG.height * 2, 0xFF4F4F4F);
		sidebar.x = FlxG.width - 10;
		sidebar.alpha = 0;
		add(sidebar);

		sidebarTop = new FlxSprite().makeGraphic(250, 30, 0xFF4F4F4F);
		sidebarTop.x = sidebar.x;
		sidebarTop.y = sidebar.y + 25;
		sidebarTop.alpha = 0;
		add(sidebarTop);

		sidebarTopText = new FlxText(sidebarTop.x, sidebarTop.y, FlxG.width, "Travel To...", 18);
		sidebarTopText.setFormat(Paths.font('vcr.ttf'), 18, FlxColor.WHITE, LEFT);
		sidebarTopText.alpha = 0;
		add(sidebarTopText);

		sidebarContents = new FlxTypedGroup<FlxText>();
		add(sidebarContents);

		sidebarSelectors = new FlxTypedGroup<FlxSprite>();
		add(sidebarSelectors);

		for (i in 0...sidebarShit.length) {
			var contents:FlxText = new FlxText(sidebar.x, sidebar.y + (i * 75), FlxG.width, sidebarShit[i], 18);
			contents.setFormat(Paths.font('vcr.ttf'), 18, FlxColor.WHITE, LEFT);
			contents.alpha = 0;
			contents.ID = i;
			sidebarContents.add(contents);
			contents.updateHitbox();

			var selectorSpr:FlxSprite = new FlxSprite(sidebar.x, sidebar.y + (i * 75)).makeGraphic(30-5, 30-5, 0xFF96D0E0);
			selectorSpr.alpha = 0;
			selectorSpr.ID = i;
			sidebarSelectors.add(selectorSpr);
			selectorSpr.updateHitbox();
		}

		changeSelection();

		cameras = [FlxG.cameras.list[FlxG.cameras.list.length - 1]];

		FlxTween.tween(bg, {alpha: 0.5}, 0.65, {ease: FlxEase.quartInOut});
		FlxTween.tween(sidebar, {x: FlxG.width - 50, alpha: 1}, 0.65, {ease: FlxEase.quartInOut});
		FlxTween.tween(sidebarTop, {x: FlxG.width - 50, alpha: 1}, 0.65, {ease: FlxEase.quartInOut});
		FlxTween.tween(sidebarTopText, {x: FlxG.width - 50, alpha: 1}, 0.65, {ease: FlxEase.quartInOut});
		new FlxTimer().start(0.7, function(tmr:FlxTimer) {
			canDoShit = true;
		});
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
				canDoShit = false;
				MainMenuState.isInSubState = false;
				FlxTween.tween(bg, {alpha: 0}, 0.65, {ease: FlxEase.quartInOut});
				FlxTween.tween(sidebar, {x: FlxG.width - 10, alpha: 0}, 0.65, {ease: FlxEase.quartInOut});
				FlxTween.tween(sidebarTop, {x: FlxG.width - 10, alpha: 0}, 0.65, {ease: FlxEase.quartInOut});
				FlxTween.tween(sidebarTopText, {x: FlxG.width - 10, alpha: 0}, 0.65, {ease: FlxEase.quartInOut});
				new FlxTimer().start(0.7, function(tmr:FlxTimer) {
					close();
				});
				FlxG.sound.play(Paths.sound('cancelMenu'));
			}

			if (controls.ACCEPT) {
				sidebarContents.forEach(function(txt:FlxText) {
					if (txt.ID != curSelected) {
						FlxTween.tween(txt, {alpha: 0.45}, 0.5, {ease: FlxEase.quartInOut});
					} else {
						switchState(sidebarShit[curSelected]);
					}
				});
			}
		}
	}

	function changeSelection(change:Int = 0):Void {
		curSelected += change;
		if (curSelected >= sidebarContents.length)
			curSelected = 0;
		if (curSelected < 0)
			curSelected = sidebarContents.length - 1;
		sidebarContents.forEach(function(txt:FlxText) {
			txt.updateHitbox();
			if (txt.ID == curSelected) {
				txt.alpha = 1;
			} else {
				txt.alpha = 0.6;
			}
		});
		FlxG.sound.play(Paths.sound('scrollMenu'));
	}

	function switchState(toState:String) {
		switch(toState) {
			case 'Travel to Modifiers Menu':
				MusicBeatState.switchState(new modifier_menu.ModifierMenuState());
		}
	}
}
