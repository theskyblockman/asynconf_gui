class Commands {
  static const Commands addTask = Commands("ajouter", "ajouter une tâche");
  static const Commands removeTask = Commands("retirer", "retirer une tâche");
  static const Commands completeTask = Commands("compléter", "compléter une tâche");
  static const Commands listTask = Commands("liste", "lister toutes les tâches");
  static const Commands clearTasks = Commands("vider", "vider les tâches");
  static const Commands addAccount = Commands("ajouter-compte", "ajouter un compte");
  static const Commands deleteAccount = Commands("supprimer-compte", "supprimer un compte");
  static const Commands connectToAccount = Commands("connecter", "se connecter à un compte (par défaut)");
  final String name;
  final String description;
  const Commands(this.name, this.description);

  static Commands? fromString(String command) {
    String selectedCommand = command.split(" ").first.toLowerCase();
    for (Commands command in [addTask, removeTask, completeTask, listTask, clearTasks, addAccount, deleteAccount, connectToAccount]) {
      if(command.name == selectedCommand) return command;
    }
    return null;
  }
}