package objects;

import haxe.Json;
  
class Tile extends FlxSpriteGroup {
    var tileJson;
    public function new(x:Float, y:Float, tilePath:String) {
        super(x, y);

        tileJson = Json.parse(Paths.getpath('data/tiles/$tilePath.json'));
        for (tileArray in tileJson.tiles) {
            var tileSpr:FlxSprite = new FlxSprite(tileArray.x, tilearray.y, Paths.image(tileArray.image));
            tileSpr.immovable = true;
            add(tileSpr);
        }
    }
}

// i don't know lol