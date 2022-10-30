import 'package:flutter/material.dart';
import 'package:asynconf_gui/exercises/exo1/main.dart' as exo1;

class Planet extends StatelessWidget {
  late final TextField currentField;
  final TextEditingController _controller = TextEditingController();
  final void Function(Planet currentPlanet) onDelete;

  Planet({super.key, required this.onDelete}) {
    currentField = TextField(controller: _controller, decoration: const InputDecoration(isDense: true),);
  }

  String get text {
    return _controller.text;
  }

  @override
  Widget build(BuildContext context) {
    return Row(children: [Flexible(child: currentField), IconButton(onPressed: () {
      onDelete(this);
    }, icon: const Icon(Icons.remove))]) ;
  }

}

class ExerciseOne extends StatefulWidget {
  const ExerciseOne({super.key});
  
  @override
  State<StatefulWidget> createState() => _ExerciseOneState();
}

class _ExerciseOneState extends State<ExerciseOne> {
  List<Planet> currentPlanets = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: SingleChildScrollView(child: 
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Veuillez rentrer toutes les planètes dans l'ordre", textAlign: TextAlign.center), 
          Column(children: currentPlanets),
          if(currentPlanets.isNotEmpty)
            Column(children: [
              const Padding(padding: EdgeInsets.only(top: 15)),
              ElevatedButton(onPressed: () {
                setState(() {});
              }, child: const Text("Générer")),
              const Text("Pour ces planètes, voici le nom de code de la mission"), 
              Text(exo1.run(getValues()))
            ])
        ]
      )
    ), floatingActionButton: FloatingActionButton(child: const Icon(Icons.add), onPressed: () {
      setState(() {
        currentPlanets.add(Planet(onDelete: (currentPlanet) {
          setState(() {
            currentPlanets.remove(currentPlanet);
          });
        }));
      });
    }));
  }

  List<String> getValues() {
    List<String> finalList = [];
    for (Planet planet in currentPlanets) {
      finalList.add(planet.text);
    }
    return finalList;
  }
}