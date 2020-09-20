import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final String text;
  final Function onPressed;
  const LoginButton({Key key, this.text, this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: MaterialButton(
        padding:
            EdgeInsets.only(left: 32.0, top: 8.0, bottom: 8.0, right: 16.0),
        onPressed: onPressed,
        color: Colors.deepPurple[800],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Text(this.text,
                  style: TextStyle(fontSize: 20, color: Colors.white)),
              Spacer(),
              Icon(Icons.keyboard_arrow_right, color: Colors.white)
            ],
          ),
        ),
      ),
    );
  }
}

class InputWidget extends StatelessWidget {
  final Function onPressed;
  final IconData icon;
  const InputWidget({Key key, this.onPressed, this.icon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0), color: Colors.white),
        child: Row(children: [
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                focusColor: Colors.black,
                hintText: 'Map name',
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding:
                    EdgeInsets.only(left: 15, bottom: 11, top: 11, right: 15),
              ),
            ),
          ),
          FloatingActionButton(
              onPressed: onPressed,
              child: Icon(icon),
              elevation: 0,
              backgroundColor: Colors.deepPurple)
        ]));
  }
}
