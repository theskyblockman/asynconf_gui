import 'package:asynconf_gui/exercises/exo1/main.dart' as exo1;
import 'package:asynconf_gui/exercises/exo2/main.dart' as exo2;
import 'package:asynconf_gui/exercises/exo4/main.dart' as exo4;
import 'package:asynconf_gui/exercises/exo5/main.dart' as exo5;
import 'package:test/test.dart';

void main() {
  test('exo1', () {
    expect(exo1.run(["Jupiter", "Terre"]), "J6T4");
    expect(exo1.run(["Lune", "Terre", "Soleil"]), "L3T4S5");
    expect(exo1.run(["Terre", "Mars", "Mercure"]), "T4M3Me5");
    expect(exo1.run(["Pluton", "Mercure", "Terre", "Mars", "Calisto"]), "P5M6T4Ma2C6");
  });
  test('exo2', () {
    expect(exo2.run("name=Atmos;speed=2045km/h;price=23/km", "2"), 2257680);
    expect(exo2.run("name=Crystal;speed=20000km/h;price=400/km", "10"), 1920000000);
    expect(exo2.run("name=CircleBurn;speed=178547km/h;price=3612/km", "6"), 92867294016);
    expect(exo2.run("name=SpaceDestroyer;speed=98928423km/h;price=9294/km", "12"), 264798939848256);
  });

  test('exo4', () {
    expect(exo4.run("""
WwogICAgewogICAgICAgICJuYW1lIjogIlNpbG9wcCIsCiA
gICAgICAgInNpemUiOiAxNDkyNCwKICAgICAgICAiZGlzdG
FuY2VUb1N0YXIiOiA5MDI0ODQ1MiwKICAgICAgICAibWFzc
yI6IDE5NDUzMgogICAgfSwKICAgIHsKICAgICAgICAibmFt
ZSI6ICJBc3RyaW9uIiwKICAgICAgICAic2l6ZSI6IDE1MjA
wMCwKICAgICAgICAiZGlzdGFuY2VUb1N0YXIiOiAxNDkzMD
IsCiAgICAgICAgIm1hc3MiOiAyMTk0CiAgICB9LAogICAge
wogICAgICAgICJuYW1lIjogIlZhbGVudXMiLAogICAgICAg
ICJzaXplIjogMjkwNDUwLAogICAgICAgICJkaXN0YW5jZVR
vU3RhciI6IDIwOTQ4NTkzNDU1LAogICAgICAgICJtYXNzIj
ogMTk1MjkzCiAgICB9Cl0="""), 
"""Nom : Astrion
Taille : 152000km
Masse : 2194 tonnes
Distance à l’étoile : 149302km

Nom : Silopp
Taille : 14924km
Masse : 194532 tonnes
Distance à l’étoile : 90248452km

Nom : Valenus
Taille : 290450km
Masse : 195293 tonnes
Distance à l’étoile : 20948593455km""");
  });

  test('exo5', () {
    expect(exo5.run(
"""O___O_OO__OO__VO_O_O
__O___O_OOO_OO_____O
OO___O___OOO_OOOOO_O
__OO__X__OO_O___O__O
_OO___OO______O___OO"""), "G4;H4;I4;I5;J5;K5;L5;M5;N5;N4;O4;P4;P5;Q5;R5;R4;S4;S3;S2;R2;Q2;P2;O2;O1");
  });
}
