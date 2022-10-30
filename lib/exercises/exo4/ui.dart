import 'package:flutter/material.dart';
import 'package:asynconf_gui/exercises/exo4/main.dart' as exo4;

class ExerciseFour extends StatefulWidget {
  const ExerciseFour({super.key});
  
  @override
  State<StatefulWidget> createState() => _ExerciseFourState();
}

class _ExerciseFourState extends State<ExerciseFour> {
  TextEditingController codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      const Text("Veuillez rentrer les donnés obtenu depuis le tableau de bord"),
      TextField(controller: codeController, minLines: 5, maxLines: null),
      ElevatedButton(onPressed: () {
        setState(() {});
      }, child: const Text("Générer")),
      const Text("Les résultats finaux sont"),
      Text(exo4.run(codeController.text))
    ]));
  }
}