import 'package:loci/src/pages/camera.dart';
import 'package:loci/src/pages/edit.dart';
import 'package:loci/src/pages/joinroom.dart';
import 'package:loci/src/pages/login.dart';
import 'package:loci/src/pages/map.dart';
import 'package:flutter/material.dart';

import './src/pages/index.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: '/map',
        routes: {
          '/': (context) => LoginPage(),
          '/joinroom': (context) => JoinRoomPage(),
          '/camera': (context) => CameraPage(),
          '/index': (context) => IndexPage(),
          '/map': (context) => MapPage(),
          '/edit': (context) => EditPage(),
        });
  }
}