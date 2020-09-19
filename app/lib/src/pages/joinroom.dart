import 'package:flutter/material.dart';
import 'package:loci/src/components/buttons.dart';

class JoinRoomPage extends StatelessWidget {
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
            SizedBox(
              height: 30,
            ),
            Text(
              'Join a map',
              style: TextStyle(fontSize: 40, color: Colors.white),
            ),
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0),
                    color: Colors.white),
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
            ),
            LoginButton(
              text: 'Join',
              onPressed: () {},
            ),
          ],
        ));
  }
}
