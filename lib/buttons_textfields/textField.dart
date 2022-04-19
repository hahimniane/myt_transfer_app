import 'package:flutter/material.dart';

class myTextField extends StatelessWidget {
  String label;
  Color colour;
  var controller = TextEditingController();
  Icon prefixIcon;
  bool obscure = false;
  TextInputType textInputType = TextInputType.text;

  myTextField({
    required this.label,
    required this.colour,
    required this.controller,
    required this.prefixIcon,
    required this.obscure,
    required this.textInputType,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 20.0, left: 10),
          child: Text(
            label,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: colour,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
              keyboardType: textInputType,
              obscureText: obscure,
              controller: controller,
              decoration: InputDecoration(
                  prefixIcon: prefixIcon,
                  enabledBorder: OutlineInputBorder(
                    borderSide: const BorderSide(
                      color: Colors.blueAccent,
                    ),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  hintText: label,
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.w300, fontSize: 20))),
        ),
      ],
    );
  }
}
