package;

import flixel.FlxG;
import flixel.FlxSubState;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.tweens.FlxEase;

using StringTools;

class NavigationBar extends MusicBeatSubstate
{
	var bg:FlxSprite;
	
	public function new()
	{
		super();
		bg = new FlxSprite().makeGraphic(FlxG.width * 2, FlxG.height * 2, FlxColor.BLACK);
		bg.screenCenter();
		add(bg);
	}
}
