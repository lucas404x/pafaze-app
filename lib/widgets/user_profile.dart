import 'package:flutter/material.dart';

class UserProfile extends StatelessWidget {
  final String image;
  const UserProfile({Key? key, required this.image}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 36,
      height: 36,
      child: CircleAvatar(
        backgroundColor: Colors.grey,
        backgroundImage: AssetImage(image),
      ),
    );
  }
}
