import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:image/image.dart' as img;
import 'package:pokedex/custom/custom_detailpage.dart';
import 'package:pokedex/functions/cvs_handling.dart';
import 'package:tflite_flutter/tflite_flutter.dart';

import '../custom/custom_button.dart';
//import 'dart:typed_data';

// ignore: must_be_immutable
class Myresult extends StatefulWidget {
  String path;
  Myresult({super.key, required this.path});

  @override
  State<Myresult> createState() => _MyresultState();
}

class _MyresultState extends State<Myresult> {
  late Interpreter _interpreter;
  late IsolateInterpreter isolateInterpreter;
  File? _imageFile;
  // ignore: unused_field
  List<dynamic>? _output;
  CvsHandling mycsv = CvsHandling();
  bool toshow = false;
  List<int>? myresult;
  final List class_names = [
    'Abra',
    'Aerodactyl',
    'Alakazam',
    'Alolan Sandslash',
    'Arbok',
    'Arcanine',
    'Articuno',
    'Beedrill',
    'Bellsprout',
    'Blastoise',
    'Bulbasaur',
    'Butterfree',
    'Caterpie',
    'Chansey',
    'Charizard',
    'Charmander',
    'Charmeleon',
    'Clefable',
    'Clefairy',
    'Cloyster',
    'Cubone',
    'Dewgong',
    'Diglett',
    'Ditto',
    'Dodrio',
    'Doduo',
    'Dragonair',
    'Dragonite',
    'Dratini',
    'Drowzee',
    'Dugtrio',
    'Eevee',
    'Ekans',
    'Electabuzz',
    'Electrode',
    'Exeggcute',
    'Exeggutor',
    'Farfetchd',
    'Fearow',
    'Flareon',
    'Gastly',
    'Gengar',
    'Geodude',
    'Gloom',
    'Golbat',
    'Goldeen',
    'Golduck',
    'Golem',
    'Graveler',
    'Grimer',
    'Growlithe',
    'Gyarados',
    'Haunter',
    'Hitmonchan',
    'Hitmonlee',
    'Horsea',
    'Hypno',
    'Ivysaur',
    'Jigglypuff',
    'Jolteon',
    'Jynx',
    'Kabuto',
    'Kabutops',
    'Kadabra',
    'Kakuna',
    'Kangaskhan',
    'Kingler',
    'Koffing',
    'Krabby',
    'Lapras',
    'Lickitung',
    'Machamp',
    'Machoke',
    'Machop',
    'Magikarp',
    'Magmar',
    'Magnemite',
    'Magneton',
    'Mankey',
    'Marowak',
    'Meowth',
    'Metapod',
    'Mew',
    'Mewtwo',
    'Moltres',
    'MrMime',
    'Muk',
    'Nidoking',
    'Nidoqueen',
    'Nidorina',
    'Nidorino',
    'Ninetales',
    'Oddish',
    'Omanyte',
    'Omastar',
    'Onix',
    'Paras',
    'Parasect',
    'Persian',
    'Pidgeot',
    'Pidgeotto',
    'Pidgey',
    'Pikachu',
    'Pinsir',
    'Poliwag',
    'Poliwhirl',
    'Poliwrath',
    'Ponyta',
    'Porygon',
    'Primeape',
    'Psyduck',
    'Raichu',
    'Rapidash',
    'Raticate',
    'Rattata',
    'Rhydon',
    'Rhyhorn',
    'Sandshrew',
    'Sandslash',
    'Scyther',
    'Seadra',
    'Seaking',
    'Seel',
    'Shellder',
    'Slowbro',
    'Slowpoke',
    'Snorlax',
    'Spearow',
    'Squirtle',
    'Starmie',
    'Staryu',
    'Tangela',
    'Tauros',
    'Tentacool',
    'Tentacruel',
    'Vaporeon',
    'Venomoth',
    'Venonat',
    'Venusaur',
    'Victreebel',
    'Vileplume',
    'Voltorb',
    'Vulpix',
    'Wartortle',
    'Weedle',
    'Weepinbell',
    'Weezing',
    'Wigglytuff',
    'Zapdos',
    'Zubat'
  ];
  String? pokemon;
  @override
  void initState() {
    super.initState();
    _mytensor();
    // getImage();
  }

  @override
  void dispose() {
    super.dispose();
    isolateInterpreter.close();
  }

  Future<void> _mytensor() async {
    try {
      _interpreter = await Interpreter.fromAsset('lib/assets/model.tflite');
      isolateInterpreter =
          await IsolateInterpreter.create(address: _interpreter.address);
    } catch (e) {
      // ignore: avoid_print
      print('Error loading model: $e');
    }
  }

  Future<void> getImage() async {
    setState(() {
      _imageFile = File(widget.path);
    });

    await runInference();
  }

  Widget my() {
    if (kIsWeb) {
      return Image.network(widget.path);
    } else {
      return CustomButton(
          width: MediaQuery.of(context).size.width * 0.8,
          height: MediaQuery.of(context).size.height * 0.6,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Image.file(File(widget.path)),
          ));
    }
  }

  Future<void> runInference() async {
    List<dynamic>? result;
    if (_imageFile == null) return;
    img.Image? imageInput = img.decodeImage(_imageFile!.readAsBytesSync());
    int inputSize = 180;
    imageInput =
        img.copyResize(imageInput!, width: inputSize, height: inputSize);
    List<List<List<List<double>>>> input = imageToFloat32List(imageInput);
    List<dynamic> output = List.filled(150, 0).reshape([1, 150]);
    try {
      await isolateInterpreter.run(input, output);
      setState(() {
        result = output[0].map((e) => e).toList();
        _output = result;
        toshow = true;
        pokemon = class_names[findLargestIndex(result!)];
      });
    } catch (e) {
      throw ArgumentError("error during inference : $e");
    }
  }

  int findLargestIndex(List<dynamic> numbers) {
    if (numbers.isEmpty) {
      throw ArgumentError('The list cannot be empty');
    }

    int largestIndex = 0;
    for (int i = 1; i < numbers.length; i++) {
      if (numbers[i] > numbers[largestIndex]) {
        largestIndex = i;
      }
    }
    return largestIndex;
  }

  // Function to convert image to Float32List for model input
  List<List<List<List<double>>>> imageToFloat32List(img.Image image) {
    List<List<List<List<double>>>> convertedBytes = List.generate(
      1,
      (b) => List.generate(
        180,
        (y) => List.generate(
          180,
          (x) => List.generate(3, (c) => 0.0),
        ),
      ),
    );
    //var bufferIndex = 0;
    for (int y = 0; y < image.height; y++) {
      for (int x = 0; x < image.width; x++) {
        img.Pixel pixel = image.getPixel(x, y);
        convertedBytes[0][y][x][0] = pixel.current.r / 1.0;
        convertedBytes[0][y][x][1] = pixel.current.g / 1.0;
        convertedBytes[0][y][x][2] = pixel.current.b / 1.0;
      }
    }
    return convertedBytes;
  }

  Widget showResult(toshow) {
    if (!toshow) {
      return Center(
        child: GestureDetector(
          onTap: () => getImage(),
          child: CustomButton(
            width: 100,
            height: 40,
            child: const Center(child: Text("Analyse")),
          ),
        ),
      );
    } else {
      if (pokemon == null) {
        return const Text("No pokemon Found");
      }
      return CustomDetailpage(
        pokemon: pokemon!,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Image.asset(
            "assets/poke_title.png",
            width: 180,
            height: 100,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: my(),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          showResult(toshow),
        ],
      ),
    );
  }
}
