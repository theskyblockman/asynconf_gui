class Position {
  final int x;
  final int y;
  static List<String> alphabet = ["A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z"];
  const Position(this.x, this.y);

  @override
  operator ==(Object other) {
    if(other.runtimeType != Position) {
      return false;
    } else {
      return x == (other as Position).x && y == other.y;
    }
    
  }
  
  @override
  int get hashCode {
    return x.hashCode * y.hashCode;
  }
  @override
  String toString() {
    return "${alphabet[x]}${y + 1}";
  }
}

class Cell {
  final Position position;
  final int type;

  Cell(this.position, this.type);
}