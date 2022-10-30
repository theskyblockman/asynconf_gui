import 'package:asynconf_gui/exercises/exo2/spaceship.dart';

num run(String askedSpaceship, String travelTime) {
  List<String> attributes = askedSpaceship.split(";");
  String? name;
  double? speed;
  double? price;
  if(attributes.length > 3) {
    return -1;
  } else if(attributes.length < 3) {
    return -2;
  }
  for (String attribute in attributes) {
    List<String> keyValue = attribute.split('=');
    if(keyValue.length != 2) {
      return -3;
    }
    switch (keyValue[0]) {
      case "name":
        name = keyValue[1];
        break;
      case "speed":
        speed = double.tryParse(keyValue[1].substring(0, keyValue[1].length - 4));
        if (speed == null) {
          return -4;
        } else if(speed < 0) {
          return -5;
        }
        break;
      case "price":
        price = double.tryParse(keyValue[1].substring(0, keyValue[1].length - 3));
        if (price == null) {
          return -6;
        } else if(price < 0) {
          return -7;
        }
        break;
    }
  }
  if (name == null || speed == null || price == null) {
    return -8;
  }
  int? readTravelTime = int.tryParse(travelTime);
  if(readTravelTime == null) {
    return -9;
  } else if(readTravelTime < 0) {
    return -10;
  }
  return SpaceShip(name, speed, price).makePrice(readTravelTime);
}