import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

// hscript-ex
import hscript.InterpEx;
import hscript.ParserEx;

import backend.AndroidExtension as SUtil;
import backend.AssetPaths as Paths;
import object.AnimateSprite;
import object.SpriteGroup;
import object.Tile;
import script.HScript;
import state.FlxCustomState;
import state.FlxCustomSubState;
import state.GameState;
import state.GameSubState;
import ui.FlxVirtualPad;
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
import flixel.text.FlxText;

// addons
import flixel.addons.display.FlxRuntimeShader;
import flixel.addons.display.FlxGridOverlay;
import flixel.addons.display.FlxPieDial;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUI;

using StringTools;