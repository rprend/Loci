import 'package:flutter/material.dart';
import 'package:loci/src/components/buttons.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/town.jpg'))),
        child: Column(
          children: [
            Spacer(
              flex: 1,
            ),
            Text(
              'LOCI',
              style: TextStyle(fontSize: 80, fontWeight: FontWeight.w200),
            ),
            Spacer(flex: 4),
            LoginButton(
              text: "New locus",
              onPressed: () {
                Navigator.of(context).pushNamed('/camera');
              },
            ),
            LoginButton(
              text: "Join a room",
              onPressed: () {
                Navigator.of(context).pushNamed('/joinroom');
              },
            )
          ],
        ),
      ),
    );
  }
}
