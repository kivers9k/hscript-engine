package ui;

class InputText extends FlxSpriteGroup {
    public var label:FlxText;
    public var textBar:FlxUIInputText;

    public var text(default, set):String;
    public var name(default, set):String;

    public function new(x:Float, y:Float, widthField:Int, text:String, name:String = 'no name') {
        super(x, y);

        label = new FlxText(0, 0, widthField, name);
        label.scrollFactor.set();
        add(label);

        textBar = new FlxUIInputText(0, 20, widthField, text);
        textBar.scrollFactor.set();
        add(textBar);

        scrollFactor.set();
        this.text = text;
        this.name = name;
    }

    override function update(elapsed:Float) {
        super.update(elapsed);
        textBar.focusGained = () -> FlxG.stage.window.textInputEnabled = true;
    }

    public function resize(w:Int, h:Int) {
        label.fieldWidth = w;
        textBar.resize(w, h);
    }

    private function set_text(txt:String):String {
        textBar.text = txt;
        return txt;
    }

    private function set_name(txt:String):String {
        label.text = txt;
        return txt;
    }
}