import 'package:asynconf_gui/exercises/exo5/pathfinding.dart';
import 'package:asynconf_gui/exercises/exo5/cell.dart';

class PlayingField {
  final List<List<Cell>> cells;
  final Position currentPos;
  final Position finishPos;

  PlayingField(this.cells, this.currentPos, this.finishPos);
}

PlayingField parseField(String rawPlayingField) {
  int currentXPosition = -1;
  int currentYPosition = -1;
  int finishXPosition = -1;
  int finishYPosition = -1;
  List<List<Cell>> playingField = [];
  int currentX = -1;
  int currentY = -1;
  for(String rawFieldLine in rawPlayingField.toUpperCase().split("\n")) {
    List<Cell> fieldLine = [];
    currentY++;
    currentX = -1;
    for(int rawFieldCase in rawFieldLine.codeUnits) {
      currentX++;
      String fieldCase = String.fromCharCode(rawFieldCase);
      if(fieldCase == "X") {
        currentXPosition = currentX;
        currentYPosition = currentY;
      } else if(fieldCase == "V") {
        finishXPosition = currentX;
        finishYPosition = currentY;
      }
      
      fieldLine.add(Cell(Position(currentX, currentY), fieldCase == "O" ? 0 : 1));

    }
    playingField.add(fieldLine);
  }
  return PlayingField(playingField, Position(currentXPosition, currentYPosition), Position(finishXPosition, finishYPosition));
}

String run(String rawPlayingField) {
  PlayingField field = parseField(rawPlayingField);
  return PathFinding(field.cells, field.currentPos, field.finishPos).doPathFinding().showPath();
}
/*
  ABCDEFGHIJKLMNOPQRST
1 O___O_OO__OO__VO_O_O
2 __O___O_OOO_OO_____O
3 OO___O___OOO_OOOOO_O
4 __OO__X__OO_O___O__O
5 _OO___OO______O___OO

up = 0
left = 1
bottom = 2
right = 3
*/