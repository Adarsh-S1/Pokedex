import 'package:flutter/material.dart';
import 'package:pokedex/custom/custom_about.dart';
import 'package:pokedex/custom/custom_background.dart';
import 'package:pokedex/custom/custom_button.dart';
import 'package:pokedex/custom/custom_stat.dart';
import 'package:pokedex/functions/cvs_handling.dart';

// ignore: must_be_immutable
class CustomDetailpage extends StatefulWidget {
  String pokemon;
  CustomDetailpage({super.key, required this.pokemon});

  @override
  State<CustomDetailpage> createState() => _CustomDetailpageState();
}

class _CustomDetailpageState extends State<CustomDetailpage> {
  CvsHandling myCsv = CvsHandling();
  late List catalogdata;
  Map<String, dynamic> detail = {};
  @override
  void initState() {
    super.initState();
    getrow();
    // readJson();
  }

  String selected = "About";

  final myColor = {
    "normal": const Color(0xFFBDBDBD), // Light Gray
    "fire": const Color(0xFFFF6B6B), // Bright Red
    "water": const Color(0xFF4DB8FF), // Light Blue
    "electric": const Color(0xFFFFE600), // Vivid Yellow
    "grass": const Color(0xFF48D0B0), // Teal Green
    "ice": const Color(0xFF76EEC6), // Mint Green
    "fighting": const Color(0xFFCC0000), // Deep Red
    "poison": const Color(0xFF9F4DB5), // Purple
    "ground": const Color(0xFFD6A55D), // Sandy Brown
    "flying": const Color(0xFFA890F0), // Soft Purple
    "psychic": const Color(0xFFFF4081), // Hot Pink
    "bug": const Color(0xFF9FB839), // Olive Green
    "rock": const Color(0xFFC6A563), // Earthy Tan
    "ghost": const Color(0xFF705898), // Indigo
    "dragon": const Color(0xFF7038F8), // Deep Purple
    "dark": const Color(0xFF4F3A39), // Dark Brown
    "steel": const Color(0xFFB8B8D0), // Steel Gray
    "fairy": const Color(0xFFFFB6C1) // Light Pink
  };

  // Future<void> readJson() async {
  //   final String response =
  //       await rootBundle.loadString('lib/assets/pokemon.json');
  //   catalogdata = await json.decode(response);
  // }

  Future<Map<String, dynamic>> getrow() async {
    final det = await myCsv.getRow(widget.pokemon);
    setState(() {
      detail = det;
    });

    return detail;
  }

  String getLocation(String loc) {
    loc = loc.toLowerCase();
    return "assets/PokemonDataset/$loc.png";
  }

  Widget detailpage() {
    if (selected == "About") {
      return CustomAbout(
        detail: detail,
      );
    } else {
      return CustomStat(detail: detail);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CustomBackground(location: getLocation(widget.pokemon)),
        Text(
          widget.pokemon,
          style: const TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: CustomButton(
            color: myColor[detail["type1"]],
            width: 100,
            height: 40,
            child: Center(
                child: Text(
              detail["type1"],
              style: const TextStyle(fontWeight: FontWeight.bold),
            )),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = "About";
                });
              },
              child: CustomButton(
                width: 100,
                height: 40,
                child: const Center(
                    child: Text(
                  "About",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  selected = "Stat";
                });
              },
              child: CustomButton(
                width: 100,
                height: 40,
                child: const Center(
                    child: Text(
                  "Stat",
                  style: TextStyle(fontWeight: FontWeight.bold),
                )),
              ),
            ),
          ],
        ),
        detailpage()
      ],
    );
  }
}
