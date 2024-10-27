import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomButton extends StatelessWidget {
  double width;
  double height;
  Widget child;
  Color? color;
  CustomButton({
    super.key,
    required this.width,
    required this.height,
    required this.child,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
          border: Border.all(width: 2),
          color: color ?? Colors.white,
          borderRadius: const BorderRadius.all(Radius.circular(30))),
      child: child,
    );
  }
}
