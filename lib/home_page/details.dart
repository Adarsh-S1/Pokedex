import 'package:flutter/material.dart';
import 'package:pokedex/custom/custom_about.dart';
import 'package:pokedex/custom/custom_background.dart';
import 'package:pokedex/custom/custom_button.dart';
import 'package:pokedex/custom/custom_stat.dart';
import 'package:pokedex/functions/cvs_handling.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class Details extends StatefulWidget {
  Map<String, dynamic> map;
  Details({super.key, required this.map});

  @override
  State<Details> createState() => _DetailsState();
}

class _DetailsState extends State<Details> {
  String getLocation(String loc) {
    loc = loc.toLowerCase();
    return "assets/PokemonDataset/$loc.png";
  }

  CvsHandling myCsv = CvsHandling();
  late List catalogdata;
  Map<String, dynamic> detail = {};
  String selected = "About";

  Widget detailpage() {
    if (selected == "About") {
      return CustomAbout(
        detail: widget.map,
      );
    } else {
      return CustomStat(detail: widget.map);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.arrow_back)),
        title: Text(widget.map["name"]),
        actions: [
          IconButton(
              onPressed: () async {
                // SharedPreferences prefs = await SharedPreferences.getInstance();
                // prefs.setInt("countofcapturedpokemon", 1);
                // prefs.setStringList("listofnotcapturedpokemon", ["pikachu"]);
              },
              icon: const Icon(
                Icons.favorite,
                size: 40,
              ))
        ],
      ),
      body: Column(
        children: [
          Center(
            child: CustomBackground(location: getLocation(widget.map["name"])),
          ),
          const SizedBox(
            height: 40,
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
      ),
    );
  }
}
