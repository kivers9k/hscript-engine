package object;

import haxe.Json;

typedef TileJson = {
    playerPosition:{x:Float, y:Float},
    map:{width:Int, height:Int},
    tiles:Array<{x:Float, y:Float, image:String}>
}

class Tile extends FlxSpriteGroup {
    public var tileData:TileJson;
    public function new(x:Float, y:Float, tilePath:String) {
        super(x, y);

        tileData = Json.parse(Paths.getContent('data/tiles/$tilePath.json'));
        for (tileArray in tileData.tiles) {
            var tileSpr:FlxSprite = new FlxSprite(tileArray.x, tileArray.y, Paths.image(tileArray.image));
            tileSpr.immovable = true;
            add(tileSpr);
        }
    }
}