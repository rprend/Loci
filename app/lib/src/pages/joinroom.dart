import 'package:flutter/material.dart';
import 'package:loci/src/components/buttons.dart';

class JoinRoomPage extends StatelessWidget {
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
                'Room Name',
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
                      hintText: 'Enter the room code'),
                ),
              ),
              Spacer(flex: 4),
              LoginButton(
                text: 'Join room',
                onPressed: () {},
              ),
              SizedBox(
                height: 40,
              )
            ],
          ),
        ));
  }
}
