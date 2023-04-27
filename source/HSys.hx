package;

import flash.system.System;
import flixel.input.touch.FlxTouch;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.AssetType;
import openfl.utils.Assets;
import haxe.CallStack;
import flixel.FlxG;
import openfl.Lib;

using StringTools;

/*
* A quicker way to replace #if sys,
* and some extra help.
* Author: @Musk-h
*/
class HSys
{
	/*
	** https://api.haxeflixel.com/openfl/utils/AssetType.html
	*/
	public static function exists(folder:String, ?type:AssetType = null):Bool
	{
		var format:String = '';

		switch (type)
		{
			case FONT:
				format = '.ttf';
				if (!Assets.exists(folder + format))
					format = '.otf';
			case IMAGE:
				format = '.png';
			case MOVIE_CLIP:
				format = '.swf';
			case MUSIC | SOUND:
				format = '.ogg';
			case TEXT:
				format = '.txt';
				if (!Assets.exists(folder + format))
					format = '.xml';
			case BINARY | TEMPLATE:
				format = '.ay cabron';
				trace('Return: Put the file format in the path.');
		}

		return Assets.exists(folder + format);
	}

	public static function getContent(library:String):String
	{
		return Assets.getText(library);
	}

	/*
	** https://api.haxeflixel.com/Array.html
	** https://api.haxeflixel.com/String.html
	*/
	public static function readDirectory(library:String):Array<String>
	{
		var libraryArray:Array<String> = [];
		var gettt = Assets.list();

		for (folder in gettt.filter(file -> file.contains('$library')))
		{
			/*
			** folder.replace('$library/', '');
			** newFolder = folder; El string se convertía en 'assets' xdxdxdxdxjaskdjasd
			*/
			var newFolder:String = folder.replace('$library/', '');
			if (newFolder.contains('/'))
				newFolder = newFolder.replace(newFolder.substring(newFolder.indexOf('/'), newFolder.length), '');
			if (!libraryArray.contains(newFolder) && !newFolder.startsWith('.'))
				libraryArray.push(newFolder);
		}

		libraryArray.sort(function(a:String, b:String):Int 
		{
			a = a.toUpperCase();
			b = b.toUpperCase();

			if (a < b)
				return -1;
			else if (a > b)
				return 1;
			else
				return 0;
		});

		return libraryArray;
	}
	
	public static function justTouched():Bool
	{
		var justTouched:Bool = false;

		for (touch in FlxG.touches.list)
		{
			if (touch.justPressed)
				justTouched = true;
		}

		#if (flixel && android)
 		return justTouched;
		#else
 		return false;
		#end
	}

	public static function androidBack():Bool
	{
		#if (flixel && android)
 		return FlxG.android.justReleased.BACK;
		#else
 		return false;
		#end
	}

	public static function crashHandler()
	{
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, function(e:UncaughtErrorEvent)
		{
			var errMsg:String = "";
			var callStack:Array<StackItem> = CallStack.exceptionStack(true);
			var dateNow:String = Date.now().toString();

			dateNow = StringTools.replace(dateNow, " ", "_");
			dateNow = StringTools.replace(dateNow, ":", "'");

			for (stackItem in callStack)
			{
				switch (stackItem)
				{
					case FilePos(s, file, line, column):
						errMsg += file + " (line " + line + ")\n";
					default:
						errMsg += stackItem;
				}
			}

			errMsg += '\nUncaught Error: ' + e.error;

			Lib.application.window.alert(errMsg, 'Crash!');
			System.exit(1);
		});
	}
}
