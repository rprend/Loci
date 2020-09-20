import 'dart:io';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loci/src/components/buttons.dart';

class CameraPage extends StatefulWidget {
  @override
  _CameraPageState createState() => _CameraPageState();
}

class _CameraPageState extends State<CameraPage> {
  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.camera);

    setState(() {
      _image = File(pickedFile.path);
    });
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
                image: AssetImage('assets/images/town.jpg'))),
        child: Column(
          children: [
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputWidget(
                icon: Icons.add_a_photo,
                onPressed: () {},
              ),
            ),
          ],
        ));
  }
}
