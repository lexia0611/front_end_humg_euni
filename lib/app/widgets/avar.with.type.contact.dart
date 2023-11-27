import 'package:flutter/material.dart';

class AvarNormal extends StatelessWidget {
  final String? avar;
  final bool isCircle;
  const AvarNormal({super.key, required this.avar, this.isCircle = true});

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
      borderRadius: isCircle ? null : BorderRadius.circular(10),
      shape: isCircle ? BoxShape.circle : BoxShape.rectangle,
      image: const DecorationImage(
        fit: BoxFit.cover,
        image: AssetImage("assets/noavatar.png"),
      ),
    ));
  }
}
