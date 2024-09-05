package;

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import flash.system.System;

class AndroidExtension {
	public static function getPath():String {
		#if android
		    return '/storage/emulated/0/.' + Application.current.meta.get('file') + '/';
		#else
		    return '';
		#end
 	}

    public static function permissionCheck():Void {
	    if (!Permissions.getGrantedPermissions().contains('android.permission.READ_EXTERNAL_STORAGE') && !Permissions.getGrantedPermissions().contains('android.permission.WRITE_EXTERNAL_STORAGE')) {
		    SUtil.alert('Permission Checks!', 'Please accept the permission and\nenable "Allow access to manage all files"');
			Permissions.requestPermission('READ_EXTERNAL_STORAGE');
			Permissions.requestPermission('WRITE_EXTERNAL_STORAGE');
			if (!Environment.isExternalStorageManager())
				Settings.requestSetting('MANAGE_APP_ALL_FILES_ACCESS_PERMISSION');
	    } else {
			if (!FileSystem.exists(getPath())) {
				FileSystem.createDirectory(getPath());
				alert('No Assets folder Found!', 'please copy assets folder from apk and paste it in ' + getPath());
			}
	    }
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

		alert("Uncaught Error", errMsg, 'close', function() {
			System.exit(0);
		});
	}

	public static function alert(title:String, msg:String, ?buttonName:String = 'ok', ?func:() -> Void) {
		Tools.showAlertDialog(title, msg,
		    {name: buttonName.toUpperCase(), func: func},
			null
		);
	}
} 
