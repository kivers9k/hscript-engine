package ui;

class InputText extends FlxUIGroup {
    public var label:FlxText;
    public var textBar:FlxInputText;

    public var text(get, set):String;

    public function new(x:Float, y:Float, widthField:Int, text:String, name:String = 'no name') {
        super(x, y);

        label = new FlxText(0, 0, widthField, name);
        label.scrollFactor.set();
        add(label);

        textBar = new FlxInputText(0, 20, widthField, text);
        textBar.scrollFactor.set();
        add(textBar);

        scrollFactor.set();
        this.name = name;
    }

    public function resize(w:Float, h:Float):Void {
        label.fieldWidth = w;
        textBar.width = w;
        textBar.height = h;
        textBar.calcFrame();
    }

    private function set_text(txt:String):String {
        textBar.text = txt;
        return textBar.text;
    }

    private function get_text():String return textBar.text;
}