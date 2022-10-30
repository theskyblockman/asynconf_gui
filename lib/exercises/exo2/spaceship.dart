class SpaceShip {
  final String name;
  final double speed; // In km/h
  final double price; // in €/km
  
  SpaceShip(this.name, this.speed, this.price);

  num makePrice(int travelTime) {
    return 24 * travelTime * speed * price;
  } 
}