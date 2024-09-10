package ui;

import flixel.input.mouse.FlxMouse;

class InputText extends FlxSpriteGroup {
    public var label:FlxText;
    public var textBar:FlxUIInputText;

    public var text(default, set):String;
    public var name(default, set):String;

    public function new(x:Float, y:Float, widthField:Int, text:String, name:String = 'no name') {
        super(x, y);

        label = new FlxText(x, y, widthField, name);
        label.scrollFactor.set();
        add(label);

        textBar = new FlxUIInputText(x, y + 20, widthField, text);
        textBar.scrollFactor.set();
        add(textBar);
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        #if mobile
        var mouse:FlxMouse = (_cameras == null) ? FlxG.mouse : FlxG.mouse.getScreenPosition(_cameras);
        if (mouse.x >= textBar.x && mouse.x <= textBar.x + textBar.width && mouse.y >= textBar.y && mouse.y <= textBar.y + textBar.height) {
            FlxG.stage.window.textInputEnabled = true;
            textBar.hasFocus = true;
        } else {
            textBar.hasFocus = false;
        }
        #end
    }

    public function resize(w:Int, h:Int) {
        label.fieldWidth = w;
        textBar.resize(w, h);
    }

    private function set_text(txt:String) {
        textBar.text = txt;
        return txt;
    }

    private function set_name(txt:String) {
        label.text = txt;
        return txt;
    }
}