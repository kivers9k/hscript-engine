import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

import rulescript.RuleScript;
import rulescript.parsers.HxParser;
import rulescript.scriptedClass.RuleScriptedClass;
import rulescript.scriptedClass.RuleScriptedClassUtil;

import hxcodec.flixel.FlxVideo;
import hxcodec.flixel.FlxVideoBackdrop;
import hxcodec.flixel.FlxVideoSprite;

import script.HScript;
import script.scriptedClass.ScriptedSprite;
import script.scriptedClass.ScriptedSpriteGroup;
import script.scriptedClass.ScriptedState;
import script.scriptedClass.ScriptedSubState;

import object.AnimateSprite;
import object.SpriteGroup;
import object.Tile;
import state.FlxCustomState;
import state.FlxCustomState.GameState;
import state.FlxCustomSubState;
import state.FlxCustomSubState.GameSubState;
import ui.FlxVirtualPad;
import ui.FlxJoystick;
import ui.InputText;
import ui.PieDial;
import backend.ColorUtil;
import backend.SUtil;
import backend.Paths;
import backend.Paths.Files;

#if sys
import sys.*;
import sys.io.*;
#elseif js
import js.html.*;
#end

import flash.geom.Rectangle;
import flash.geom.Matrix;
import flash.geom.Point;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxCamera;
import flixel.FlxState;
import flixel.FlxSubState;
import flixel.util.FlxTimer;
import flixel.util.FlxDestroyUtil;
import flixel.math.FlxMath;
import flixel.math.FlxPoint;
import flixel.math.FlxPoint.FlxBasePoint;
import flixel.math.FlxRect;
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
import flixel.addons.effects.FlxTrail;
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUI;
import flixel.addons.util.PNGEncoder;

using StringTools;
