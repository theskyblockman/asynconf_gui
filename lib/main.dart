import 'package:asynconf_gui/exercises/exo1/ui.dart';
import 'package:asynconf_gui/exercises/exo2/ui.dart';
import 'package:asynconf_gui/exercises/exo3/ui.dart';
import 'package:asynconf_gui/exercises/exo4/ui.dart';
import 'package:asynconf_gui/exercises/exo5/ui.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Réponses à l\'Asynconf 2022',
      theme: ThemeData(
        brightness: Brightness.light,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepOrangeAccent)),
        )

      ),
      darkTheme: ThemeData(
        brightness: Brightness.dark,
        useMaterial3: true,
        inputDecorationTheme: const InputDecorationTheme(
          border: OutlineInputBorder(borderSide: BorderSide(color: Colors.deepPurpleAccent)),
        )
      ),
      home: const Main(),
    );
  }
}

class Exercise {
  final int exerciseNumber;
  final String title;
  final String description;
  final Widget page;
  final Icon icon;
  final Icon notSelectedIcon;

  const Exercise({required this.exerciseNumber, required this.description, required this.title, required this.page, required this.icon, required this.notSelectedIcon});
}

class Main extends StatefulWidget {
  const Main({super.key});

  @override
  State<Main> createState() => MainState();
}

class MainState extends State<Main> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  List<Exercise> exercises = [
    const Exercise(exerciseNumber: 1, description: "Créer un nom de mission pour l'ESA à partir d'une liste de noms de planètes", title: "Nommons les étoiles", page: ExerciseOne(), notSelectedIcon: Icon(Icons.looks_one_outlined), icon: Icon(Icons.looks_one)),
    const Exercise(exerciseNumber: 2, description: "Calculer le prix du voyage d'un vaiseau avec sa vitesse, son prix/km et la durée du voyage", title: "Mission Phantom 2064", page: ExerciseTwo(), notSelectedIcon: Icon(Icons.looks_two_outlined), icon: Icon(Icons.looks_two)),
    const Exercise(exerciseNumber: 3, description: "Créer un système de tâches simple pour les membres du vaiseau", title: "Gérez vos tâches", page: ExerciseThree(), notSelectedIcon: Icon(Icons.looks_3_outlined), icon: Icon(Icons.looks_3)),
    const Exercise(exerciseNumber: 4, description: "Décoder une liste de planètes dans un format inconnu pour le décoder et les trier par leur distance au vaiseau dans un ordre croissant", title: "La supernova", page: ExerciseFour(), notSelectedIcon: Icon(Icons.looks_4_outlined), icon: Icon(Icons.looks_4)),
    const Exercise(exerciseNumber: 5, description: "Résoudre un labyrinthe", title: "Attaque de météorite", page: ExerciseFive(), notSelectedIcon: Icon(Icons.looks_5_outlined), icon: Icon(Icons.looks_5))
  ];
  int currentExercise = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        leading: IconButton(onPressed: () {
          _scaffoldKey.currentState!.openDrawer();
        }, 
        icon: const Icon(Icons.menu)
        ),
        title: Text("Exercice ${exercises[currentExercise].exerciseNumber}: ${exercises[currentExercise].title}"),
      ),
      body: exercises[currentExercise].page,
      drawerEnableOpenDragGesture: true,
      drawer: Drawer(child: SingleChildScrollView(child: Column(children: [
        for (Exercise exercise in exercises)
          createExerciseCard(exercise)
      ]))),
    );
  }

  ListTile createExerciseCard(Exercise exercise) {
    return ListTile(leading: currentExercise == exercises.indexOf(exercise)? exercise.icon : exercise.notSelectedIcon, title: Text(exercise.title), subtitle: Text(exercise.description), onTap: () {
      setState(() {
        currentExercise = exercises.indexOf(exercise);
        _scaffoldKey.currentState!.closeDrawer();
      });
    },);
  }
}