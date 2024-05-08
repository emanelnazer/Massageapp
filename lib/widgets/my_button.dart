import 'package:flutter/material.dart';

class MyButton extends StatelessWidget{
  MyButton({required this.color, required this.text, required this.onpress});
  final Color color;
  final String text;
  final VoidCallback onpress;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Material(
        elevation: 5,
        color: color,
        borderRadius: BorderRadius.circular(10),
        child: MaterialButton(
          onPressed:onpress,
          minWidth: 200,
          height: 40,
          child:Text(text),
        ),
      ),
    );
  }

}