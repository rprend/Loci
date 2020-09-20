import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:loci/src/components/buttons.dart';
import 'package:loci/src/pages/camera.dart';
import 'package:loci/src/pages/joinroom.dart';
import 'package:tcard/tcard.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final List<Widget> pages = [
    IntroCard(),
    CameraPage(),
    JoinRoomPage(),
  ];

  final List<String> titles = [
    'Welcome to Loci',
    'Create a map',
    'Join a room',
  ];

  int index = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.sort),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: Icon(
              Icons.expand_more,
              size: 40,
            ),
          )
        ],
        backgroundColor: Colors.purple,
        elevation: 0,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.purple, Colors.deepPurple],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(bottom: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 20,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: AnimatedSwitcher(
                    child: Text(titles[index],
                        key: ValueKey(index),
                        style: TextStyle(
                            fontSize: 40,
                            fontWeight: FontWeight.w400,
                            color: Colors.white)),
                    duration: Duration(milliseconds: 100),
                  ),
                ),
                Expanded(
                  child: Swiper(
                    onIndexChanged: (index) {
                      setState(() {
                        this.index = index;
                      });
                    },
                    itemBuilder: (BuildContext context, int index) {
                      return pages[index];
                    },
                    itemCount: 3,
                    itemWidth: MediaQuery.of(context).size.width - 30,
                    layout: SwiperLayout.STACK,
                    scrollDirection: Axis.horizontal,
                    pagination:
                        SwiperPagination(builder: SwiperPagination.dots),
                  ),
                ),
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
                fit: BoxFit.cover,
                image: AssetImage('assets/images/town.jpg'))),
        child: Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            backgroundColor: Colors.deepPurple,
            child: Icon(Icons.keyboard_arrow_right),
          ),
        ));
  }
}
