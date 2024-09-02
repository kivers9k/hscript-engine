package;

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import flash.system.System;

using StringTools;

class AndroidExtension {
	#if android
	private static var aDir:String = null; // android dir
	#end
	public static function getPath():String {
		#if android
		if (aDir != null && aDir.length > 0) {
    	    return aDir;
		} else {
		    return aDir = Context.getExternalFilesDir() + '/' + '.' + Application.current.meta.get('file') + '/';
		}
		#else
		return '';
		#end
	}

	public static function gameCrashCheck() {
		Lib.current.loaderInfo.uncaughtErrorEvents.addEventListener(UncaughtErrorEvent.UNCAUGHT_ERROR, onCrash);
	}

	public static function onCrash(e:UncaughtErrorEvent):Void {
		var callStack:Array<StackItem> = CallStack.exceptionStack(true);
		var dateNow:String = Date.now().toString();
		dateNow = StringTools.replace(dateNow, " ", "_");
		dateNow = StringTools.replace(dateNow, ":", "'");

		var path:String = "crash/" + "crash_" + dateNow + ".txt";
		var errMsg:String = "";

		for (stackItem in callStack)
		{
			switch (stackItem)
			{
				case FilePos(s, file, line, column):
					errMsg += file + " (line " + line + ")\n";
				default:
					Sys.println(stackItem);
			}
		}

		errMsg += e.error;

		if (!FileSystem.exists(getPath() + "crash"))
		FileSystem.createDirectory(getPath() + "crash");

		File.saveContent(getPath() + path, errMsg + "\n");

		Sys.println(errMsg);
		Sys.println("Crash dump saved in " + Path.normalize(path));
		Sys.println("Making a simple alert ...");

		alert("Uncaught Error", errMsg);
		System.exit(0);
	}

	public static function alert(title:String, msg:String) {
		Application.current.window.alert(msg, title);
	}
} 
