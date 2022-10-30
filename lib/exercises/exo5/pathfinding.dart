import 'package:asynconf_gui/exercises/exo5/cell.dart';

class FindingResult {
  final bool success;
  final Map<Cell, Cell> foundPath;
  final Position dest;
  final Cell from;

  FindingResult(this.success, this.foundPath, this.dest, this.from);

  String showPath() {
    String midString = "";
    Cell current = from;
    while (true) {
      if (foundPath.containsKey(current)) {
        Cell newCurrent = foundPath[current]!;
        midString += "${newCurrent.position.toString()};";
        current = newCurrent;
      } else {
        break;
      }
    }
    String finalString = "";
    for(String cell in midString.split(";").reversed) {
      if(cell.isNotEmpty) {
        finalString += "$cell;";
      }
    }
    finalString += dest.toString();
    return finalString;
  }
}

/// In A*
class PathFinding {
  List<List<Cell>> playField;
  final Position src;
  final Position dest;
  PathFinding(this.playField, this.src, this.dest);

  bool isInBound(Position position) {
    return position.y < playField.length && position.x < playField[0].length && position.x >= 0 && position.y >= 0;
  }

  Cell getCell(Position pos) {
    return playField[pos.y][pos.x];
  }

  num getH(Position pos) {
    return (pos.x - pos.x).abs() + 
     (pos.y - pos.y).abs();
  }

  List<Cell> getNeighbours(Position currentPos) {
    List<Position> possibleNeighbours = [Position(currentPos.x, currentPos.y - 1), Position(currentPos.x, currentPos.y + 1), Position(currentPos.x + 1, currentPos.y), Position(currentPos.x - 1, currentPos.y)];
    List<Cell> finalPos = [];
    for (Position possibleNeighbor in possibleNeighbours) {
      if(isInBound(possibleNeighbor)) {
        Cell createdCell = getCell(possibleNeighbor);
        if(createdCell.type != 0) {
          finalPos.add(createdCell);
        }
      }
    }
    return finalPos;
  }

  FindingResult doPathFinding() {
    List<Cell> openList = [getCell(src)];
    Map<Cell, Cell> comeFrom = {};

    Map<Position, num> gScore = {src: 0};

    Map<Position, num> fScore = {src: getH(src)};

    Cell lastSet = getCell(src);

    while(openList.isNotEmpty) {
      Cell? current;
      for(Cell cell in openList) {
        if(current == null || fScore[cell.position]! < fScore[current.position]!) {
          current = cell;
        }
      }
      if(current!.position == dest) {
        return FindingResult(true, comeFrom, dest, current);
      }
      openList.remove(current);
      for (Cell neighbor in getNeighbours(current.position)) {
        num tentativeGscore = gScore[current.position]! + 1;
        if (tentativeGscore < (gScore.containsKey(neighbor.position) ? gScore[neighbor.position]! : 2147483647)) {
          comeFrom[neighbor] = current;
          lastSet = neighbor;
          gScore[neighbor.position] = tentativeGscore;
          fScore[neighbor.position] = tentativeGscore + getH(neighbor.position);
          if (!openList.contains(neighbor)) {
            openList.add(neighbor);
          }
        }
      }
    }

    return FindingResult(false, comeFrom, dest, lastSet);
  }
}