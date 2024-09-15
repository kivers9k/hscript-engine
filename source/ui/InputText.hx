package ui;

class InputText extends FlxSpriteGroup {
    private var label:FlxText;
    private var textBar:FlxUIInputText;

    public var text(get, set):String;
    public var name(get, set):String;

    public function new(x:Float, y:Float, widthField:Int, text:String, name:String = 'no name') {
        super(x, y);

        label = new FlxText(0, 0, widthField, name);
        label.scrollFactor.set();

        textBar = new FlxUIInputText(0, 20, widthField, text);
        textBar.name = name;
        textBar.scrollFactor.set();

        scrollFactor.set();
    }

    override public function draw():Void {
        if (label != null && label.visible)
            label.draw();
        if (textBar != null && textBar.visible)
            textBar.draw();

        super.draw();
    }

    public function resize(w:Int, h:Int) {
        label.fieldWidth = w;
        textBar.resize(w, h);
    }

    private function set_text(txt:String):String {
        textBar.text = txt;
        return textBar.text;
    }

    private function set_name(txt:String):String {
        label.text = txt;
        textBar.name = txt;
        return label.text;
    }

    private function get_text():String return textBar.text;

    private function get_name():String return label.text;
}