import 'package:asynconf_gui/exercises/exo3/commands.dart';

class Account {
  late final String name;
  late final List<Commands> availableCommands;
  late final bool isAdmin;

  Account.asNormal(this.name, this.availableCommands) {
    isAdmin = false;
  }

  Account.asAdmin() {
    name = "Administrateur";
    isAdmin = true;
    availableCommands = [];
  }

  bool hasPermission(String input) {
    if(isAdmin) return true;
    for (Commands command in availableCommands) {
      if(command.name == input.toLowerCase()) return true;
    }
    return false;
  }
}