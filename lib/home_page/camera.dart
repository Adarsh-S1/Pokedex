import 'package:flutter/material.dart';
import 'package:camera/camera.dart';
import 'package:gal/gal.dart';
import 'package:pokedex/result_page/myresult.dart';

class Camera extends StatefulWidget {
  const Camera({super.key});

  @override
  State<Camera> createState() => _CameraState();
}

class _CameraState extends State<Camera> with WidgetsBindingObserver {
  CameraController? controller;
  List<CameraDescription> camear = [];

  // ignore: non_constant_identifier_names
  Future<void> _Setupcameracontroller() async {
    // ignore: no_leading_underscores_for_local_identifiers
    List<CameraDescription> _camear = await availableCameras();
    if (_camear.isNotEmpty) {
      setState(() {
        camear = _camear;
        controller = CameraController(_camear.first, ResolutionPreset.high);
      });
    }
    controller?.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      // ignore: avoid_print
      print(e);
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (controller == null || controller!.value.isInitialized == false) {
      return;
    }
    if (state == AppLifecycleState.inactive) {
      controller!.dispose();
    } else if (state == AppLifecycleState.resumed) {
      _Setupcameracontroller();
    }
  }

  @override
  void initState() {
    super.initState();
    _Setupcameracontroller();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Camera"),
      ),
      body: Column(children: <Widget>[
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black,
              border: Border.all(
                color: controller != null && controller!.value.isRecordingVideo
                    ? Colors.redAccent
                    : Colors.grey,
                width: 3.0,
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Center(
                child: _cameraPreviewWidget(),
              ),
            ),
          ),
        ),
        IconButton(
            onPressed: () async {
              XFile pic = await controller!.takePicture();
              await Gal.putImage(pic.path);
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Myresult(path: pic.path)));
            },
            icon: const Icon(
              Icons.camera,
              size: 40,
            )),
      ]),
    );
  }

  Widget _cameraPreviewWidget() {
    if (controller == null || !controller!.value.isInitialized) {
      return const Text(
        'Tap a camera',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24.0,
          fontWeight: FontWeight.w900,
        ),
      );
    } else {
      return SizedBox(
        height: MediaQuery.of(context).size.height * 80,
        width: MediaQuery.of(context).size.width * 80,
        child: CameraPreview(
          controller!,
          // child: LayoutBuilder(
          //     builder: (BuildContext context, BoxConstraints constraints) {
          //   return GestureDetector(
          //     behavior: HitTestBehavior.opaque,
          //     onScaleStart: _handleScaleStart,
          //     onScaleUpdate: _handleScaleUpdate,
          //     onTapDown: (TapDownDetails details) =>
          //         onViewFinderTap(details, constraints),
          //   );
          // }),
        ),
      );
    }
  }
}
