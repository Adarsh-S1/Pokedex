import 'package:flutter/material.dart';
import 'package:pokedex/custom/custom_ui_container.dart';
import 'package:pokedex/home_page/camera.dart';
import 'package:pokedex/home_page/catalog.dart';
import 'package:pokedex/llm_api/my_llm.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:icons_plus/icons_plus.dart';
import 'description.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int count = 1;
  List<String> notcapturedpokemon = [];
  @override
  void initState() {
    setSharedPrefernce();
    // setDefaultCollectedPokemon();
    // getCountofpokemon();
    // getListofpokemon();
    super.initState();
  }

  void setSharedPrefernce() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setInt("countofcapturedpokemon", 1);
    // prefs.setStringList("listofnotcapturedpokemon", [""]);
    prefs.setInt("countofcapturedpokemon", 1);
    prefs.setStringList("listofnotcapturedpokemon", ["pikachu"]);
    count = prefs.getInt("countofcapturedpokemon") ?? 0;
    notcapturedpokemon =
        prefs.getStringList("listofnotcapturedpokemon") ?? ["pikachu"];
    setState(() {});
  }

  // Future<void> setDefaultCollectedPokemon() async {
  //   SharedPreferences prefs = await SharedPreferences.getInstance();
  //   prefs.setInt("countofcapturedpokemon", 1);
  //   prefs.setStringList("listofnotcapturedpokemon", [""]);
  // }

  // Future<void> getCountofpokemon() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   count = prefs.getInt("countofcapturedpokemon");
  // }

  // Future<void> getListofpokemon() async {
  //   final SharedPreferences prefs = await SharedPreferences.getInstance();
  //   notcapturedpokemon = prefs.getStringList("listofnotcapturedpokemon");
  // }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      child: Stack(
        children: [
          Center(
            child: Image.asset(
              color: const Color.fromARGB(198, 157, 157, 157),
              "assets/pokeball_background.png",
              width: 800,
              height: 800,
            ),
          ),
          Scaffold(
            backgroundColor: Colors.transparent,
            body: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                      child: Image.asset(
                        "assets/poke_title.png",
                        width: 180,
                        height: 100,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                        count.toString(),
                        style: const TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                CustomUiContainer(
                  width: MediaQuery.of(context).size.width * 0.95,
                  height: MediaQuery.of(context).size.height * 0.25,
                  child: Row(
                    children: [
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Text("Hey\nAdventurer",
                            style: TextStyle(
                                fontSize: 25, fontWeight: FontWeight.bold)),
                      ),
                      const Spacer(),
                      SizedBox(
                        width: 205,
                        height: 150,
                        child: CarouselSlider(
                          options: CarouselOptions(
                            height: 200.0,
                            autoPlay: true,
                            autoPlayInterval: const Duration(seconds: 3),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            enlargeCenterPage: true,
                            enlargeFactor: 1,
                          ),
                          items: notcapturedpokemon.map((i) {
                            return Builder(
                              builder: (BuildContext context) {
                                return Container(
                                    width: 250,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 5.0),
                                    decoration: const BoxDecoration(
                                        color: Colors.transparent),
                                    child: Image.asset(
                                      "assets/PokemonDataset/$i.png",
                                      fit: BoxFit.cover,
                                    ));
                              },
                            );
                          }).toList(),
                        ),
                      )
                    ],
                  ),
                ),
                Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Catalog()));
                          },
                          child: CustomUiContainer(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 150,
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text(
                                  "Catalog",
                                  style: TextStyle(
                                      fontSize: 25,
                                      fontWeight: FontWeight.bold),
                                ),
                              ))),
                    ),
                    const Spacer(),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const Description()));
                          },
                          child: CustomUiContainer(
                              width: MediaQuery.of(context).size.width * 0.45,
                              height: 150,
                              child: const Padding(
                                padding: EdgeInsets.all(15.0),
                                child: Text("Get Help",
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold)),
                              ))),
                    )
                  ],
                ),
                const SizedBox(
                  height: 120,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const MyLlm()));
                  },
                  child: CustomUiContainer(
                    height: MediaQuery.of(context).size.height * 0.1,
                    width: MediaQuery.of(context).size.width * 0.95,
                    child: const Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "Chat here...",
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 25),
                      ),
                    ),
                  ),
                ),
                const Spacer(),
                Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Camera()));
                    },
                    child: const Icon(
                      Clarity.camera_line,
                      size: 70,
                    ),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
