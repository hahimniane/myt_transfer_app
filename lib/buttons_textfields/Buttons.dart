import 'package:flutter/material.dart';

class Button extends StatelessWidget {
  String label;
  Color colour;
  final VoidCallback? onPressed;
  Button(
      {Key? key,
      required this.label,
      required this.onPressed,
      required this.colour})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        width: 300,
        height: 60,
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            label,
            style: const TextStyle(fontSize: 25, color: Colors.white),
          ),
          style: ElevatedButton.styleFrom(
            primary: colour,
            onPrimary: Colors.white,
            shape: const BeveledRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(15))),
          ),
        ),
      ),
    );
  }
}
