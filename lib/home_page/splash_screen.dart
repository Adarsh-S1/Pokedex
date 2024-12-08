import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokedex/assets/jokes.dart';
import 'package:pokedex/custom/custom_background.dart';
import 'package:pokedex/home_page/home.dart';
import 'dart:math';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  late Map<String, dynamic>? mycurrentjoke;
  @override
  void initState() {
    super.initState();
    mycurrentjoke = getRandomJsonElement(Jokes.thejokes);
    navigateToNextScreen();
  }

  void navigateToNextScreen() async {
    await Future.delayed(const Duration(seconds: 6));
    Navigator.pushReplacement(
        // ignore: use_build_context_synchronously
        context,
        MaterialPageRoute(
          builder: (context) => const Home(),
        ));
  }

  String getLocation(String loc) {
    loc = loc.toLowerCase();
    return "assets/PokemonDataset/$loc.png";
  }

  /// Returns a random JSON object from the given list.
  Map<String, dynamic>? getRandomJsonElement(
      List<Map<String, dynamic>> jsonList) {
    if (jsonList.isEmpty) return null; // Return null if the list is empty.

    final random = Random();
    final randomIndex = random.nextInt(jsonList.length); // Pick a random index.

    return jsonList[randomIndex]; // Return the JSON object at the random index.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.3,
            ),
            Center(
              child: CustomBackground(
                location: getLocation(mycurrentjoke!.keys.first),
              ),
            ),
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mycurrentjoke!.values.first,
                  style: const TextStyle(
                      fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            // SizedBox(
            //   height: MediaQuery.of(context).size.height * 0.32,
            // ),
            Lottie.asset("assets/pikachu_running.json",
                width: MediaQuery.of(context).size.width * 0.4,
                height: MediaQuery.of(context).size.height * 0.1),
          ],
        ),
      ),
    );
  }
}
