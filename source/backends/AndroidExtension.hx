package backends;

import lime.app.Application;
import openfl.events.UncaughtErrorEvent;
import openfl.utils.Assets as OpenFlAssets;
import openfl.Lib;
import haxe.CallStack.StackItem;
import haxe.CallStack;
import haxe.io.Path;
import flash.system.System;

import flash.events.Event;
import openfl.net.FileReference;
import openfl.net.FileFilter;

class AndroidExtension {
	public static function getPath():String {
		#if android
			return '/storage/emulated/0/.' + Application.current.meta.get('file') + '/';
		#else
			return '';
		#end
 	}

	public static function permissionCheck():Void {
		if (VERSION.SDK_INT >= VERSION_CODES.TIRAMISU) {
			Permissions.requestPermissions(['READ_MEDIA_IMAGES', 'READ_MEDIA_VIDEO', 'READ_MEDIA_AUDIO']);
		} else {
			Permissions.requestPermissions(['READ_EXTERNAL_STORAGE', 'WRITE_EXTERNAL_STORAGE']);
		}
		
		if (!Environment.isExternalStorageManager()) {
			if (VERSION.SDK_INT >= VERSION_CODES.S) {
				Settings.requestSetting('REQUEST_MANAGE_MEDIA');
			}
			Settings.requestSetting('MANAGE_APP_ALL_FILES_ACCESS_PERMISSION');
		}

		if ((VERSION.SDK_INT >= VERSION_CODES.TIRAMISU && !Permissions.getGrantedPermissions().contains('android.permission.READ_MEDIA_IMAGES')) ||
		(VERSION.SDK_INT < VERSION_CODES.TIRAMISU && !Permissions.getGrantedPermissions().contains('android.permission.READ_EXTERNAL_STORAGE'))) {
			alert('Permission check!', "Make sure you accepted the permission\n If denied you unable to play");
		}

		if (!FileSystem.exists(getPath())) {
			FileSystem.createDirectory(getPath());
		} else {
			if (!FileSystem.exists(getPath() + 'assets')) {
				alert('Assets not found!', 'Please copy assets from apk and paste it on\n' + getPath());
			}
			var folder:Array<String> = ['crash', 'saves'];
			for (fold in folder) {
				if (!FileSystem.exists(getPath() + fold)) {
					FileSystem.createDirectory(getPath() + fold);
				}
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

    //just a test
    var _file:FileReference;
	public var fileName:String;

	public function browse():Void {
		_file = new FileReference();
		_file.addEventListener(Event.SELECT, onSelect, false, 0, true);
		var ff:FileFilter:Array<FileFilter> = [
			new FileFilter('image file', '*.png'),
			new FileFilter('json file', '*.json')
		];
		_file.browse(ff);
	}

	function onSelect(E:Event):Void {
		_file = cast(E.target, FileReference);
        fileName = _file.name;

		_file.load();
	}
} 
