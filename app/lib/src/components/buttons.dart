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
        color: Colors.black87,
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
