import 'package:flutter/material.dart';
import 'package:pokedex/custom/custom_button.dart';
import 'package:pokedex/home_page/home.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(children: [
        const Image(
          image: AssetImage('assets/background.jpeg'),
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          body: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                child: Image.asset(
                  "assets/poke_title.png",
                  width: 180,
                  height: 100,
                ),
              ),
              const Text(
                'Hello Adventurer!',
                style: TextStyle(
                    fontSize: 30,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 60),
              Image.asset('assets/ash.png', height: 300, width: 500),
              const SizedBox(height: 60),
              // add a button here
              GestureDetector(
                onTap: () => Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => const Home())),
                child: CustomButton(
                  width: 200,
                  height: 50,
                  color: Colors.red,
                  child: const Center(
                    child: Text(
                      'Get Started',
                      style: TextStyle(
                          fontSize: 24,
                          color: Colors.black,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
