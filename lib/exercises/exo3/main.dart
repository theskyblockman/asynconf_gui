import 'dart:io';

import 'package:asynconf_gui/exercises/exo3/account.dart';
import 'package:asynconf_gui/exercises/exo3/commands.dart';
import 'package:asynconf_gui/exercises/exo3/task.dart';
import 'package:uuid/uuid.dart';

void run() {
  Uuid uuid = const Uuid();
  print("Bienvenue dans votre terminal permetant de gérer vos tâches !");
  String startUUID = uuid.v4();
  Map<String, Account> storedAccounts = {startUUID: Account.asAdmin()};
  List<Task> storedTasks = [];
  String currentAccount = startUUID;

  String? getIDOfAccount(Account account) {
    return storedAccounts.keys.firstWhere((k) => storedAccounts[k] == account);
  }

  while (true) {
    stdout.write("${storedAccounts[currentAccount]!.name}> ");
    String? input = stdin.readLineSync();
    if(input != null && input.isNotEmpty) {
      Commands? command = Commands.fromString(input);
      if(command == null) {
        print("Nous ne connaisont pas cette commande.");
      } else {
        if(storedAccounts[currentAccount]!.hasPermission(input)) {
          switch (command) {
            case Commands.connectToAccount:
              if(storedAccounts.length == 1) {
                print("Vous êtes sur le seul compte enregistré, veuiller créer d'autres comptes pour utiliser cette commande");
              } else {
                stdout.write("Veuillez rentrer le nom du compte au quel vous voulez vous connecter: ");
                String? accountName = stdin.readLineSync();
                if(accountName == null || accountName.isEmpty) {
                  print("Veuillez ne pas laisser ce champ vide.");
                } else {
                  bool foundAccount = false;
                  for(Account account in storedAccounts.values) {
                    if(account.name.toLowerCase() == accountName.toLowerCase()) {
                      if(account == storedAccounts[currentAccount]) {
                        print("Vous êtes déjà connecté sur ce compte");
                        foundAccount = true;
                        break;
                      } else {
                        currentAccount = getIDOfAccount(account)!;
                        print("Vous avez été connecté au compte: ${account.name} !");
                        foundAccount = true;
                      }
                    }
                  }
                  if(!foundAccount) {
                    print("Nous ne trouvons pas de compte avec ce nom");
                  }
                }
                break;
              }
              break;
            case Commands.addAccount:
              stdout.write("Veuillez rentrer le nom du compte: ");
              String? accountName = stdin.readLineSync();
              if(accountName == null || accountName.isEmpty) {
                print("Veuillez remplir ce champ");
                return;
              }
              
              print("Veuillez rentrer le nombre associé à chaque permissions pour le rajouter au compte du compte: ");
              Map<int, Commands> permissions = {};
              List<Commands> choosenPermissions = [Commands.connectToAccount];
              int currentID = 1;
              for(Commands command in [Commands.addTask, Commands.removeTask, Commands.completeTask, Commands.listTask, Commands.clearTasks, Commands.addAccount, Commands.deleteAccount, Commands.connectToAccount]) {
                if(command != Commands.connectToAccount) {
                  permissions[currentID] = command;
                  print("$currentID) ${command.description}");
                  currentID++;
                }
              }
              while(true) {
                String? entry = stdin.readLineSync();
                if(entry == null || entry.isEmpty) {
                  break;
                } 
                int? interpretedEntry = int.tryParse(entry);
                if(interpretedEntry == null) {
                  print("Cette entrée n'est pas un nombre");
                  continue;
                }

                if(permissions.containsKey(interpretedEntry)) {
                  if(choosenPermissions.contains(permissions[interpretedEntry])) {
                    print("Vous avez déjà choisi cette permission");
                  } else {
                  choosenPermissions.add(permissions[interpretedEntry]!);
                  }
                } else {
                  print("Ce nombre n'est pas valide");
                }
              }

              Account createdAccount = Account.asNormal(accountName, choosenPermissions);
              storedAccounts[uuid.v4()] = createdAccount;
              print("Le compte a bien été créé !");
              break;
            case Commands.deleteAccount:
              int deletableAccounts = 0;
              for (Account account in storedAccounts.values) {
                if(!account.isAdmin) {
                  if(deletableAccounts == 0) print("Voici les comptes que vous pouvez supprimer: ");
                  print(account.name);
                  deletableAccounts++;
                }
              }

              if(deletableAccounts == 0) {
                print("Vous ne pouvez supprimer aucun comptes"); 
                break;
              }

              stdout.write("Quel compte voulez vous supprimer? ");
              String? accountName = stdin.readLineSync();
              if(accountName == null || accountName.isEmpty) {
                print("Veuillez renseigner ce champ");
                break;
              }

              for(Account account in storedAccounts.values) {
                if(account.name == accountName) {
                  if(!account.isAdmin) {
                    if(account != storedAccounts[currentAccount]) {
                      storedAccounts.remove(account);
                      print("Le compte $accountName a bien été supprimé !");
                    } else {
                      print("Vous ne pouveze pas supprimer votre compte actuel");
                    }
                  } else {
                    print("Vous ne pouvez pas supprimer ce compte administrateur");
                  }
                  break;
                }
              }

              break;
            case Commands.addTask:
              print("Veuillez renseigner le nom de cette tâche");
              String? taskName = stdin.readLineSync();
              if(taskName == null || taskName.isEmpty) {
                print("Veuillez remplir ce champ");
                break;
              }
              print("Veuillez renseigner la description de cette tâche");
              String? taskDescription = stdin.readLineSync();
              if(taskDescription == null || taskDescription.isEmpty) {
                print("Veuillez renseigner ce champ");
                break;
              }

              List<String> assigned = [];
              Map<int, Account> accounts = {};
              int currentID = 1;
              print("Voici la liste des comptes crées:");
              for(Account account in storedAccounts.values) {
                accounts[currentID] = account;
                print("$currentID) ${account.name}");
              }
              print("Veuillez rentrer les identifiants de chaque comptes qui auront cette tâche d'assigné");
              while(true) {
                String? assignedAccountRawID = stdin.readLineSync();
                if(assignedAccountRawID == null || assignedAccountRawID.isEmpty) {
                  break;
                }
                int? assignedAccountID = int.tryParse(assignedAccountRawID);
                if(assignedAccountID == null) {
                  print("Cette valeur n'est pas valide");
                  continue;
                }
                if(!accounts.containsKey(assignedAccountID)) {
                  print("Cette idantifiant de compte n'existe pas");
                  continue;
                }

                assigned.add(getIDOfAccount(accounts[assignedAccountID]!)!);
              }

              storedTasks.add(Task(assigned, taskName, taskDescription));
              break;
            case Commands.removeTask:
              if(storedTasks.isEmpty) {
                print("Aucune tâche n'a été rentrée pour l'instant");
                break;
              }
              print("Voici les tâches:");
              Map<int, Task> tasks = {};
              int currentID = 1;
              for(Task task in storedTasks) {
                if(storedAccounts[currentAccount]!.isAdmin || task.assigned.contains(currentAccount)) {
                  print("$currentID) ${task.title}: ${task.finished ? "fini" : "non fini"}");
                  tasks[currentID] = task;
                  currentID++;
                }
              }
              stdout.write("Quel tâche voulez vous supprimer?");
              String? rawTaskIDToDelete = stdin.readLineSync();
              if(rawTaskIDToDelete == null || rawTaskIDToDelete.isEmpty) {
                print("Veuillez remplir ce champ");
                break;
              }
              int? taskIDToDelete = int.tryParse(rawTaskIDToDelete);
              if(taskIDToDelete == null) {
                print("Cette entrée n'est pas un nombre");
                break;
              }

              if(!tasks.containsKey(taskIDToDelete)) {
                print("Ce nombre n'est pas valide");
                break;
              }

              storedTasks.remove(tasks[taskIDToDelete]);

              print("La tâche a bien été supprimée");
              break;
            case Commands.completeTask:
              if(storedTasks.isEmpty) {
                print("Aucune tâche n'a été rentrée pour l'instant");
                break;
              }
              print("Voici les tâches:");
              Map<int, Task> tasks = {};
              int currentID = 1;
              for(Task task in storedTasks) {
                if(storedAccounts[currentAccount]!.isAdmin || task.assigned.contains(currentAccount)) {
                  print("$currentID) ${task.title}: ${task.finished ? "fini" : "non fini"}");
                  tasks[currentID] = task;
                  currentID++;
                }
              }
              stdout.write("Quel tâche voulez vous marquer comme finie?");
              String? rawTaskIDToFinish = stdin.readLineSync();
              if(rawTaskIDToFinish == null || rawTaskIDToFinish.isEmpty) {
                print("Veuillez remplir ce champ");
                break;
              }
              int? taskIDToFinish = int.tryParse(rawTaskIDToFinish);
              if(taskIDToFinish == null) {
                print("Cette entrée n'est pas un nombre");
                break;
              }

              if(!tasks.containsKey(taskIDToFinish)) {
                print("Ce nombre n'est pas valide");
                break;
              }

              tasks[taskIDToFinish]!.finished = true;
              print("La tâche a bien été marquée comme finie");
              break;
            case Commands.listTask:
              
              if(storedTasks.isEmpty) {
                print("Aucune tâche n'a été rentrée pour l'instant");
                break;
              }
              print("Voici les tâches:");
              Map<int, Task> tasks = {};
              int currentID = 1;
              for(Task task in storedTasks) {
                if(storedAccounts[currentAccount]!.isAdmin || task.assigned.contains(currentAccount)) {
                  print("$currentID) ${task.title}: ${task.finished ? "fini" : "non fini"}");
                  tasks[currentID] = task;
                  currentID++;
                }
              }
              break;
            case Commands.clearTasks:
              storedTasks = [];
              print("Toutes les tâches ont bien été supprimés");
              break;
            default:
          }
        } else {
          print("Vous n'avez pas la permission d'exécuter cette commande");
        }
      }
      
    }
  }
}