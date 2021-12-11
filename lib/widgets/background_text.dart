import 'package:flutter/material.dart';

class BackgroundText extends StatelessWidget {
  final String text;
  const BackgroundText({Key? key, required this.text}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: 0.3,
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold),
      ),
    );
  }
}
