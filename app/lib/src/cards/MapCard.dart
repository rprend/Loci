import 'package:flutter/material.dart';
import 'package:loci/src/components/buttons.dart';
import 'package:loci/src/pages/map.dart';

class MapCard extends StatelessWidget {
  final String imagePath;
  final String mapPath;
  final List<BuildingSprite> buildings;

  MapCard({this.imagePath, this.mapPath, this.buildings});

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(imagePath))),
        child: Column(
          children: [
            Spacer(flex: 2),
            Padding(
                padding: const EdgeInsets.all(16.0),
                child: LoginButton(
                  text: 'Join map',
                  onPressed: () {
                    Navigator.of(context).pushNamed('/map',
                        arguments: MapArguments(
                            editable: false,
                            sprites: buildings,
                            assetBg: mapPath));
                  },
                )),
          ],
        ));
  }
}
