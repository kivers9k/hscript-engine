package ui;

class InputText extends FlxUIGroup { 
    public var text(get, set):String;

    public function new(x:Float, y:Float, widthField:Int, text:String, name:String = 'no name') {
        super(x, y);

        var label:FlxText = new FlxText(0, 0, widthField, name);
        label.scrollFactor.set();
        add(label);

        var textBar:FlxInputText = new FlxInputText(0, 20, widthField, text);
        textBar.scrollFactor.set();
        add(textBar);

        scrollFactor.set();
        this.name = name;
    }

    public function resize(w:Float, h:Float):Void {
        members[1].fieldWidth = w;
        members[2].width = w;
        members[2].height = h;
        members[2].calcFrame();
    }

    private function set_text(txt:String):String {
        members[2].text = txt;
        return members[2].text;
    }

    private function get_text():String return members[2].text;
}