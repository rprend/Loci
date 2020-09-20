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
            Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: InputWidget(
                onPressed: () {},
                icon: Icons.search,
              ),
            ),
          ],
        ));
  }
}
