import 'dart:async';

import 'package:flutter/material.dart';

class ButtonNotClickMulti extends StatefulWidget {
  final HitTestBehavior? behavior;
  final Function() onTap;
  final Widget child;
  const ButtonNotClickMulti(
      {super.key, this.behavior, required this.onTap, required this.child});

  @override
  State<ButtonNotClickMulti> createState() => _ButtonNotClickMultiState();
}

class _ButtonNotClickMultiState extends State<ButtonNotClickMulti> {
  bool isClick = false;

  void addTimer() {
    Future.delayed(const Duration(seconds: 1), () {
      isClick = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (!isClick) {
          widget.onTap();
          isClick = true;
          addTimer();
        }
      },
      behavior: widget.behavior ?? HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}
