
import 'dart:ui';

import 'package:asynconf_gui/exercises/exo5/cell.dart';
import 'package:asynconf_gui/exercises/exo5/pathfinding.dart';
import 'package:flutter/material.dart';
import 'package:asynconf_gui/exercises/exo5/main.dart' as exo5;

class ExerciseFive extends StatefulWidget {
  const ExerciseFive({super.key});
  
  @override
  State<StatefulWidget> createState() => _ExerciseFiveState();
}

class _ExerciseFiveState extends State<ExerciseFive> {
  TextEditingController boardController = TextEditingController();
  bool solved = false;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(child: Column(children: [
      const Text("Veuillez rentrer le champ d'astéroïdes"),
      TextField(controller: boardController, minLines: 5, maxLines: null, onChanged: (value) => setState(() {}),),
      ElevatedButton(onPressed: () {
        setState(() {
          solved = true;
        });
        }, child: const Text("Résoudre")),
      if(isBoardValid())
        CustomPaint(painter: Board(boardController.text, MediaQuery.of(context).platformBrightness, solved), size: const Size(1728, 516.5),)
      else
        const Text("Les donnés rentrés sont érronés")
    ]),);
  }

  bool isBoardValid() {
    int lastLineLength = -1;
    bool foundStart = false;
    bool foundEnd = false;
    for (String line in boardController.text.split("\n")) {
      if(lastLineLength != -1 && line.length != lastLineLength) {
        return false;
      } else {
        lastLineLength = line.length;
      }
      for (int rawCell in line.codeUnits) {
        String cell = String.fromCharCode(rawCell);
        if(cell == 'V') {
          if(foundEnd) {
            return false;
          } else {
            foundEnd = true;
          }
        } else if(cell == 'X') {
          if(foundStart) {
            return false;
          } else {
            foundStart = true;
          }
        } else if(cell != 'O' && cell != '_') {
          return false;
        }
      }
    }
    return foundStart && foundEnd;
  }
}

class Board extends CustomPainter {
  late final int width;
  late final int height;
  final String board;
  final Brightness drawBrightness;
  final bool solved;

  Board(this.board, this.drawBrightness, this.solved) {
    width = board.split("\n")[0].length + 1;
    height = board.split("\n").length + 1;
  }

  @override
  void paint(Canvas canvas, Size size) {
    int currentX = 0;
    int currentY = 0;

    final pathPaint = Paint()
      ..color = Colors.blueAccent.shade100
      ..strokeWidth = 0;

    if(solved) {

      exo5.PlayingField parseOutput = exo5.parseField(board);
      FindingResult result = PathFinding(parseOutput.cells, parseOutput.currentPos, parseOutput.finishPos).doPathFinding();
      if(result.success) {
        for(String cell in result.showPath().split(";")) {
          int cellX = Position.alphabet.indexOf(cell[0]) + 1;
          int cellY = int.tryParse(cell[1])!;
          Offset p1 = Offset(size.width / width * cellX, size.height / height * cellY- 1);
          Offset p2 = Offset(p1.dx + size.width / width, size.height / height * cellY + size.height / height);

          canvas.drawRect(Rect.fromPoints(p1, p2), pathPaint);
        }
      }
    }

    final srcPaint = Paint()
      ..color = Colors.greenAccent
      ..strokeWidth = 8;

    final destPaint = Paint()
      ..color = Colors.redAccent
      ..strokeWidth = 8;

    final paint = Paint()
      ..color = drawBrightness == Brightness.dark ? Colors.white : Colors.black
      ..strokeWidth = 4;

    for (String line in board.split("\n")) {
      currentY++;
      for (int rawCell in line.codeUnits) {
        currentX++;
        String cell = String.fromCharCode(rawCell);
        Offset p1 = Offset(size.width / width * currentX, size.height / height * currentY - 1);
        Offset p2 = Offset(p1.dx + size.width / width, size.height / height * currentY + size.height / height);

        if(cell == 'X') {
          canvas.drawRect(Rect.fromPoints(p1, p2), srcPaint);
        } else if(cell == 'V') {
          canvas.drawRect(Rect.fromPoints(p1, p2), destPaint);          
        } else if(cell == 'O') {
          canvas.drawRect(Rect.fromPoints(p1, p2), paint);
        }
      }
      currentX = 0;
    }

    for (var i = 0; i <= width; i++) {
      Offset p1 = Offset(size.width / width * i, 0);
      Offset p2;
      if(i < 2 || i == width) {
        p2 = Offset(size.width / width * i, size.height - 1);
      } else {
        p2 = Offset(size.width / width * i, size.height / height);
      }

      canvas.drawLine(p1, p2, paint);
      if(i + 1 <= width && i != 0) {
        ParagraphBuilder builder = ParagraphBuilder(ParagraphStyle(textAlign: TextAlign.center, fontSize: 50));
        builder.addText(Position.alphabet[i - 1]);
        final paragraph = builder.build()
          ..layout(ParagraphConstraints(width: size.width / width));
        canvas.drawParagraph(paragraph, p1);
      }
    }

    for (var i = 0; i <= height; i++) {
      Offset p1 = Offset(0, size.height / height * i);
      Offset p2;
      if(i < 2 || i == height) {
        p2 = Offset(size.width, size.height / height * i);
      } else {
        p2 = Offset(size.width / width, size.height / height * i);
      }
      canvas.drawLine(p1, p2, paint);

      if(i + 1 <= height && i != 0) {
        ParagraphBuilder builder = ParagraphBuilder(ParagraphStyle(textAlign: TextAlign.end, fontSize: 50));
        builder.addText(i.toString());
        final paragraph = builder.build()
          ..layout(ParagraphConstraints(width: size.height / height));
        canvas.drawParagraph(paragraph, p1);
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }

}