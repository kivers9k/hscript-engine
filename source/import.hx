#if android
import android.Tools;
import android.Permissions;
import android.Settings;
import android.content.Context;
import AndroidExtension as SUtil;
#end

import AssetPaths as Paths;
import HScript;

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

using StringTools;