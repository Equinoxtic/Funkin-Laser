package display.laser.ui;

import openfl.events.Event;
import openfl.system.System;
import openfl.text.TextField;
import openfl.text.TextFormat;

/**
 * FPS class extension to display memory usage.
 * @author Kirill Poletaev
 */

class MemCounter extends TextField
{
	private var times:Array<Float>;
	private var memPeak:Float = 0;
	
	public function new(inX:Float = 10.0, inY:Float = 10.0, inCol:Int = 0x000000) 
	{
		super();

		x = inX;
		y = inY;
		selectable = false;
		mouseEnabled = false;
		defaultTextFormat = new TextFormat("_sans", 14, inCol);
		autoSize = LEFT;
		multiline = true;

		addEventListener(Event.ENTER_FRAME, onEnter);
		width = 250;
		height = 70;
	}

	private function onEnter(_)
	{	
		var mem:Float = Math.round(System.totalMemory / 1024 / 1024 * 100)/100;
		if (mem > memPeak) memPeak = mem;

		if (visible)
		{	
			text = "\nMemory: " + mem + " MB\nMEM peak: " + memPeak + " MB";	
		}
	}
}