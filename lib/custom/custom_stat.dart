import 'package:flutter/material.dart';
import 'package:pokedex/custom/custom_ui_container.dart';
import 'package:percent_indicator/percent_indicator.dart';

// ignore: must_be_immutable
class CustomStat extends StatelessWidget {
  Map<String, dynamic> detail;
  CustomStat({super.key, required this.detail});

  double stringToNormalizedDouble(String input) {
    int hash = input.hashCode.abs();
    return (hash % 100) / 10;
  }

  TextStyle style = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    return CustomUiContainer(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.width * 0.7,
        child: Padding(
            padding: EdgeInsets.all(15.0),
            child: Row(children: [
              Column(
                children: [
                  Text("weight kg", style: style),
                  Text("against bug", style: style),
                  Text("against dark", style: style),
                  Text("against dragon", style: style),
                  Text("against electric", style: style),
                  Text("against fairy", style: style),
                  Text("against fight", style: style),
                  Text("against fire", style: style),
                  Text("against flying", style: style),
                ],
              ),
            ])));
  }
}
