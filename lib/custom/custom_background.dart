import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomBackground extends StatelessWidget {
  String location;
  CustomBackground({super.key, required this.location});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 300,
      height: 300,
      child: Stack(
        children: [
          Image.asset(
            color: const Color.fromARGB(199, 113, 113, 113),
            "assets/pokeball_background.png",
            fit: BoxFit.fill,
          ),
          Positioned(
              top: 10,
              left: 10,
              child: Image.asset(
                location,
                width: 300,
                height: 300,
              ))
        ],
      ),
    );
  }
}
