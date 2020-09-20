import 'dart:convert';
import 'dart:io';
import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loci/src/components/buttons.dart';
import 'package:loci/src/pages/map.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage(BuildContext context) async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
    upload(_image, context);
  }

  void upload(File imageFile, BuildContext context) async {
    var dio = Dio();
    FormData formData = new FormData.fromMap({
      "img": await MultipartFile.fromFile(imageFile.path,
          filename: imageFile.path),
    });
    try {
      var response =
          await dio.post("http://192.168.1.148:5000/scan", data: formData);
      var data = response.data;
      // '[{"id": 1, "location": [1569, 4158], "capacity": 0}, {"id": 2, "location": [1558, 4156], "capacity": 0}, {"id": 3, "location": [1574, 4152], "capacity": 0}, {"id": 7, "location": [1700, 4146], "capacity": 0}, {"id": 8, "location": [1564, 4150], "capacity": 0}, {"id": 11, "location": [1566, 4144], "capacity": 0}, {"id": 12, "location": [1713, 4142], "capacity": 0}, {"id": 13, "location": [1707, 4143], "capacity": 0}, {"id": 15, "location": [1703, 4142], "capacity": 0}, {"id": 16, "location": [1678, 4142], "capacity": 0}, {"id": 18, "location": [1692, 4140], "capacity": 0}, {"id": 20, "location": [1574, 4143], "capacity": 0}, {"id": 21, "location": [1570, 4140], "capacity": 0}, {"id": 24, "location": [1645, 4138], "capacity": 0}, {"id": 25, "location": [1554, 4143], "capacity": 0}, {"id": 26, "location": [1544, 4139], "capacity": 0}, {"id": 27, "location": [1562, 4138], "capacity": 0}, {"id": 28, "location": [1518, 4138], "capacity": 0}, {"id": 29, "location": [1557, 4136], "capacity": 0}]';
      List<BuildingSprite> sprites = [];
      var tagsJson = jsonDecode(data);
      for (var json in tagsJson) {
        if (json['capacity'] != 0) {
          sprites.add(BuildingSprite.fromJson(json));
        }
      }

      Navigator.of(context).pushNamed('/map',
          arguments: MapArguments(
              editable: true,
              assetBg: 'assets/maps/siebel.png',
              sprites: sprites));
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.all(16),
        margin: EdgeInsets.all(16),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/createImage.jpg'))),
        child: Column(
          children: [
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputWidget(
                icon: Icons.add_a_photo,
                onPressed: () {
                  getImage(context);
                },
              ),
            ),
          ],
        ));
  }
}
