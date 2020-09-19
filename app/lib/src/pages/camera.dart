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
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Color(0x44000000),
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios),
            color: Colors.black,
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ),
        // body: Center(
        //   child: _image == null ? Text('No image selected.') : Image.file(_image),
        // ),
        body: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/town.jpg'))),
            child: Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Text(
                  'Create your map',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w200),
                ),
                Spacer(flex: 2),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: TextField(
                    decoration: InputDecoration(
                        border: new OutlineInputBorder(
                          borderRadius: const BorderRadius.all(
                            const Radius.circular(10.0),
                          ),
                        ),
                        focusColor: Colors.black,
                        hintText: 'Map name'),
                  ),
                ),
                Spacer(flex: 4),
                LoginButton(
                  text: 'Take picture',
                  onPressed: getImage,
                ),
                SizedBox(
                  height: 40,
                )
              ],
            )));
  }
}
