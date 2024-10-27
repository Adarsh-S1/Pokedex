// import 'package:tflite_flutter/tflite_flutter.dart';

// class TensorClass {
//   static Interpreter? interpreter;
//   static IsolateInterpreter? isolateInterpreter;
//   void declaration(input, output) async {
//     interpreter = await Interpreter.fromAsset('lib/assets/model.tflite');
//     isolateInterpreter =
//         await IsolateInterpreter.create(address: interpreter!.address);
//   }
//     //isolateInterpreter.toString();

//     await isolateInterpreter!.run(input, output);
//     await isolateInterpreter!.runForMultipleInputs(input, output);

// }
