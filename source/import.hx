#if android
import android.content.Context;
import android.os.Build.VERSION;
import android.os.Build.VERSION_CODES;
import android.os.Environment;
import android.os.BatteryManager;
import android.widget.Toast;
import android.Tools;
import android.Permissions;
import android.Settings;
#end

import backends.AndroidExtension as SUtil;
import backends.AssetPaths as Paths;
import backends.FlxCustomState;
import backends.FlxCustomSubState;
import hscript.HScript;
import objects.Tile;
import states.PlayState;
import ui.InputText;

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.util.FlxColor;
import flixel.util.FlxTimer;
import flixel.util.FlxDestroyUtil;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.tweens.FlxEase;
import flixel.tweens.FlxTween;
import flixel.group.FlxSpriteGroup;
import flixel.group.FlxGroup.FlxTypedGroup;
import flixel.ui.FlxButton;
import flixel.ui.FlxSpriteButton;
import flixel.ui.FlxAnalog;
import flixel.ui.FlxVirtualPad;
import flixel.text.FlxText;

// ui stuff
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUI;

using StringTools;