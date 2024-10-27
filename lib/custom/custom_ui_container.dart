import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomUiContainer extends StatelessWidget {
  CustomUiContainer(
      {super.key,
      required this.child,
      required this.width,
      required this.height});
  Widget child;
  double width;
  double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(20)),
          color: Color.fromARGB(255, 255, 255, 255),
          shape: BoxShape.rectangle,
          border: Border(
              right: BorderSide(width: 10),
              bottom: BorderSide(width: 10),
              left: BorderSide(width: 2),
              top: BorderSide(width: 2))),
      child: child,
    );
  }
}
