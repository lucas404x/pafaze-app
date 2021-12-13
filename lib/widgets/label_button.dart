import 'package:flutter/material.dart';

class LabelButton extends StatelessWidget {
  final Function onTap;
  final Color backgroudColor;
  final Color textColor;
  final String text;
  const LabelButton(
      {Key? key,
      required this.onTap,
      required this.backgroudColor,
      required this.textColor,
      required this.text})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        child: GestureDetector(
          onTap: () => onTap(),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  color: backgroudColor,
                ),
                child: Text(
                  text,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 10, color: textColor),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
