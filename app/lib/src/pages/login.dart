import 'package:flutter/material.dart';
import 'package:loci/src/components/buttons.dart';
import 'package:loci/src/pages/camera.dart';
import 'package:loci/src/pages/joinroom.dart';
import 'package:tcard/tcard.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              children: [
                Expanded(
                  child: PageView(
                      controller:
                          PageController(initialPage: 1, viewportFraction: .8),
                      children: [JoinRoomPage(), IntroCard(), CameraPage()]),
                ),
                Row(
                  children: [
                    Spacer(),
                    SizedBox(
                      width: 10,
                    ),
                    Icon(Icons.keyboard_arrow_left),
                    Text('Join',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300)),
                    SizedBox(
                      width: 30,
                    ),
                    Spacer(
                      flex: 2,
                    ),
                    Text('Create',
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.w300)),
                    Icon(Icons.keyboard_arrow_right),
                    Spacer(),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class IntroCard extends StatelessWidget {
  const IntroCard({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16),
      margin: EdgeInsets.all(16),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30),
          image: DecorationImage(
              fit: BoxFit.cover, image: AssetImage('assets/images/town.jpg'))),
      child: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Text('LOCI',
              style: TextStyle(
                  fontSize: 40,
                  fontWeight: FontWeight.w400,
                  color: Colors.white)),
        ],
      ),
    );
  }
}
