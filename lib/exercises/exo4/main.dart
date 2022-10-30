import 'dart:convert';

String run(String base64Input) {
  if(base64Input.isEmpty) {
    return "Veuilez remplir le champ";
  }
  try {
    List<dynamic> decodedString = jsonDecode(String.fromCharCodes(base64Decode(base64Input.replaceAll("\n", ""))));
    List<Map<String, dynamic>> sortedPlanets = [];
    for (Map<String, dynamic> decodedPlanet in decodedString) {
      if(sortedPlanets.isEmpty) {
        sortedPlanets.add(decodedPlanet);
      } else {
        int currentLevel = 0;
        while(true) {
          if(sortedPlanets[currentLevel]["distanceToStar"] > decodedPlanet["distanceToStar"]) {
            sortedPlanets.insert(currentLevel, decodedPlanet);
            break;
          } else {
            if(sortedPlanets.length - 1 == currentLevel ) {
              sortedPlanets.add(decodedPlanet);
              break;
            } else {
              currentLevel++;
            }
          }
        }
      }
    }
    String finalString = "";
    for (Map<String, dynamic> sortedPlanet in sortedPlanets) {
      finalString += "Nom : ${sortedPlanet["name"]}\n";
      finalString += "Taille : ${sortedPlanet["size"]}km\n";
      finalString += "Masse : ${sortedPlanet["mass"]} tonnes\n";
      finalString += "Distance à l’étoile : ${sortedPlanet["distanceToStar"]}km\n\n";
    }

    return finalString.trim();
  } on FormatException {
    return "Les donnéx rentrés sont érronés";
  }
}