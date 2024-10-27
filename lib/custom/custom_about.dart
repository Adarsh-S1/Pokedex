import 'package:flutter/material.dart';
import 'package:pokedex/assets/about_string.dart';
import 'package:pokedex/custom/custom_button.dart';
import 'package:pokedex/custom/custom_ui_container.dart';

// ignore: must_be_immutable
class CustomAbout extends StatelessWidget {
  Map<String, dynamic> detail;
  CustomAbout({super.key, required this.detail});
  AboutString aboutString = AboutString();

  @override
  Widget build(BuildContext context) {
    return CustomUiContainer(
      width: MediaQuery.of(context).size.width * 0.9,
      height: MediaQuery.of(context).size.width * 0.6,
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              AboutString.data[detail["name"]].toString(),
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.75,
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("Attack", style: TextStyle(fontWeight: FontWeight.bold)),
                Text("Defense    ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                Text("HP           ",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              ],
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.8,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  width: 100,
                  height: 40,
                  color: Colors.red[300],
                  child: Center(
                    child: Text(detail["attack"].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                CustomButton(
                  width: 100,
                  height: 40,
                  color: Colors.brown[200],
                  child: Center(
                    child: Text(detail["defense"].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
                CustomButton(
                  width: 100,
                  height: 40,
                  color: Colors.greenAccent,
                  child: Center(
                    child: Text(detail["hp"].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
