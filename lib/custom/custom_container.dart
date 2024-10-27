import 'package:flutter/material.dart';

// ignore: must_be_immutable
class CustomContainer extends StatelessWidget {
  String getLocation(String loc) {
    loc = loc.toLowerCase();
    return "assets/PokemonDataset/$loc.png";
  }

  String abilities(String ability) {
    String temp =
        ability.replaceAll('[', '').replaceAll(']', '').replaceAll('\'', '');
    List<String> parts = temp.split(',');
    return parts.length >= 2 ? "${parts[0].trim()}, ${parts[1].trim()}" : temp;
  }

  Map<String, dynamic> map;
  CustomContainer({super.key, required this.map});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Container(
        height: 180,
        width: 320,
        decoration: const BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(20)),
            color: Colors.transparent,
            shape: BoxShape.rectangle,
            border: Border(
                right: BorderSide(width: 10),
                bottom: BorderSide(width: 10),
                left: BorderSide(width: 2),
                top: BorderSide(width: 2))),
        child: Stack(
          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 25, left: 18),
                  child: Text(
                    map["name"],
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    map["type1"],
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 18),
                  child: Text(
                    abilities(map["abilities"]),
                    style: const TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
            Positioned(
              right: 2,
              bottom: 0.5,
              child: Padding(
                padding: const EdgeInsets.all(2.0),
                child: Image.asset(
                  getLocation(map["name"]),
                  height: 180,
                  width: 180,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
