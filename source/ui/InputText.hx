package ui;

class InputText extends FlxUIGroup { 
    private var label:FlxText;
    private var inputText:FlxInputText;
    
    public var text(get, set):String;

    public function new(x:Float, y:Float, widthField:Int, text:String, name:String = 'no name') {
        super(x, y);

        scrollFactor.set();
        this.name = name;

        label = new FlxText(0, 0, widthField, name);
        label.scrollFactor.set();
        add(label);

        inputText = new FlxInputText(0, 20, widthField, text);
        inputText.scrollFactor.set();
        add(inputText);
    }

    public function resize(w:Float, h:Float):Void {
        label.fieldWidth = w;
        inputText.width = w;
        inputText.height = h;
        inputText.calcFrame();
    }

    private function set_text(txt:String):String {
        inputText.text = txt;
        return inputText.text;
    }

    private function get_text():String {
        return inputText.text;
    }
}