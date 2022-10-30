String run(List<String> planets) {
  String finalString = "";
  List<String> indexedPlanets = [];
  for (String planet in planets) {
    bool appended = false;
    for (var i = planet.length - 1; i > 0; i--) {
      String part = planet.substring(0, planet.length - i);
      if(!indexedPlanets.contains(part)) {
        finalString += part + (planet.length - (planet.length - i)).toString();
        indexedPlanets.add(part);
        appended = true;
        break;
      }
      if(appended) {
        break;
      }
    }
  }

  return finalString;
}