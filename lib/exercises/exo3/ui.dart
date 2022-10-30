import 'package:flutter/material.dart';

class ExerciseThree extends StatefulWidget {
  const ExerciseThree({super.key});
  
  @override
  State<StatefulWidget> createState() => _ExerciseThreeState();
}

class _ExerciseThreeState extends State<ExerciseThree> {
  bool isOriginalMode = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      const Text("Quel mode voulez vous utiliser?"),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Switch(value: !isOriginalMode, onChanged: (value) {
          setState(() {
            isOriginalMode = !value;
          });
        }),
        Text(isOriginalMode ? "Dans une console" : "Dans l'application")
      ])
    ]));
  }
}