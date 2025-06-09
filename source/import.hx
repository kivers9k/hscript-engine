import hscript.Interp;
import hscript.Parser;
import hscript.Expr;

import hxcodec.flixel.FlxVideo;
import hxcodec.flixel.FlxVideoBackdrop;
import hxcodec.flixel.FlxVideoSprite;

import object.AnimateSprite;
import object.SpriteGroup;
import object.Tile;
import script.HScript;
import script.scripted.ScriptedSprite;
import script.scripted.ScriptedSpriteGroup;
import state.FlxCustomState;
import state.FlxCustomState.GameState;
import state.FlxCustomSubState;
import state.FlxCustomSubState.GameSubState;
import ui.FlxVirtualPad;
import ui.InputText;
import ui.PieDial;
import util.ColorUtil;
import util.SUtil;
import util.Paths;
import util.Paths.Files;

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
import flixel.addons.ui.FlxInputText;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUICheckBox;
import flixel.addons.ui.FlxUIInputText;
import flixel.addons.ui.FlxUINumericStepper;
import flixel.addons.ui.FlxUITabMenu;
import flixel.addons.ui.FlxUIText;
import flixel.addons.ui.FlxUI;

using StringTools;