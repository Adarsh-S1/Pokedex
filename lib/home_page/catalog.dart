import 'package:flutter/material.dart';
import 'package:pokedex/custom/custom_container.dart';
import 'package:pokedex/functions/cvs_handling.dart';
import 'package:pokedex/home_page/details.dart';
import 'camera.dart';

class Catalog extends StatefulWidget {
  const Catalog({super.key});

  @override
  State<Catalog> createState() => _CatalogState();
}

class _CatalogState extends State<Catalog> {
  CvsHandling mycsv = CvsHandling();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // Padding(
              //   padding: const EdgeInsets.all(15.0),
              //   child: Center(
              //     child: IconButton(
              //       onPressed: () {
              //         Navigator.push(
              //             context,
              //             MaterialPageRoute(
              //                 builder: (context) => const Camera()));
              //       },
              //       icon: const Icon(
              //         Icons.camera_alt_rounded,
              //         size: 30,
              //       ),
              //     ),
              //   ),
              //),
            ],
          ),
          SizedBox(
            width: 400,
            height: 680,
            child: FutureBuilder(
                future: mycsv.getData(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const CircularProgressIndicator();
                  }
                  if (snapshot.hasError) {
                    return Text(snapshot.error.toString());
                  } else {
                    final mylist = snapshot.data;
                    return ListView.builder(
                        itemCount: 147, //for the head
                        itemBuilder: (context, index) {
                          return GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Details(
                                          map: mycsv.getJsonByRow(
                                              mylist[index + 1]))));
                            },
                            child: CustomContainer(
                                map: mycsv.getJsonByRow(mylist![index + 1])),
                          );
                        });
                  }
                }),
          ),
        ],
      ),
    );
  }
}
