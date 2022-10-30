import 'package:flutter/material.dart';
import 'package:asynconf_gui/exercises/exo2/main.dart' as exo2;
import 'package:asynconf_gui/exercises/exo2/spaceship.dart';
import 'package:flutter/services.dart';

class ExerciseTwo extends StatefulWidget {
  const ExerciseTwo({super.key});
  
  @override
  State<StatefulWidget> createState() => _ExerciseTwoState();
}

class _ExerciseTwoState extends State<ExerciseTwo> {
  bool isOriginalMode = false;
  
  TextEditingController originalController = TextEditingController();
  TextEditingController missionLengthController = TextEditingController();

  TextEditingController adaptedSpeedController = TextEditingController();
  TextEditingController adaptedCostPerKmController = TextEditingController();
  TextEditingController adaptedMissionTimeController = TextEditingController();

  num finalPrice = -11;

  final Map<int, String> errors = {
    -1: "Vous avez donné trop de donnés dans les charactéristiques du vesseau",
    -2: "Vous n'avez pas rentré assez de donnés sur les charactéristiques du vesseau",
    -3: "Les donnés que vous avez rentré sont mal rédigé, veuillez les vérifier",
    -4: "Vos donnés de vitesse sont éronés (un nombre est demandé)",
    -5: "Vous avez rentré une vitesse négatif ce qui n'est pas possible",
    -6: "Vos donnés de prix sont éronés (un nombre est demandé)",
    -7: "Vous avez rentré un prix négatif ce qui n'est pas possible",
    -8: "Vous n'avez pas renseigné un ou plusieurs champs.",
    -9: "Veuillez rentrer un temps de trajet valide",
    -10: "Le temps de voyage ne peux pas être négatif",
    -11: "Veuillez appuier sur le bouton \"Générer\""
  };

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Center(child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      const Text("Quel mode voulez vous utiliser?"),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Switch(value: !isOriginalMode, onChanged: (value) {
          setState(() {
            isOriginalMode = !value;
          });
        }),
        Text(isOriginalMode ? "Avec entrées original" : "Avec entrées adaptés")
      ]),
      if (isOriginalMode)
        Column(children: [
          const Text("Veuillez rentrer les attributs du vaiseau"),
          TextField(controller: originalController),
          const Text("Veuillez rentrer la longueur de la mission"),
          TextField(controller: missionLengthController),
          ElevatedButton(onPressed: () {
            setState(() {
              finalPrice = exo2.run(originalController.text, missionLengthController.text);
            });
          }, child: const Text("Générer le prix")),
          Text(errors.containsKey(finalPrice) ? "Erreur: ${errors[finalPrice]}" : "Le prix final de la mission s'élève à $finalPrice€")
        ])
      else
        Column(children: [
          const Text("Veuillez rentrer la vitesse du vaiseau"),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: adaptedSpeedController,
          ),
          const Text("Veuillez rentrer le prix en € / km du vaiseau"),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: adaptedCostPerKmController,
          ),
          const Text("Veuillez rentrer la longueur de la mission en jour"),
          TextField(
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly
            ],
            controller: adaptedMissionTimeController,
          ),
          ElevatedButton(onPressed: () {
            setState(() {});
          }, child: const Text("Générer")),
          Text(double.tryParse(adaptedSpeedController.text) != null || double.tryParse(adaptedSpeedController.text) != null || double.tryParse(adaptedMissionTimeController.text) != null ? "Le prix final est de ${double.tryParse(adaptedSpeedController.text)! * double.tryParse(adaptedCostPerKmController.text)! * double.tryParse(adaptedMissionTimeController.text)! * 24}€" : "Une valeur que vous avez rentré n'est pas valide")
        ])
    ])));
  }
}
