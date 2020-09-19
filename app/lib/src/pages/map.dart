import 'package:flame/components/component.dart';
import 'package:flame/components/mixins/tapable.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/material.dart';
import 'package:flame/game.dart';
import 'package:flame_tiled/flame_tiled.dart';
import 'package:flutter/rendering.dart';

class MapPage extends StatefulWidget {
  @override
  _MapPageState createState() => _MapPageState();
}

class _MapPageState extends State<MapPage> {
  BaseGame game;

  @override
  void initState() {
    super.initState();
    game = MyGame();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('hello'),
        ),
        body: InteractiveViewer(child: game.widget));
  }
}

class BuildingSprite extends SpriteComponent with Tapable {
  // creates a component that renders the crate.png sprite, with size 16 x 16
  BuildingSprite() : super.fromSprite(64.0, 64.0, new Sprite('building.png'));

  @override
  void resize(Size size) {
    // we don't need to set the x and y in the constructor, we can set then here
    this.x = (size.width - this.width) / 2;
    this.y = (size.height - this.height) / 2;
  }

  @override
  void onTapDown(TapDownDetails details) {
    // TODO: tap up instead of tap down
    toggleInfoSheet();
    print(
        'Component tap down on ${details.globalPosition.dx}  ${details.globalPosition.dy}');
  }

  void toggleInfoSheet() {}
}

class MyGame extends BaseGame with HasTapableComponents {
  MyGame() {
    TiledComponent tiledMap = TiledComponent('IsoMap.tmx', Size(30.0, 30.0));
    add(tiledMap);
    add(BuildingSprite());
  }
}
